<?php
//Handles History table

Class History {
	
	private $userId;
	private $db;
	
	public function __construct($user = 0) {
		global $db;
		
		$this->db = $db;
		
		if($user != 0) {
			//Initialize with user
			$this->userId = $user->getId();
		} else {
			$this->userId = 0;
		}
		
	}
	
	
	
	
	
	
}