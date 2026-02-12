#!/usr/bin/php
<?php

$image = trim(shell_exec("basename $(pwd)"));
$group = trim(shell_exec("basename $(dirname $(pwd))"));
if ($image != 'nfqlt' && $image != 'private') {
	$path = '../';
} else {
	$path = './';
}
$parent_image = sprintf("%s/%s/", $group, $image);
$level = ($argc>1)?$argv[1]:0;


# make child -> parent ralations array
$relations = getRelationsList($path);


# make tree
$tree = relationsToTree($relations);


# leave only requested branch
$tree = getBranchFromTree($parent_image, $tree);


# leave only requested level
$tree = getLevelFromTree($level, $tree);


# make sorted list
$sorted = treeToSortedList($tree);


# print sorted list
printSortedList($sorted);





# ============================================================================

function getRelationsList($path = './')
{
	chdir($path);
	$_relations = array();

	$docker_files=shell_exec("/usr/bin/find ./ -type f -name Dockerfile");
	$docker_files=explode("\n", $docker_files);

	foreach ($docker_files as $docker_file) {
		if (empty($docker_file)) {
			continue;
		}
		$docker_file = trim($docker_file);
		$path_data = explode("/", $docker_file);
		array_shift($path_data); // removes ./ at the begining
		array_pop($path_data); // removes Dockerfile at the end
		$docker_user = array_shift($path_data);
		$docker_image = implode("_", $path_data);

		$parent_image = shell_exec("/bin/grep ^FROM '$docker_file' | /usr/bin/cut -d' ' -f2");
		$parent_image = trim($parent_image);
		$parent_image = str_replace("docker.nfq.lt/", "", $parent_image);
		list($parent_image) = explode(':', $parent_image);

		$this_type = shell_exec('basename $(pwd)');
		$this_type = trim($this_type);

		$_relations[$this_type.'/'.$docker_user.'/'.$docker_image] = $parent_image.'/';
	}
	return $_relations;
}

function relationsToTree($relations)
{
	# get roots (skipping first level)
	$first_level = array();
	foreach ($relations as $child => $parent) {
		if (!isset($relations[$parent])) {
			// skipping parents from library
			$first_level[$child] = true;
			$tree[$child] = array();
		}
	}
	foreach (array_keys($first_level) as $child) {
		unset($relations[$child]);
	}

	# put everything into the tree
	while (!empty($relations)) {
        foreach ($relations as $child => $parent) {
			$ref = &refElementInArray($parent, $tree);
			if (is_array($ref)) {
				unset($relations[$child]);
				$ref[$child] = array();
			}
        }
	}

	return $tree;
}

function relationsToSortedList($relations)
{
	$sorted = array();
	while (!empty($relations)) {
		$tier = array();
		foreach ($relations as $child => $parent) {
			if (!isset($relations[$parent])) {
				$tier []= $child;
			}
		}
		foreach ($tier as $child) {
			unset($relations[$child]);
		}
		$sorted = array_merge($sorted, $tier);
	}
	return $sorted;
}

function treeToSortedList($tree)
{
	$sorted = array_keys($tree);

	foreach ($tree as $v) {
		if (!empty($v)) {
			$sorted = array_merge($sorted, treeToSortedList($v));
		}
	}
	return $sorted;
}

function printSortedList($sorted)
{
	foreach ($sorted as $val) {
		$dir = explode('/', $val)[1];
		echo $dir.' ';
	}
}

function &refElementInArray($key, &$array)
{
	if (array_key_exists($key,$array)) {
		return $array[$key];
	} else {
		$return = false;
		foreach ($array as &$value) {
			if (is_array($value) && $return === false) {
				$return = &refElementInArray($key, $value);
			}
		}
		return $return;
	}
}

function getBranchFromTree($key, $tree)
{
	$branch = refElementInArray($key, $tree);
	if ($branch === false) {
		return $tree;
	}
	return $branch;
}

function getLevelFromTree($level, $tree)
{
	if ($level < 1) {
		return $tree;
	}

	// get rid of parents
	for (; $level>1; $level--) {
		$new_tree = array();
		foreach ($tree as $key => $value) {
			$new_tree = array_merge($new_tree, $value);
		}
		$tree = $new_tree;
	}

	// get rid of children
	foreach ($tree as &$val) {
		$val = array();
	}

	return $tree;
}

