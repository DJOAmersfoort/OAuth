<?php
if($user->isLoggedIn()) {
	session_unset();
	$_SESSION["hasloggedout"] = true;
	unset($_COOKIE["login"]);
	setcookie("login", null, -1, '/');
	header("Location: /");
	exit();
} else {
	require_once("tpl/404.php");
}
?>