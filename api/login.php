<?php
if(!isset($_SERVER['HTTPS'])) {
	//header("Location: https://".$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]);
}
$file = file_get_contents("./appauth.tpl");
$file = str_replace("{{url}}", "//".$_SERVER["HTTP_HOST"], $file);
echo $file;
