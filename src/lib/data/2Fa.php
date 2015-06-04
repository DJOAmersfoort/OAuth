<?php

Data::getInstance()->registerHandler("2fa_check", function($data, $helper) {
	global $user;
	
	if($user->isTwoFactorAuthOn() == true) {
		return $helper->error("2-staps authenticatie is al aan.");
	} elseif(!isset($data["code"])) {
		return $helper->error("Niet alles ontvangen.");
	} elseif($data["code"] == "") {
		return $helper->error("Vul een code in.");
	} elseif(strlen($data["code"]) < 4 || strlen($data["code"]) > 6) {
		return $helper->error("De code is te lang/kort.");
	} else {
		return ["ok"];
	}
}, function($data, $helper) {
	global $user;
	if(TwoFactorAuth::verify_key($user->getTwoFactorAuthToken(), $data["code"]) == true) {
		$helper->db->where("user_id", $user->getId())->update("users_2step", ["isOn" => 1]);
		return ["success" => "true"];
	} else {
		return $helper->error("Verkeerde code ontvangen.");
	}
});

Data::getInstance()->registerHandler("2fa_disable", function($data, $helper) {
	global $user;
	
	if($user->isTwoFactorAuthOn() == false) {
		return $helper->error("2-staps authenticatie staat nog niet aan.");
	} elseif(!isset($data["code"])) {
		return $helper->error("Niet alles ontvangen.");
	} elseif($data["code"] == "") {
		return $helper->error("Vul een code in.");
	} elseif(strlen($data["code"]) < 4 || strlen($data["code"]) > 6) {
		return $helper->error("De code is te lang/kort.");
	} else {
		return ["ok"];
	}
}, function($data, $helper) {
	global $user;
	if(TwoFactorAuth::verify_key($user->getTwoFactorAuthToken(), $data["code"]) == true) {
		$helper->db->where("user_id", $user->getId())->delete("users_2step");
		return ["success" => "true"];
	} else {
		return $helper->error("Verkeerde code ontvangen.");
	}
});