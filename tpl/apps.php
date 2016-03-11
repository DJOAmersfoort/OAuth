<?php
if(isset($pagetocheck[1]) && $pagetocheck[1] != "") {
	if(isset($user->getApps()[$pagetocheck[1]])) {
		
		//Access stuff
		$tpl_access_read = "<div class=\"col-sm-10 col-xs-10 col-sm-offset-1 col-xs-offset-1\">\n\t<div class=\"pull-left\">\n\t\t<span class=\"glyphicon glyphicon-eye-open\" style=\"font-size: 26px; margin-top: 6px;\"></span>\n\t</div>\n\t<div class=\"visible-lg\">\n\t\t<div class=\"pull-right\" style=\"margin-top: 2px;\">\n\t\t\t<span style=\"font-size: 22px;\">Deze app kan uw gegevens lezen</span>\n\t\t</div>\n\t</div>\n\t<div class=\"hidden-lg\">\n\t\t<div class=\"pull-right\" style=\"margin-top: 7px;\">\n\t\t\t<span style=\"font-size: 16px;\">Deze app kan uw gegevens lezen</span>\n\t\t</div>\n\t</div>\n</div>\n";
		$tpl_access_write = "<div class=\"col-sm-10 col-xs-10 col-sm-offset-1 col-xs-offset-1\">\n\t<div class=\"pull-left\">\n\t\t<span class=\"glyphicon glyphicon-edit\" style=\"font-size: 26px; margin-top: 6px;\"></span>\n\t</div>\n\t<div class=\"visible-lg\">\n\t\t<div class=\"pull-right\" style=\"margin-top: 2px;\">\n\t\t\t<span style=\"font-size: 22px;\">Deze app kan uw gegevens aanpassen</span>\n\t\t</div>\n\t</div>\n\t<div class=\"hidden-lg\">\n\t\t<div class=\"pull-right\" style=\"margin-top: 7px;\">\n\t\t\t<span style=\"font-size: 16px;\">Deze app kan uw gegevens aanpassen</span>\n\t\t</div>\n\t</div>\n</div>\n";
		$tpl_access_end = "<div class=\"col-xs-12\">\n\t<hr size=\"3\" noshade>\n</div>\n";
		
		$finalaccessadd = $tpl_access_end;
		if(in_array("read", $user->getAppAccess($pagetocheck[1]))) {
			$finalaccessadd .= $tpl_access_read.$tpl_access_end;
		}
		
		if(in_array("write", $user->getAppAccess($pagetocheck[1]))) {
			$finalaccessadd .= $tpl_access_write.$tpl_access_end;
		}
		
		$pagename = "Mijn Apps<div class=\"pull-right\"><a class=\"btn btn-default\" href=\"/apps\">Alle apps</a></div>";
		$pagecontents = $m->render(file_get_contents("tpl/apps_viewapp.tpl"), [
			"appname" => $user->getAppData($pagetocheck[1])["name"],
			"appinfotext" => $user->getAppData($pagetocheck[1])["text"],
			"appimage" => "data:image/png;base64,".base64_encode($user->getAppData($pagetocheck[1])["img"]),
			"access" => str_replace("\n", "\n\t\t\t\t\t", $finalaccessadd),
			"2fa" => $user->isTwoFactorAuthOn()
		]);
	} else {
		require_once("tpl/404.php");
	}
} else {
	$pagename = "Mijn Apps";
	if(count($user->getApps()) <= 0) {
		$pagecontents = "Geen apps gevonden, wil je je eigen app(s) DJO OAuth laten gebruiken? <a href=\"/appregister\">registreer</a> ze dan.";
	} else {
		//render apps.tpl with app data
		$rp = ["apps" => []];

		for($i = 0; $i < count($user->getApps()); $i++) {
			$rp["apps"][] = [
				"id" => $i,
				"name" => $user->getAppData($i)["name"],
				"read" => in_array("read", $user->getAppAccess($i)),
				"write" => in_array("write", $user->getAppAccess($i))
			];
		}
		$pagecontents = $m->render(file_get_contents("tpl/apps.tpl"), $rp);
	}
}