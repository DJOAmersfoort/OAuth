<?php
if(!isset($_SERVER['HTTPS'])) {
	header("Location: https://".$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]);
}
echo file_get_contents("./appauth.tpl");