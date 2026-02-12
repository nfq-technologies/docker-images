#!/usr/bin/php
<?php

$image = trim(shell_exec("make -s get-image-name"));

$options = getOpt("", array("start", "stop"));
if (empty($options)) {
	$options = array("start" => true, "stop" => false);
}

if (isset($options["start"])) {
	 test_times(@glob('test/starting_in_*')[0], $image, 'start');
}

if (isset($options["stop"])) {
	test_times(@glob('test/stopping_in_*')[0], $image, 'stop');
}


function test_times($test, $image, $name='')
{
	if ( !is_file($test)) {
		return;
	}

	$defined = array();
	preg_match('#^.*_([0-9]*)_ms.*$#', $test, $defined);
	$defined = $defined[1];

	$times = array();
	$samples=10;
	printf("%s: [%'.{$samples}s] %s\r%s: [", $image, '', $name, $image);
	for ($i=1; $i<=$samples; $i++) {
		$cmd = "$test $image 2>/dev/null | grep -o [0-9]*";
		$result = (int)shell_exec($cmd);
		if ($result > 0) {
			$times[] = $result;
			echo "#";
		} else {
			echo "0";
		}
	}
	echo "\r" . $image . " => " . $name." => ";

	print_report($times, $defined);
}

function print_report($times, $defined)
{
	$max = max($times);
	$min = min($times);
	$dev = $max - $min;
	$raw_timeout = $max + (2*$dev);
	$timeout = round($raw_timeout, -2);

	printf("min: %d ; max %d ; dev: %d ; raw: %d ; timeout: %d ; defined: %d\n"
	, $min, $max, $dev, $raw_timeout, $timeout, $defined);

}

