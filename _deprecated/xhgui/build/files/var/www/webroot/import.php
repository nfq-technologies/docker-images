<?php
if (!defined('XHGUI_ROOT_DIR')) {
    require dirname(dirname(__FILE__)) . '/src/bootstrap.php';
}

$container = Xhgui_ServiceContainer::instance();
$saver = $container['saver'];

$data = json_decode(file_get_contents('php://input'), true);
if ($data) {
    $saver->save($data);
}
