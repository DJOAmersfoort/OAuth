<?php

/**
 * Description of Action
 * @package   ActionOnUrl
 * @author Yoeri Otten <yoeori@live.nl>
 */
class Action {
	
	private static $instance;
	
	public function __construct() {
		
		self::$instance = $this;
	}
	
	/**
	 * Returns the most new created instance of Action and creates one of none are available
	 * @return Object Instance of Data
	 */
	public static function getInstance() {
		if(!is_object(self::$instance))	new self();
		return self::$instance;
	}
	
	public function addHandler() {
		
	}
	
	public function handle($action) {
		/*
		$action (string) = "action(dataforaction)"
		*/
		$action = explode("(", $action);
		print_r($action);
		$data = explode(",", substr($action[1], 0, -1));
		$action = $action[0];
		
		print_r($data);
	}
}
Action::getInstance()->handle("do(this)");