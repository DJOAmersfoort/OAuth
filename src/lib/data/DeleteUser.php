<?php
Data::getInstance()->registerHandler("DeleteUser", function($data, $helper) {
	
	/*
	 * Needed: user to delete (user_id), current logged in users' password
	 * "id", "password"
	 * important: check if logged in and user has sufficient rights
	 */
	
	if(!$helper->getUser()->isLoggedIn() || !$helper->getUser()->hasAccessTo("deleteUser")) {
		return $helper->error("U heeft hier geen rechten. Kunt u alstublieft opzouten?");
	} elseif(!isset($data["password"]) || $data["password"] == "") {
		return $helper->error("Vul een wachtwoord in.");
	} elseif(!$helper->getUser()->checkPassword($data["password"])) {
		return $helper->error("Wachtwoord komt niet overeen.");
	} elseif(!isset($data["id"]) || $data["id"] == "") {
		return $helper->error("Geen gebruikers ID opgegeven.");
	} elseif(!is_numeric($data["id"])) {
		return $helper->error("De gebruikers ID moet een nummer zijn.");
	}
	
	$data["id"] = (int) $data["id"];
	
	try {
		$editUser = User::create()->fromId((int) $data["id"]);
	} catch(Exception $e) {
		return $helper->error("De gebruiker bestaat niet.");
	}
	
	if($editUser->getRank() >= $helper->getUser()->getRank()) {
		return $helper->error("U mag deze gebruiker niet verwijderen.");
	}
	
	return ["ok"];
	
}, function($data, $helper) {
	
	$data["id"] = (int) $data["id"];
	try {
		$helper->getDb()->where("id", $data["id"])->delete("users");
	} catch(Exception $e) {
		return $helper->error("Er ging iets mis bij het verwijderen.");
	}
	
	return ["userIsDeleted" => true];
	
});