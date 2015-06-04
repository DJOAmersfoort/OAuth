<?php
if($user->hasAccessTo("userslist")) {
	$pagename = "Gebruikers";
	
	//Get all users
	$users = $db->get("users");
	$userslist = [[], [], [], [], [], [], []];
	for($i = 0; $i < count($users); $i++) {
		$users[$i]["rang"] = $user->getRanks()[$users[$i]["rank"]+1];
		$users[$i]["data"] = json_decode($users[$i]["data"], true);
		$users[$i]["color"] = $users[$i]["rank"] <= -1 ? "danger" : ($users[$i]["rank"] == 0 && isset($users[$i]["djoMemberRequest"]) && $users[$i]["djoMemberRequest"] == 1 ? "warning" : "success");
		$userslist[$users[$i]["rank"]+1]["users"][] = $users[$i];
	}
	for($i = 0; $i < count($userslist); $i++) {
		$userslist[$i]["title"] = $user->getRanks()[$i];
		$userslist[$i]["count"] = isset($userslist[$i]["users"]) ? count($userslist[$i]["users"]) : 0;
	}
	$pagecontents = $m->render(file_get_contents("tpl/users.tpl"), ["users_rangs" => array_reverse($userslist)]);
	
} else {
	require_once("tpl/404.php");
}