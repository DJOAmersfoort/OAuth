<?php

require_once(__DIR__."/../vendor/autoload.php");

require_once(__DIR__."/config.php");

require_once(__DIR__."/Autoloader.php");
Autoloader::initialize();

header('X-Frame-Options: sameorigin');
header('X-XSS-Protection: 1; mode=block');

date_default_timezone_set("Europe/Amsterdam");

if($config["devmode"] == true) {
	ini_set('error_reporting', E_ALL);
	error_reporting(E_ALL);
}

if (session_status() == PHP_SESSION_NONE) {
	session_set_cookie_params((3600*12));
  session_start();
}

if(isset($_GET["phpinfo"])) {
	phpinfo();
	exit();
}

if($config["maintenance"] && !isset($_SESSION["maint"]) && !isset($api)) {
	exit(file_get_contents("tpl/maintenance.tpl"));
}

require_once(__DIR__ . "/passwordhash.php");

function htmlspecial_array(&$variable) {
	foreach ($variable as &$value) {
		if (!is_array($value)) {
			$value = htmlspecialchars($value);
		} else {
			htmlspecial_array($value);
		}
	}
}

$m = new Tpl;
$db = new Mysqlidb($config["db"]["host"], $config["db"]["user"], $config["db"]["pass"], $config["db"]["db"]);

//Create user from session or cookie
$user = User::create()->fromSessions();

if(!$user->isLoggedIn() && isset($_COOKIE["login"]) && $_COOKIE["login"] != "") {
	$user->fromCookie($_COOKIE["login"]);
}

require_once(__DIR__."/formkey.php");
require_once(__DIR__."/layout.php");

if (!function_exists('getallheaders')) {
	function getallheaders() {
		$headers = [];
		foreach ($_SERVER as $name => $value) {
			if (substr($name, 0, 5) == 'HTTP_') {
				$headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
			}
		}
		return $headers;
	}
}

function getUserIP() {
	$client  = @$_SERVER['HTTP_CLIENT_IP'];
	$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
	$remote  = $_SERVER['REMOTE_ADDR'];
	if(filter_var($client, FILTER_VALIDATE_IP)) {
		$ip = $client;
	} elseif(filter_var($forward, FILTER_VALIDATE_IP)) {
		$ip = $forward;
	} else {
		$ip = $remote;
	}
	return $ip;
}

function generateCaptcha() { //returns ["question", "answer"]
	$type = rand(0, 2);
	if($type == 0) {
		$answer = rand(1,9);
		return(array("Wat is &#8730;".($answer*$answer), $answer));
	} elseif($type == 1) {
		$answer1 = rand(0,10);
		$answer2 = rand(1,20);
		return(array("Wat is ".$answer1."*".$answer2, $answer1*$answer2));
	} elseif($type == 2) {
		$answer1 = rand(0,100);
		$answer2 = rand(1,1000);
		return(array("Wat is ".$answer1."+".$answer2, $answer1+$answer2));
	}
}

function checkPassword($password) {
	$score = 1;

	if (strlen($password) < 1)
		return 0;
	if (strlen($password) < 4)
		return 1;
	if (strlen($password) >= 8)
		$score++;
	if (strlen($password) >= 10)
		$score++;
	if (preg_match("/\d+/", $password))
		$score++;
	if (preg_match("/[a-z]/", $password))
		$score++;
	if (preg_match("/.[!,@,#,$,%,^,&,*,?,_,~,-,£,(,)]/", $password))
		$score++;
	if (strlen($password) <= 6)
		$score--;

	return $score;
}

if(isset($_GET["p"]) && $_GET["p"] === "data") {
	require_once(__DIR__."/Data.php");
	$data->handleFromRequest($_POST);
}
?>
