<?php

/**
 * Autoloads the classes for the oauth.djamersfoort.nl website
 *
 * @author    Yoeri Otten <yoeori@live.nl>
 * @license   MIT License
 */
class Autoloader {
	
	/**
	 * Initializes the autoloader for classes
	 */
	public static function initialize() {
		ini_set("unserialize_callback_func", "spl_autoload_call");
		spl_autoload_register(array(new self(), "load"));
	}
	
	/**
	 * Loads class
	 * @param String $class The name of the class
	 */
	public function load($class) {
		if(file_exists($file = __DIR__ . "/" . str_replace("\\", "/", $class) . ".php")) {
			require_once($file);
			return true;
		} else {
			return false;
		}
	}
	
}