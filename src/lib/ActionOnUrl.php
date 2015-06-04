<?php

require_once("Action.php");

/**
 * Description of ActionOnUrl
 * @package   ActionOnUrl
 * @author Yoeri Otten <yoeori@live.nl>
 */
class ActionOnUrl {
	
	/**
	 * 
	 * @param String $code the code saved in the database
	 */
	public static function handleFromCode($code) {
		$actionHandler = Action::getInstance();
		$db = MysqliDb::getInstance();
		
		
	}
	
	/**
	 * Registers a new Action on url in the database
	 * @param String $action the action to be handled when the return code is used
	 * @return String the action code
	 */
	public static function register($action) {
		$db = MysqliDb::getInstance();
		
	}
	
}

ActionOnUrl::handleFromCode("");