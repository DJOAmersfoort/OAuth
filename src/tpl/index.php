<?php
$pagename = "DJO Authorisatie";
$subpagename = "";
$pagecontents = $m->render(file_get_contents("tpl/index.tpl"), [
	"isNotLoggedIn" => !$user->isLoggedIn(),
	"userHasJustLoggedOut" => isset($_SESSION["hasloggedout"]) && $_SESSION["hasloggedout"] == true
]);
if(isset($_SESSION["hasloggedout"]) && $_SESSION["hasloggedout"] == true) {
	unset($_SESSION["hasloggedout"]);
}

if($user->isLoggedIn()) {
  header("Location: ./ik");
} else {
  header("Location: ./login");
}
exit();