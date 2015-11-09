<?php

Data::getInstance()->registerHandler("register", function($data, $helper) {
	global $_SESSION;
	if(!isset($_POST["email"]) || !isset($_POST["voornaam"]) || !isset($_POST["pass"]) || !isset($_POST["passrepeat"]) || !isset($_POST["djolid"])) {
		$returner = $helper->error("Verkeerde data ontvangen.");
	} elseif($data["email"] == "") {
		$returner = $helper->error("Vul een emailadres in.");
	} elseif($data["pass"] == "") {
		$returner = $helper->error("Vul een wachtwoord in.");
	} elseif($data["passrepeat"] == "") {
		$returner = $helper->error("Herhaal het wachtwoord.");
	} elseif($data["voornaam"] == "") {
		$returner = $helper->error("Vul een voornaam in.");
	} elseif($data["pass"] != $data["passrepeat"]) {
		$returner = $helper->error("Wachtwoorden komen niet overeen.");
	} elseif($data["voornaam"] == "") {
		$returner = $helper->error("Vul een voornaam in.");
	} elseif($data["djolid"] == "" || ($data["djolid"] != "true" && $data["djolid"] != "false")) {
		$returner = $helper->error("Geen djolid info ontvangen.");
	} else if(filter_var($data["email"], FILTER_VALIDATE_EMAIL) == "") {
		$returner = $helper->error("Vul een geldig emailadres in.");
	} else if(checkPassword($data["pass"]) <= 0) {
		$returner = $helper->error("Vul een sterker wachtwoord in.");
	} else if(strlen($data["email"]) >= 100 || strlen($data["pass"]) >= 32) {
		$returner = $helper->error("Vul een korter emailadres/wachtwoord in (een wachtwoord mag maar 32 tekens lang zijn)");
	} else if(chechifuserexists($data["email"])) {
		$returner = $helper->error("Dit email adres is al verbonden met een account.");
	} elseif(!isset($data["captcha"]) || $data["captcha"] == "" || !isset($_SESSION["captcha"]) || $data["captcha"] != $_SESSION["captcha"]) {
		$returner = $helper->error("Vul de captcha correct in.");
	} else {
		return ["ok"];
	}
	$captcha = generateCaptcha();
	$_SESSION["captcha"] = $captcha[1];
	$returner["captcha"] = $captcha[0];
	return $returner;

}, function($data, $helper) {
	global $_COOKIE, $_SESSION, $m;

	$email = strtolower($data["email"]);
	$firstname = ucfirst(strtolower(preg_replace("/[^A-Za-z]/", '', $data["voornaam"])));
	$middlename = strtolower(preg_replace("/[^A-Za-z ]/", '', $data["tussenvoegsel"]));
	$lastname = ucfirst(strtolower(preg_replace("/[^A-Za-z]/", '', $data["achternaam"])));

	for( ; ;) {
		$salt = substr(md5(mcrypt_create_iv(16, MCRYPT_DEV_URANDOM)), 0, 22);
		$result = $helper->db->where("password", array("%".substr($salt, 0, 21)."%", "LIKE"))->get("users", 1);
		if(count($result) == 0) {
			break;
		}
	}

	$password = password_hash($data["pass"], PASSWORD_BCRYPT, array('cost' => 12, 'salt' => $salt));
	$insertdata = array(
		"email" => $email,
		"firstname" => $firstname,
		"middlename" => $middlename,
		"lastname" => $lastname,
		"password" => $password,
		"rank" => -1,
		"djoMemberRequest" => $data["djolid"] === "true" ? 1 : 0,
		"data" => json_encode(array(
				"email" => $email,
				"voornaam" => $firstname,
				"tussenvoegsel" => $middlename,
				"achternaam" => $lastname,
				"rank" => 0,
				"mobiel" => isset($data["mobile"]) && $data["mobile"] != "" ? $data["mobile"] : ""
		))
	);

	if($helper->db->insert("users", $insertdata)) {

		$newUser = User::create()->fromEmail($email);


		mail(
			"",
			"DJO OAuth registratie",
			$m->render(
				file_get_contents("tpl/emailregister.tpl"),
				[
					"registrationurl" => "https://oauth.djoamersfoort.nl/register/".substr($salt, 0, 21)
				]
			),
			"MIME-Version: 1.0\r\n"
				. "Content-type: text/html; charset=iso-8859-1\r\n"
				. "To: ".$insertdata["firstname"]." ".$insertdata["middlename"]." ".$insertdata["lastname"]." <".$insertdata["email"].">\r\n"
				. "From: DJO OAuth <no-reply@djoamersfoort.nl>\r\n"
		);

		$UserAddressesToRegister = [];
		for($i = 1; $i <= (int) $data["countaddress"]; $i++) {
			//Handle address adding
			if(isset($data["address_street_".$i]) &&
			   isset($data["address_postalcode_".$i]) &&
			   isset($data["address_town_".$i])) {
				$UserAddressesToRegister[] = [
					"adres_street" => $data["address_street_".$i],
					"adres_number" => "",
					"adres_town" => $data["address_town_".$i],
					"adres_postalcode" => $data["address_postalcode_".$i],
					"user_id" => $newUser->getId()
				];
			}
		}
		for($i = 0; $i < count($UserAddressesToRegister); $i++) {
			$helper->db->insert("users_addresses", $UserAddressesToRegister[$i]);
		}

		if(isset($data["iscreatinginweb"]) && $data["iscreatinginweb"] == true) {
			$_SESSION["hasregistered"] = true;
			$_SESSION["emailregistered"] = $data["email"];
			if($data["djolid"] == "true") {
				$_SESSION["djoregistered"] = true;
			}
		}
		return ["isregistered" => true];

	} else {
		$returner = $helper->error("Query kon niet worden uitgevoerd");
		$captcha = generateCaptcha();
		$_SESSION["captcha"] = $captcha[1];
		$returner["captcha"] = $captcha[0];
		return $returner;
	}
});
