<?php
$error = "";

require_once("lib/base.php");

$pagetocheck = isset($_GET["p"]) && filter_input(INPUT_GET, "p") != "" ? explode("-", filter_input(INPUT_GET, "p")) : array("index");

$nogloggedinvisible = array("index", "login", "aanmelden", "developers", "register");
$page = $error != "" ? "error" : (!$user->isLoggedIn() ? (in_array($pagetocheck[0], $nogloggedinvisible) ? (file_exists("tpl/".$pagetocheck[0].".php") ? $pagetocheck[0] : "404") : "404") : (file_exists("tpl/".$pagetocheck[0].".php") ? $pagetocheck[0] : "404"));

//Set default variables
$pagecontents = "";
$pagename = "OAuth";
$subpagename = "";

$lay = new Layout($config, !isset($_SERVER["HTTP_X_PJAX"]));

require_once("tpl/".$page.".php");

//Menu
$lay->registerMenu("documentatie", "developers");
$lay->registerMenu("gebruikers", "users", ["rank" => "userslist"]);
$lay->registerMenu("aanmelden", "register", ["rank" => -2, "position" => "right"]);
$lay->registerMenu("inloggen", "login", ["rank" => -2, "position" => "right"]);
if ($user->isLoggedIn()) {
	$lay->registerMenu(
		"<i class=\"glyphicon glyphicon-user\"></i> " . $user->getFullName()["firstName"] . "&nbsp;<span class=\"label label-white\" title=\"" . $user->getRankInText() . "\">" . $user->getRankInText() . "</span>",
		"ik",
		[
			"position" => "right",
			"subMenu" => [
				["name" => "<span class=\"glyphicon glyphicon-user\"></span> Mijn Profiel", "pageurl" => "me", "header" => "Account"],
				["name" => "<span class=\"glyphicon glyphicon-list-alt\"></span> Mijn Apps", "pageurl" => "apps"],
				["divider" => true, "name" => "<span class=\"glyphicon glyphicon-lock\"></span> Uitloggen", "header" => "Sessie", "pageurl" => "logout"]
			]
		]
	);
}

//Page rendering
$lay->addReplace("page", $pagecontents);
echo $lay->ParsePage();
