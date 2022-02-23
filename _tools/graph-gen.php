#!/usr/bin/php
<?php

define("ROOT_DIR", dirname(__DIR__));
define("OUT_DIR", ROOT_DIR.'/_docs/media');

if ( ! extension_loaded('gv') ) {
        touch(OUT_DIR."/image_relations.gv");
        touch(OUT_DIR."/image_relations.png");

        $cmd="docker run -it --rm \
                -v /home/project/images/nfqlt:/home/project/images/nfqlt:ro \
                -v /home/project/images/nfqlt/_docs:/home/project/images/nfqlt/_docs:rw \
                nfqlt/php74-cli \
                bash -c '\
                    phpenmod gv ;\
                    /home/project/images/nfqlt/_tools/graph-gen.php' ;\
                    chown -R 1000:1000 /home/project/images/nfqlt/_docs ;\
        ";
        exec($cmd, $output);
        //print_r($output);
        exit(0);
}


require_once('/usr/lib/x86_64-linux-gnu/graphviz/php/gv.php');


$ir = new ImageRelations(ROOT_DIR);
$ir->writeGv(OUT_DIR."/image_relations.gv");
$ir->writePng(OUT_DIR."/image_relations.png");



class ImageRelations
{

	private $_gv_filename;
	private $_png_filename;
	private $_images_path;
	private $_relations;
	private $_gv_data;
	private $_gv_header = "
digraph G {
    label=\"Image relations\";
    graph [fontname=sans];
    node [style=filled shape=box fontname=sans fillcolor=white];
    rankdir=\"LR\";
	\n";
	private $_gv_footer = "}\n";

	public function __construct($images_path)
	{
		$this->_images_path = $images_path;
		$this->generateRelations();
		$this->generateGvData();
	}

	private function generateRelations()
	{
		$docker_files=shell_exec("cd {$this->_images_path}; /usr/bin/find ./ -type f -name Dockerfile | sort");
		$docker_files=explode("\n", $docker_files);
		foreach ($docker_files as $docker_file) {
			if (empty($docker_file)) {
				continue;
			}
			$docker_file = trim($docker_file);
			$path_data = explode("/", $docker_file);
			array_shift($path_data);
			array_pop($path_data);
			$docker_image = implode("_", $path_data);
	
			$parent_image = shell_exec("cd {$this->_images_path}; /bin/grep ^FROM '$docker_file' | /usr/bin/cut -d' ' -f2");
			$parent_image = explode(":", $parent_image);
			$parent_image = $parent_image[0];
			$parent_image = trim($parent_image);
			$parent_image = str_replace("sandbox-docker.nfq.lt/", "", $parent_image);
			$parent_image = str_replace("docker.nfq.lt/", "", $parent_image);

			$this->_relations['nfqlt/'.$docker_image] = $parent_image;
		}
	}

	private function generateGvData()
	{
		$this->_gv_data = $this->_gv_header;
		foreach ($this->_relations as $child => $parent) {
			$this->addRelationalUnit($parent, $child);
		}
		$this->_gv_data .= $this->_gv_footer;
	}

	private function addRelationalUnit($parent, $child)
	{
			$label = explode('/', $child, 2)[1];
            $this->_gv_data .= sprintf('    "%s" [fillcolor=%s label="%s"];'."\n"
				, $child
				, "orange"
				, $label
			);
            $this->_gv_data .= sprintf('    "%s"->"%s";'."\n", $parent, $child);
	}

	public function writeGv($filename)
	{
		$this->_gv_filename = $filename;
		file_put_contents($filename, $this->_gv_data);
	}

	public function getGvFilename()
	{
		return $this->_gv_filename;
	}

	public function writePng($filename)
	{
		$this->_png_filename = $filename;
		$gv_file = $this->getGvFilename();
		$g = gv::read( $gv_file );
		gv::layout($g, 'dot');
		$res = gv::render( $g, 'png', $filename );
	}
}

