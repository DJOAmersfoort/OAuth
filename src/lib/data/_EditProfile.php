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

require_once(__DIR__ . "/../Data.php");
//end

Data::getInstance()->registerHandler("EditProfile", function($data, $helper) {
	
	/**
	 * Data that should (or could) be received:
	 * - Email
	 * - firstName
	 * - surNamePrefix
	 * - surName
	 * - djoMemberRequest
	 * - Telephone number(s)
	 * - Address(es)
	 *	> street
	 *  > postalCode
	 *  > city
	 */
	
	$data["email"] = (String) strtolower($data["email"]);
	$data["firstName"] = (String) ucfirst(strtolower(preg_replace("/[^A-Za-z]/", '', $data["firstName"])));
	$data["surNamePrefix"] = (String) strtolower(preg_replace("/[^A-Za-z ]/", '', $data["surNamePrefix"]));
	$data["surName"] = (String) ucfirst(strtolower(preg_replace("/[^A-Za-z]/", '', $data["surName"])));
	 
	if(!$helper->getUser()->isLoggedIn()) {
		return $helper->error("U bent niet (meer) ingelogd, log in om uw gegevens aan te passen.");
	} else if(!isset($data["email"]) || $data["email"] == "") {
		return $helper->error("Vul een e-mailadres in.");
	} else if(!isset($data["firstName"]) || $data["firstName"] == "") {
		return $helper->error("Vul een voornaam in.");
	} else if(!isset($data["surName"]) || $data["surName"] == "") {
		return $helper->error("Vul een achternaam in.");
	}
	
	if(!$helper->getUser()->hasAccessTo("djoMember")) {
		if(!isset($data["djoMemberRequest"]) || $data["djoMemberRequest"] == "") {
			return $helper->error("Vul in of je lid bent van DJO.");
		}
		
		$data["djoMemberRequest"] == (int) $data["djoMemberRequest"];
		
		if($data["djoMemberRequest"] !== 0 || $data["djoMemberRequest"] !== 1) {
			return $helper->error("Geen geldig antwoord ontvangen.");
		}
	}
	
	return ["ok"];
	
}, function($data, $helper) {
	
	$db = $helper->getDb();
	
	$data["email"] = (String) strtolower($data["email"]);
	$data["firstName"] = (String) ucfirst(strtolower(preg_replace("/[^A-Za-z]/", '', $data["firstName"])));
	$data["surNamePrefix"] = (String) strtolower(preg_replace("/[^A-Za-z ]/", '', $data["surNamePrefix"]));
	$data["surName"] = (String) ucfirst(strtolower(preg_replace("/[^A-Za-z]/", '', $data["surName"])));
	
	try {
		$updateData =  [
			"firstname" => $data["firstName"],
			"middlename" => $data["surNamePrefix"],
			"lastname" => $data["surName"]
			
		];
		
		if($data["email"] != $helper->getUser()->getEmail()) {
			//Send new vertification email and add action on url
		}
		
		if(isset($data["djoMemberRequest"]) && $data["djoMemberRequest"] !== "") {
			$updateData["djoMemberRequest"] = (int) $data["djoMemberRequest"];
		}
		
		$db->where("id", $helper->getUser()->getId())->update("users", $updateData);
		
	} catch(Exception $e) {
		return $helper->error("Er ging iets mis bij het opslaan van je gegevens.");
	}
	
	return ["savedProfile" => true];
	
});

// For testing purposes
$data->handleFromRequest([
	"type" => "EditProfile",
	"email" => "yoeri.otten@live.nl", 
	"firstName" => "Jan", 
	"surNamePrefix" => "van der",
	"surName" => "sloot"
]);