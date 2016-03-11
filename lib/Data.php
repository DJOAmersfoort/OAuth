<?php

class Data {

	private $handlers = [];
	private $helper;
	private static $instance;
	
	/**
	 * Creates new instance of Data class and loads data handlers
	 */
	public function __construct() {
		$this->helper = new DataHelper($this);
		self::$instance = $this;
		$this->loadDataHandlersFromDir(__DIR__ . "/data");
	}
	
	
	/**
	 * Returns the most new created instance of Data and creates one of none are available
	 * @returns Object Instance of Data
	 */
	public static function getInstance() {
		if(!is_object(self::$instance))	new self();
		return self::$instance;
	}
	
	/**
	 * Registers a new data handler
	 * @param String @type the name of the data handler
	 * @param Callable $varcheck a function to check if the correct data has been recieved
	 * @param Callable $handlerequest function to actually change the data depending on the request
	 */
	public function registerHandler($type, $varcheck, $handlerequest) {
		
		$this->handlers[] = [
			"type" => $type,
			"checkRequest" => $varcheck,
			"handle" => $handlerequest
		];
		
		
	}
	
	/**
	 * Loads all data handlers in specific directory
	 * @param String The directory to search for data handlers
	 */
	private function loadDataHandlersFromDir($dir) {
		$handlersToLoad = array_diff(scandir($dir), array('..', '.'));
		foreach($handlersToLoad as $handlerToLoad) {
			if(substr($handlerToLoad, 0, 1) !== "_") {
				require_once($dir . "/" . $handlerToLoad);
			}
		}
	}
	
	/**
	 * Handles an incomming request with the given data
	 * @param Array $request information about the request
	 */
	public function handleFromRequest($request) {
		$requestedType = isset($request["type"]) && $request["type"] != "" ? $request["type"] : "";
		foreach($this->handlers as $handler) {
			if($handler["type"] == $requestedType) {
				if(($checkedRequest = $handler["checkRequest"]($request, $this->helper->help("checkRequest"))) !== ["ok"]) {
					exit(json_encode($checkedRequest));
				}
				exit(json_encode($handler["handle"]($request, $this->helper->help("handleRequest"))));
			}
		}
		exit(json_encode($this->helper->error("Onbekend type data!")));
	}
	
}
class DataHelper {
	
	private $data;
	private $type;
	public $db;
	
	public function __construct($data) {
		global $db;
		$this->db = $db;
		$this->type = "checkRequest";
		$this->data = $data;
		
	}
	
	public function getUser() {
		global $user;
		return $user;
	}
	
	public function getDb() {
		global $db;
		return $db;
	}
	
	public function help($type) {
		$this->type = $type;
		return $this;
	}
	
	public function error($error) {
		return ["error" => $error];
	}
	
	public function registerSessions($sessions) {
		global $_SESSION;
		
		foreach($sessions as $name => $data) {
			$_SESSION[$name] = $data;
		}
	}
	
}

$data = Data::getInstance();