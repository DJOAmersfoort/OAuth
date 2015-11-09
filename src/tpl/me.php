<?php
require_once("lib/2fa.php");
if(!isset($pagetocheck[1])) {

	$pagename = "Mijn profiel";
	$subpagename = $user->getFullName()["firstName"];

	$rp = [
		"firstName" => $user->getFullName()["firstName"],
		"familyName" => $user->getFullName()["familyName"],
		"surName" => isset($user->getFullName()["surName"]) && $user->getFullName()["surName"] != false ? $user->getFullName()["surName"] : "",
		"email" => $user->getEmail(),
		"id" => $user->getId(),
		"rank" => $user->getRankInText(),
		"addresses" => $user->getUserAdresses(),
		"2fa" => $user->isTwoFactorAuthOn(),
		"apps" => []
	];

	for($i = 0; $i < count($user->getApps()); $i++) {
		$rp["apps"][] = [
			"id" => $i,
			"name" => $user->getAppData($i)["name"],
			"read" => in_array("read", $user->getAppAccess($i)),
			"write" => in_array("write", $user->getAppAccess($i))
		];
	}

	$pagecontents = $m->render(file_get_contents("tpl/me.tpl"), $rp);

} elseif(isset($pagetocheck[1]) && $pagetocheck[1] == "2stepauth") {
	if($user->isTwoFactorAuthOn() == false) {
		if(isset($pagetocheck[2]) && $pagetocheck[2] == "check") {
			$pagename = "2-staps authenticatie";
			$pagecontents .= file_get_contents("tpl/me_auth_check.tpl");
			$subpagename = "Activeren";
		} elseif(isset($pagetocheck[2]) && $pagetocheck[2] != "") {
			require_once("tpl/404.tpl");
		} else {
			//Generate a key
			if($user->hasTwoFactorAuthToken() == false) {
				$secret = TwoFactorAuth::generate_secret_key();
				$db->insert("users_2step", array("isOn" => 0, "secret" => $secret, "user_id" => $user->getId()));
				$user->setTwoFactorAuthToken($secret);
			}
			$pagename = "2-staps authenticatie";
			$pagecontents .= $m->render(file_get_contents("tpl/me_auth.tpl"), [
				"token" => $user->getTwoFactorAuthToken(),
				"qrurl" => urlencode("otpauth://totp/". $user->getFullName()["fullName"] ."@DJO OAuth?secret=". $user->getTwoFactorAuthToken())
			]);
			$subpagename = "Activeren";
		}
	} else {
		if(isset($pagetocheck[2]) && $pagetocheck[2] != "") {
			require_once("tpl/404.php");
		} else {
			$pagename = "2-staps authenticatie";
			$pagecontents .= file_get_contents("tpl/me_auth_disable.tpl");
			$subpagename = "Uitschakelen";
		}

	}
} elseif(isset($pagetocheck[1]) && $pagetocheck[1] == "edit") {

	$pagename = "Mijn profiel";
	$subpagename = "Aanpassen";
	$name = $user->getFullName();
	$pagecontents = $m->render(file_get_contents("tpl/me_edit.tpl"), [
		"djo" => $user->hasAccessTo("djoMember"),
		"wantsDjo" => $user->hasDjoMemberRequest(),
		"email" => $user->getEmail(),
		"firstname" => $name["firstName"],
		"lastname" => $name["familyName"],
		"tussenvoegsel" => isset($name["surName"]) ? $name["surName"] : ""

	]);

}
