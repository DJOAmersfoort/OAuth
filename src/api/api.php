<?php

require_once("./../lib/base.php");

if(isset($_GET["access_token"])) $_POST["access_token"] = $_GET["access_token"];

$storage = new OAuth2\Storage\mysqli(array());
$server = new OAuth2\Server($storage);
$server->addGrantType(new OAuth2\GrantType\AuthorizationCode($storage));
$server->addGrantType(new OAuth2\GrantType\RefreshToken($storage));
$memory = new OAuth2\Storage\Memory(["default_scope" => "read", "supported_scopes" => ["read","write"]]);
$scopeUtil = new OAuth2\Scope($memory);
$server->setScopeUtil($scopeUtil);

$return = array();

$api = isset($_GET["api"]) && $_GET["api"] != "" ? $_GET["api"] : "noapiset";
if($api == "v1") {

	if (!$server->verifyResourceRequest(OAuth2\Request::createFromGlobals())) {
		$server->getResponse()->send();
		exit();
	}
	$data = $server->getAccessTokenData(OAuth2\Request::createFromGlobals());
	$request = isset($_GET["request"]) ? $_GET["request"] : "";

	$apiUser = User::create()->fromId((int) $data["user_id"]);

	$return['users'] = [];

	$return['users'][0] = [
		"displayName" => $apiUser->getFullName()["fullName"],
		"name" => [
			"givenName" => $apiUser->getFullName()["firstName"],
			"insertionName" => isset($apiUser->getFullName()["surName"]) ? $apiUser->getFullName()["surName"] : "",
			"familyName" => $apiUser->getFullName()["familyName"]
		],
		"id" => $apiUser->getId() . "@oauth.djoamersfoort.nl",
		"email" => $apiUser->getEmail(),
		"addresses" => [],
		"isDjoMember" => $apiUser->hasAccessTo("djoMember")
	];

	$addresses = $apiUser->getUserAdresses();
	for($i = 0; $i < count($addresses); $i++) {
		$return['users'][0]["addresses"][] = [
			"street" => $addresses[$i]["adres_street"] . " " . $addresses[$i]["adres_number"],
			"postalcode" => $addresses[$i]["adres_postalcode"],
			"town" => $addresses[$i]["adres_town"]
		];
	}

} else if($api == "OAuth") {
	$allowed = array("access_token", "authorize");
	if(isset($_GET["request"]) && in_array($_GET["request"], $allowed)) {

		if($_GET["request"] == "authorize") {

			$_GET["state"] = "abc";
			$request = OAuth2\Request::createFromGlobals();
			$response = new OAuth2\Response();
			if (!$server->validateAuthorizeRequest($request, $response)) {
				$response->send();
				exit();
			} elseif(!$user->isLoggedIn()) {

				$loginpage = file_get_contents(__DIR__ . "/login.tpl");
				$loginpage = str_replace("{{url}}", "//".$_SERVER["HTTP_HOST"], $loginpage);
				exit($loginpage);

			} elseif(!in_array($request->query["client_id"], $user->getApps())) {
				$result = $db->where("client_id", $request->query["client_id"])->get("oauth_apps");
				$menu = str_replace("\n", "\n\t\t\t\t", "<li>\n\t\t<a href=\"javascript:void(0);\">\n\t\t\t<i class=\" glyphicon glyphicon-user\"></i> ".ucfirst($user->getFullName()["firstName"])."&nbsp;\n\t\t\t<span class=\"label label-white tooltipTitle\" title=\"".$user->getRankInText()."\">".$user->getRankInText()."</span>&nbsp;\n\t\t\t\n\t\t</a>\n\t\t\n\t</li>\n");
				$info = json_decode($result[0]["info"], true);
				exit($m->render(file_get_contents("appauth.tpl"), [
					"appname" => $info["name"],
					"appimage" => "data:image/png;base64,".base64_encode($result[0]["img"]),
					"appinfotext" => $info["text"],
					"appid" => $request->query["client_id"],
					"menu" => $menu,
					"url" => "//".$_SERVER["HTTP_HOST"]
				]));
			}
			$server->handleAuthorizeRequest($request, $response, true, $user->getId());
			$response->send();
			exit();

		} elseif($_GET["request"] == "access_token") {

			$server->handleTokenRequest(OAuth2\Request::createFromGlobals())->send();
			exit();

		}
	} else {
		$return["error"] = "No valid action set, Please read the documentation for more info.";
	}

} else {
	$return["error"] = "No valid api set, Please read the documentation for more info.";
}

header('Content-Type: application/json');
header("X-XRDS-Location: https://".$_SERVER["SERVER_NAME"]."/api");

echo json_encode($return, JSON_PRETTY_PRINT);
