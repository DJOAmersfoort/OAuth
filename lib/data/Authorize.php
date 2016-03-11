<?php

Data::getInstance()->registerHandler("machtigen", function($data, $helper) {
	if(!isset($data["pass"]) || $data["pass"] == "" || !isset($data["app"]) || $data["app"] == "" ) {
		return $helper->error("Niet alles ontvangen");
	} else {
		return ["ok"];
	}
}, function($data, $helper) {
	global $_COOKIE, $user;
	if($user->checkPassword($data["pass"]) == true) {
		$insertdata = array("client_id" => $_POST["app"], "access" => "[\"read\"]", "user_id" => $user->getId());
		$helper->db->insert("users_apps", $insertdata);
		return ["isauthorized" => true];
	} else {
		return $helper->error("Verkeerd wachtwoord.");
	}
});

?>