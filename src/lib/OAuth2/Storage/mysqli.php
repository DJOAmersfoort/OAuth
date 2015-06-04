<?php

namespace OAuth2\Storage;

/**
 * Simple Mysqli interface
 *
 * @author Yoeri Otten <Yoeori at live dot nl>
 */

class mysqli implements AuthorizationCodeInterface, /**/
	AccessTokenInterface, /**/
	ClientCredentialsInterface, /**/
	RefreshTokenInterface /**/
{

	protected $db;
	protected $config;
	
	public function __construct($config = array()) {
		global $db;
		$this->db = $db;
		$this->config = $config;
		
	}
	
	public function checkClientCredentials($client_id, $client_secret = NULL) {	
		$result = $this->db->where("client_id", $client_id)->get("oauth_apps", 1);
		return $result && $result[0]["client_secret"] == $client_secret;
	}
	
	
	public function isPublicClient($client_id) {
		if (!$result = $this->db->where("client_id", $client_id)->get("oauth_apps", 1)) {
			return false;
		}
		
		return empty($result["client_secret"]);
		
	}
	
	public function getClientDetails($client_id) {
		$result = $this->db->where("client_id", $client_id)->get("oauth_apps", 1);
		return isset($result[0]) ? $result[0] : false;
	}
	
	public function setClientDetails($client_id, $client_secret = NULL, $redirect_uri = NULL, $grant_types = NULL, $user_id = NULL) {
		
		$data = compact("client_id", "client_secret", "redirect_uri", "grant_types", "user_id");
		
		if($this->getClientDetails($client_id)) {
			$query = $this->db->where("id", $client_id)->update("oauth_apps", $data);
		} else {
			$query = $this->db->insert("oauth_apps", $data);
		}
		return $query;
	}
	
	public function checkRestrictedGrantType($client_id, $grant_type) {
		$details = $this->getClientDetails($client_id);
		if(isset($details["data"]) && $details["data"] != null) {
			$details["data"] = json_decode($details["data"], true);
			if (isset($details["data"]["grant_types"])) {
				$grant_types = $details["data"]["grant_types"];
	
				return in_array($grant_type, (array) $grant_types);
			}
		}
		return true;
	}
	
	public function getAccessToken($access_token) {
		$result = $this->db->where("access_token", $access_token)->get("oauth_access_tokens", 1);
		
		if(count($result) == 1) {
			$token = $result[0];
			$token["expires"] = strtotime($token["expires"]);
		} else {
			return false;
		}
		
		return $token;
	}
	
	public function setAccessToken($access_token, $client_id, $user_id, $expires, $scope = null) {
		$expires = date("Y-m-d H:i:s", $expires);
		$data = compact("access_token", "client_id", "user_id", "expires");
		if($scope != null) $data["scope"] = $scope;
		if ($this->getAccessToken($access_token)) {
			$query = $this->db->where("access_token", $access_token)->update("oauth_access_tokens", $data);
		} else {
			$query = $this->db->insert("oauth_access_tokens", $data);
		}
		
		return $query;
	}
	
	public function getAuthorizationCode($authcode) {
		$result = $this->db->where("authorization_code", $authcode)->get("oauth_authorization_codes", 1);
		if (count($result) == 1) {
			$code = $result[0];
			$code["expires"] = strtotime($code["expires"]);
		}
		
		return isset($code) ? $code : false;
	}
	
	public function setAuthorizationCode($authorization_code, $client_id, $user_id, $redirect_uri, $expires, $scope = NULL) {
		$expires = date('Y-m-d H:i:s', $expires);
		$data = compact("authorization_code", "client_id", "expires");
		if($user_id != null) $data["user_id"] = $user_id;
		if($redirect_uri != null) $data["redirect_uri"] = $redirect_uri;
		if($scope != null) $data["scope"] = $scope;
		
		echo $this->getAuthorizationCode($authorization_code) ? "true" : "false";
		
		if ($this->getAuthorizationCode($authorization_code)) {
			$result = $this->db->where("authorization_code", $authorization_code)->update("oauth_authorization_codes", $data);
		} else {
			$result = $this->db->insert("oauth_authorization_codes", $data);
		}

		return $result;
	}
	
	
	public function expireAuthorizationCode($code) {
		return $this->db->where("authorization_code", $code)->delete("oauth_authorization_codes");
	}
	
	public function getRefreshToken($refresh_token) {
		$result = $this->db->where("refresh_token", $refresh_token)->get("oauth_refresh_tokens", 1);

		if (count($result) == 1) {
			$token = $result[0];
			$token["expires"] = strtotime($token["expires"]);
		}
		
		return isset($token) ? $token : false;
	}
	
	public function setRefreshToken($refresh_token, $client_id, $user_id, $expires, $scope = null) {
		
		$expires = date('Y-m-d H:i:s', $expires);
		$data = compact("refresh_token", "client_id", "expires");
		if($user_id != null) $data["user_id"] = $user_id;
		if($scope != null) $data["scope"] = $scope;

        return $this->db->insert("oauth_refresh_tokens", $data);
	}
	
	public function unsetRefreshToken($refresh_token) {
		return $this->db->where("refresh_token", $refresh_token)->delete("oauth_refresh_tokens");
	}
}
