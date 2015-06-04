<?php
if(!$user->isLoggedIn()) {
	if(isset($_SESSION["hasregistered"]) && $_SESSION["hasregistered"] == true) {
		
		$pagename = "Aanmelden";
		$pagecontents .= $m->render(file_get_contents("tpl/aanmelden_compleet.tpl"), [
			"djomember" => isset($_SESSION["djoregistered"]) && $_SESSION["djoregistered"] == true,
			"email" => $_SESSION["emailregistered"]
		]);
		unset($_SESSION["hasregistered"]);
		unset($_SESSION["emailregistered"]);
		unset($_SESSION["djoregistered"]);
		
	} else {
		if(isset($pagetocheck[1]) && $pagetocheck[1] != "" && strlen($pagetocheck[1]) == 21) {
			$binder = "%$".$pagetocheck[1]."%";
			if($result = $db->where("rank", -1)->where("password", array($binder, "LIKE"))->get("users", 1)) {
				if(count($result) > 0 && substr($result[0]["password"], 7, 21) == $pagetocheck[1]) {
					$db->where("email", $result[0]["email"])->update("users", array("rank" => 0));
					
					$pagename = "Aanmelden";
					$pagecontents .= str_replace("\n", "\n\t\t", file_get_contents("tpl/aanmelden_klaar.tpl"));
				} else {
					$error = "Onbekende aanmeld key";
					require_once("tpl/error.php");
				}
			} else {
				$error = "Onbekende aanmeld key";
				require_once("tpl/error.php");
			}
		} else {
			$pagename = "Aanmelden";
			$captcha = generateCaptcha();
			$_SESSION["captcha"] = $captcha[1];
			$pagecontents .= $m->render(file_get_contents("tpl/aanmelden.tpl"), ["captcha" => $captcha[0]]);
		}
	}
} else {
	require_once("tpl/404.php");
}
?>