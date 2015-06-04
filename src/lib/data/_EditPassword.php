<?php

// For testing purposes
session_start();
require_once(__DIR__ . "/../config.php");
require_once(__DIR__ . "/../Mysqlidb.php");
require_once(__DIR__ . "/../User.php");

$db = new Mysqlidb($config["db"]["host"], $config["db"]["user"], $config["db"]["pass"], $config["db"]["db"]);
$user = User::create()->fromSessions();

if(!$user->isLoggedIn() && isset($_COOKIE["login"]) && $_COOKIE["login"] != "") {
	$user->fromCookie($_COOKIE["login"]);
}

require_once(__DIR__ . "/../data.php");
//end

Data::getInstance()->registerHandler("type", function($data, $helper) {
	
	/*
	 * Check if user has sufficient rights and correct data has been recieved
	 */
	
	return $helper->error("Er was een error.");
	
	return ["ok"];
	
}, function($data, $helper) {
	
	/*
	 * Edit all the things!
	 */
	
	return ["changedThatThing" => true];
	
});

// For testing purposes
$data->handleFromRequest(["type" => "type"]);