<?php

//is_callable

Class Page {
	
	private $pageHandlers = [];
	
	
	public function __construct() {
		
	}
	
	public function registerPage($settings, $handleRequest) {
		
		$settingsToSave = [];
		
		foreach($settings as $setting=>$data) {
			if(is_callable($data)) {
				$settingsToSave[$setting] = $data(new SettingsPageHelper($this));
				continue;
			}
			$settingsToSave[$setting] = $data;
			
		}
		
	}
	
	public function handlePageRequest($data) {
		
		return "";
		
	}	
}


Class PageHelper {
	
	public function __construct() {
		
		
	}
	
	
}

Class SettingsPageHelper extends PageHelper {
	
	public function __construct() {
		
		
		
	}
	
}

?>


page template

$page->registerPage(["url" => "", "isSubPage" => true, "subPage" => "", name => "", subName => function($helper) {
	return $helper->getUser()->getEmail();

}] /*Settings*/, function($data, $helper) {
	//Handles page request
	return "Page contents";
});

settings
	"url" can include all reg-ex necessary
	"isSubPage" should be true or false, if "subPage" doesn't exist it will be set to false automaticly
		if not true/false will be set to false
	All settings can be functions that return something, 
		the functions will be called with an instance SettingsPageHelper (an instance of PageHelper)