<?php
/**
 * Handles a user.
 *
 * @package DJOAuth
 * @author  Yoeri Otten <yoeori@live.nl>
 * @version 1.0
 * @license http://opensource.org/licenses/mit-license.php MIT-license
 */
class User {
	
	private $loggedin;
	private $id;
	private $result;
	private $apps = array();
	private $apps_access = array();
	private $apps_data = array();
	private $TwoFactorAuth_isOn;
	private $TwoFactorAuth_token;
	
	/**
	 * Checks if current user is logged in in this session
	 * @return boolean if user is logged in
	 */
	public function isLoggedIn() {
		return $this->loggedin == true;
	}
	
	/**
	 * Checks if Two Factor Auth is turned on
	 * @return boolean if 2fa is turned on for current user
	 */
	public function isTwoFactorAuthOn() {
		return $this->TwoFactorAuth_isOn == true;
	}
	
	/**
	 * Checks if the current user requested a DJO membership
	 * @return boolean 
	 */
	public function hasDjoMemberRequest() {
		return isset($this->result["djoMemberRequest"]) && $this->result["djoMemberRequest"] == 1;
	}
	
	/**
	 * Checks if the user currently has a Two Factor Auth token assigned to himself
	 * @return boolean
	 */
	public function hasTwoFactorAuthToken() {
		return isset($this->TwoFactorAuth_token) && $this->TwoFactorAuth_token != "";
	}
	
	/**
	 * Gets the users' Two Factor Auth token or creates one if one isn't assigned
	 * @return string
	 */
	public function getTwoFactorAuthToken() {
		return $this->hasTwoFactorAuthToken() ? $this->TwoFactorAuth_token : "0";
	}
	
	/**
	 * Gets the current users' rank in number
	 * @return int
	 */
	public function getRank() {
		return (int) $this->result["rank"];
	}
	
	/**
	 * Sets the users' rank, and pushes to database
	 * @param int $newRank the new rank to set
	 */
	public function setRank($newRank) {
		global $db;
		
		$newRank = (int) $newRank;
		
		$this->result["rank"] = $newRank;
		$db->where("id", $this->getId())->update("users", ["rank" => $newRank]);
	}
	
	/**
	 * Lists all the possible ranks as array. (0 == -1 etc)
	 * @return array contains all possible ranks
	 */
	public static function getRanks() {
		return ["Ongeactiveerd", "Gebruiker", "Lid", "Jeugdbestuur", "Aspirant-Begeleider", "Begeleider", "Bestuur", "Administrator"];
	}
	
	/**
	 * Gets the current users' rank in text
	 * @return string the users' rank in text
	 */
	public function getRankInText() {
		
		return $this->getRanks()[$this->getRank()+1];
	}
	/**
	 * Gets all the rights the user has according to their rank
	 * @return array
	 */
	public function getUserRights() {
		$userrights = [];
		$userrank = $this->getRank();
		
		if($userrank >= 1) {
			$userrights = array_merge($userrights, ["djoMember"]);
		}
		
		if($userrank >= 2) {
			$userrights = array_merge($userrights, ["userslist", "userdata"]);
		}
		
		if($userrank >= 3) {
			$userrights = array_merge($userrights, ["editUserInfo", "turnOff2StepAuthforOtherUsers"]);
		}
		
		if($userrank >= 4) {
			$userrights = array_merge($userrights, []);
		}
		
		if($userrank >= 5) {
			$userrights = array_merge($userrights, ["deleteUser"]);
		}
		
		return $userrights;
	}
	
	
	/**
	 * Checks if user has sufficient rights to do a certain task
	 * return boolean
	 */
	public function hasAccessTo($type) {
		return in_array($type, $this->getUserRights());
	}
	
	/**
	 * Returns the users' email
	 * @return string contains users' email
	 */
	public function getEmail() {
		return htmlspecialchars($this->result["email"]);
	}
	
	/**
	 * Returns the current users' name as an array
	 * @return array With full users' name
	 */
	public function getFullName() {
		$name = [
			"firstName" => htmlspecialchars($this->result["firstname"]),
			"familyName" => htmlspecialchars($this->result["lastname"])
		];
		if($this->result["middlename"] != "") {
			$name["surName"] = htmlspecialchars($this->result["middlename"]);
		}
		$name["fullName"] = $name["firstName"] . "" . (isset($name["surName"]) ? " ".$name["surName"] : "") . " " . $name["familyName"];
		return $name;
	}
	/**
	 * Returns all of the users app in an array
	 * @return array All users' apps
	 */
	public function getApps() {
		return $this->apps;
	}
	/**
	 * Returns the data off all users' apps.
	 * @deprecated
	 */
	public function getAppData($id) {
		return array_merge($this->apps_data[$id], ["user_id" => $this->getId()]);
	}
	
