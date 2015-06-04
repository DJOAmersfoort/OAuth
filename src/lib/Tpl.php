<?php

require_once(__DIR__."/moustache.php");

/**
 * Extends functionality of the Moustache rendering engine for use in page rendering
 * 
 * @package DJOAuth
 * @author  Yoeri Otten <yoeori@live.nl>
 * @version 1.0
 * @license http://opensource.org/licenses/mit-license.php MIT-license
 */
Class Tpl extends Mustache_Engine {
	
	private $bulkData = [];
	
	/**
	 * Merges the bulkData with the array and renders the template
	 * @param string $template
	 * @param array $data
	 * @return string
	 */
	public function render($template, $data = []) {
		$data = array_merge($data, $this->bulkData);
		return parent::render($template, $data);
	}
	
	/**
	 * Adds arrayData to bulkData
	 * @param string $name
	 * @param array $arrayData
	 * @return boolean|if data is added
	 */
	public function addBulkData($name, $arrayData) {
		
		if(!is_string($name))
			return false;
		
		if(array_values($arrayData) === $arrayData)
			return false;
		
		foreach($arrayData as $key=>$data) {
			$this->bulkData[$name . ":" . $key] = $data;
		}
		
		return true;	
	}
	
}