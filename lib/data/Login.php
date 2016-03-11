<?php

Data::getInstance()->registerHandler("login", function($data, $helper) {
	if(!isset($data["pass"]) || !isset($data["email"])) {
		return $helper->error("Verkeerde data ontvangen.");
	} else if($data["pass"] == "" && $data["email"] == "") {
		return $helper->error("Vul alle velden in.");
	} else if($data["pass"] == "") {
		return $helper->error("Vul ook het wachtwoord in.");
	} else if($data["email"] == "") {
		return $helper->error("Vul ook het emailadres in");
	} else if(strlen($data["email"]) >= 100 || strlen($data["pass"]) >= 32) {
		return $helper->error("Vul een korter emailadres/wachtwoord in (een wachtwoord mag maar 32 tekens lang zijn)");
	} else if(filter_var($data["email"], FILTER_VALIDATE_EMAIL) == "") {
		return $helper->error("Vul een geldig emailadres in.");
	} else {
		return ["ok"];
	}
	
}, function($data, $helper) {
	global $_COOKIE;
	if($result = $helper->db->where("email", strtolower($data["email"]))->get("users", 2)) {
		if(count($result) == 1 && password_verify($data["pass"], $result[0]["password"]) && $result[0]["rank"] >= 0) {
			
			$helper->registerSessions([
				"djoAuthLogin" => true, 
				"djoAuthLogin_time" => time()+(3600*12),
				"djoAuthLogin_id" => $result[0]["id"]
			]);
			
			if($data["login_remember"] == "true") {
				$newexpire = (time()+3600*24*100);
				for( ; ;) {
					$newcookieid = md5(mt_rand()).md5(mt_rand());
					if(!$helper->db->where("cookie_id", $newcookieid)->get("login_remember", 1)) {
						break;
					}
				}
				setcookie("login", $newcookieid, $newexpire, '/');
					
				$helper->db->insert("login_remember", array(
					"user_id" => $_SESSION["djoAuthLogin_id"],
					"expires" => $newexpire,
					"cookie_id" => $newcookieid
				));
			}
			
			return ["isloggedin" => true];
			
		} elseif(count($result) > 0 && $result[0]["rank"] == -1) {
				return $helper->error("Activeer je account eerst.");
		} else {
			return $helper->error("Onbekend emailadres of wachtwoord.");
		}
	} else {
		return $helper->error("Onbekend emailadres of wachtwoord.");
	}
});

?>