	/**
	 * Returns the access off all users' apps.
	 * @deprecated
	 */
	public function getAppAccess($id) {
		return $this->apps_access[$id];
	}
	/**
	 * Returns an array with all the addresses of the user checked against the google apis
	 */
	public function getUserAdresses() {
		global $db;
		
		$addresses = $db->where("user_id", $this->id)->get("users_addresses");
		for($i = 0; $i < count($addresses); $i++) {
			$addresses[$i]["i"] = $i+1;
		}
		
		return array_merge(array(), $addresses);
		//http://maps.googleapis.com/maps/api/geocode/json?address=Snoeckgensheuvel+31,+3817+HK+Amersfoort,+The%20Netherlands&sensor=false
	}
	
	/**
	 * Sets the user to logged in
	 */
	public function setLoggedIn() {
		$this->loggedin = true;
		return true;
	}
	
	/**
	 * Returns the current users' public id
	 * @return int the user id.
	 */
	public function getId() {
		return $this->result["id"];	
	}
	/**
	 * Sets a Two Factor Auth token for the current user
	 */
	public function setTwoFactorAuthToken($token) {
		$this->TwoFactorAuth_token = $token;
	}
	
	/**
	 * Check the users' password and returns true if correct
	 * @return boolean
	 */
	public function checkPassword($password) {
		return password_verify($password, $this->result["password"]);
	}
	
	/**
	 * Creates a new object of self
	 * @return object New self
	 */
	public static function create() {
		$instance = new self();
		return $instance;
	}
	
	/**
	 * Loads all the user data from cookie id
	 * @return object this
	 */
	public function fromCookie($cookieId) {
		global $_SESSION, $db;
		if(($result = $db->where("cookie_id", $cookieId)->get("login_remember", 1))) {
			if($result[0]["expires"] >= time()) {
				
				$_SESSION["djoAuthLogin"] = true;
				$_SESSION["djoAuthLogin_time"] = time() + 3600*12;
				$_SESSION["djoAuthLogin_id"] = $result[0]["user_id"];

				$newexpire = (time()+3600*24*100);
						
				for( ; ;) {
					$newcookieid = md5(mt_rand()).md5(mt_rand());
					if(!$db->where("cookie_id", $newcookieid)->get("login_remember", 1)) {
							break;
					}
				}
				setcookie("login", $newcookieid, $newexpire, "/");
						
				$db->where("id", $result[0]["id"])->update("login_remember", array(
					"expires" => $newexpire,
					"cookie_id" => $newcookieid
				));
				return $this->fromSessions();
			}
		}
		return $this;
	}
	
	/**
	 * Loads all the user data from sessions
	 * @return object this
	 */
	public function fromSessions() {
		global $_SESSION, $db;
		if(isset($_SESSION["djoAuthLogin"]) && $_SESSION["djoAuthLogin"] === true && isset($_SESSION["djoAuthLogin_time"]) && $_SESSION["djoAuthLogin_time"] > time() && isset($_SESSION["djoAuthLogin_id"]) && $_SESSION["djoAuthLogin_id"] != "" && $users = $db->where("id", $_SESSION["djoAuthLogin_id"])->get("users")) {
			if(isset($users[0]) && count($users) == 1) {
				
				$this->loggedin = true;
				return $this->fromData($users[0]);
			}
		}
		return $this;
	}
	
	/**
	 * Loads all the user data from the users' public id
	 * @return object this
	 */
	public function fromId($id) {
		global $db;
		if($users = $db->where("id", $id)->get("users")) {
			if(isset($users[0])) {
				return $this->fromData($users[0]);
			}
		}
		throw new Exception("User not found.");
	}
	
	/**
	 * Loads all the user data from a data array
	 * @return object this
	 * @deprecated as of version 1.1
	 */
	public function fromData($user) {
		global $db;
		
		$this->result = $user;
		$this->loggedin = true;
		$this->id = $user["id"];
				
		//Get apps
		if($apps = $db->where("user_id", $this->id)->get("users_apps")) {
			foreach($apps as $app) {
				$this->apps[] = $app["client_id"];
				$somedata = $db->where("client_id", $app["client_id"])->get("oauth_apps")[0];
				$this->apps_data[] = array_merge(json_decode($somedata["info"], true), ["img" => $somedata["img"]]);
				$this->apps_access[] = json_decode($app["access"], true);
			}
		}
				
		//Get 2fa
		if($twofa = $db->where("user_id", $this->id)->get("users_2step")) {
			if(count($twofa) == 1) {
				$this->TwoFactorAuth_token = $twofa[0]["secret"];
				$this->TwoFactorAuth_isOn = $twofa[0]["isOn"] == 1 ? true : false;
			}
		}
		
		return $this;
	}
	
	/**
	 * Loads all the user data from email address
	 * @return object this
	 */
	public function fromEmail($email) {
		global $db;
		if($users = $db->where("email", $email)->get("users")) {
			if(isset($users[0]) && count($users) == 1) {
				return $this->fromData($users[0]);
			}
		}
		throw new Exception("User not found.");
	}
}