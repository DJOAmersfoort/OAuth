<?php
Data::getInstance()->registerHandler("EditRank", function($data, $helper) {
	
	if(!$helper->getUser()->isLoggedIn() || !$helper->getUser()->hasAccessTo("editUserInfo")) {
		return $helper->error("U heeft hier geen rechten. Kunt u alstublieft opzouten?");
	}
	

	if(!isset($data["rank"]) || $data["rank"] == "") {
		return $helper->error("Geen nieuwe rang ontvangen.1");
	}
	
	$data["rank"] = (int) $data["rank"];

	if($data["rank"] < -1 || $data["rank"] >= count($helper->getUser()->getRanks())) {
		return $helper->error("Deze rang bestaat niet.");
	} elseif($data["rank"] >= $helper->getUser()->getRank()) {
		return $helper->error("U mag deze rang niet toewijzen.");
	} elseif(!isset($data["id"]) || $data["id"] == "") {
		return $helper->error("Geen gebruikers ID opgegeven.");
	} elseif(!is_numeric($data["id"])) {
		return $helper->error("De gebruikers ID moet een nummer zijn.");
	} elseif($data["rank"] >= $helper->getUser()->getRank()) {
		return $helper->error("U moet een rang opgeven onder die van u.");
	}
	
	try {
		$editUser = User::create()->fromId((int) $data["id"]);
	} catch(Exception $e) {
		return $helper->error("De gebruiker bestaat niet.");
	}
	
	if($editUser->getRank() >= $helper->getUser()->getRank()) {
		return $helper->error("U mag geen nieuwe rang toewijzen aan deze gebruiker.");
	} elseif($data["rank"] == $editUser->getRank()) {
		return $helper->error("De gebruiker heeft deze rang al.");
	}
	
	
	
	return ["ok"];
	
}, function($data, $helper) {
	
	$data["rank"] = (int) $data["rank"];
	$data["id"] = (int) $data["id"];
	
	try {
		$editUser = User::create()->fromId($data["id"]);
		$editUser->setRank($data["rank"]);
	} catch(Exception $e) {
		return $helper->error("Er ging iets mis bij het aanpassen van de rang.");
	}
	
	return ["changedRank" => true];
	
});