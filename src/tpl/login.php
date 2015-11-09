<?php
if(!$user->isLoggedIn()) {
	if(isset($pagetocheck[1]) && $pagetocheck[1] == "forgot") {
		$subpagename = "Wachtwoord vergeten";
		$pagename = "Inloggen";
		$pagecontents .= file_get_contents("tpl/login_forgot.tpl");
	} else {
		$pagename = "Inloggen";
		//"userHasJustLoggedOut" => isset($_SESSION["hasloggedout"]) && $_SESSION["hasloggedout"] == true
		if(isset($_SESSION["hasloggedout"]) && $_SESSION["hasloggedout"] == true) {
			unset($_SESSION["hasloggedout"]);
		}

		$pagecontents .= file_get_contents("tpl/login.tpl");
	}
} else {
	header("Location: ./me");
	exit();
}
