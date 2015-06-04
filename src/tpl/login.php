<?php
if(!$user->isLoggedIn()) {
	if(isset($pagetocheck[1]) && $pagetocheck[1] == "forgot") {
		$subpagename = "Wachtwoord vergeten";
		$pagename = "Inloggen";
		$pagecontents .= file_get_contents("tpl/login_forgot.tpl");
	} else {
		$pagename = "Inloggen";
		$pagecontents .= file_get_contents("tpl/login.tpl");
	}
} else {
	require_once("tpl/404.php");
}