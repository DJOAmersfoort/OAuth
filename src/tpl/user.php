<?php
if(isset($pagetocheck[1]) && $pagetocheck[1] != "" && $user->hasAccessTo("userdata")) {
	
	if($user->getId() == $pagetocheck[1]) {
		header("Location: /ik");
		exit();
	}
	
	try {
		$viewUser = User::create()->fromId($pagetocheck[1]);
		$canEditUser = $user->hasAccessTo("editUserInfo") && $user->getRank() >= $viewUser->getRank();
		$canRemoveUser = $user->hasAccessTo("deleteUser");
		$pagename = "Gebruiker";
		$subpagename = $viewUser->getFullName()["firstName"]. $m->render(file_get_contents("tpl/user_edittoolsadmin.tpl"), [
			"userId" => $viewUser->getId(),
			"currentUserHasAccessToEditUser" => $canEditUser,
			"canRemoveUser" => $canRemoveUser
		]);

		$rp = [
			"firstName" => $viewUser->getFullName()["firstName"],
			"familyName" => $viewUser->getFullName()["familyName"],
			"surName" => isset($viewUser->getFullName()["surName"]) && $viewUser->getFullName()["surName"] != false ? $viewUser->getFullName()["surName"] : "",
			"email" => $viewUser->getEmail(),
			"user_id" => $viewUser->getId(),
			"rank" => $viewUser->getRankInText(),
			"addresses" => $viewUser->getUserAdresses(),
			"2fa" => $viewUser->isTwoFactorAuthOn(),
			"apps" => [],
			"djomember" => $viewUser->hasDjoMemberRequest() && $viewUser->getRank() == 0,
			"inactivated" => $viewUser->getRank() <= -1,
			"currentUserHasAccessToEditUser" => $canEditUser,
			"ranksAccessible" => [],
			"canRemoveUser" => $canRemoveUser,
			"canTurnOff2StepAuth" => $user->hasAccessTo("turnOff2StepAuthforOtherUsers")
		];
		
		if($canEditUser) {
			foreach($user->getRanks() as $rankNum=>$rank) {
				if($rankNum-1 < $user->getRank()) {
					$rp["ranksAccessible"][]["name"] = $rank;
					$rp["ranksAccessible"][$rankNum]["isSelected"] = $rankNum-1 == $viewUser->getRank();
					$rp["ranksAccessible"][$rankNum]["value"] = $rankNum-1;
				}
			}
		}
		
		//array_reverse($rp["ranksAccessible"]);

		for($i = 0; $i < count($viewUser->getApps()); $i++) {
			$rp["apps"][] = [
				"id" => $i,
				"user_id" => $viewUser->getAppData($i)["user_id"],
				"name" => $viewUser->getAppData($i)["name"],
				"read" => in_array("read", $viewUser->getAppAccess($i)),
				"write" => in_array("write", $viewUser->getAppAccess($i))
			];
		}

		$pagecontents = $m->render(file_get_contents("tpl/user.tpl"), $rp);
	} catch(Exception $e) {
	
		//Lol just say the page doesn't exist :D
		require_once("tpl/404.php");
	}
} else {
	require_once("tpl/404.php");
}