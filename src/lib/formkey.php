<?php


//creates key
function formKeyCreate() {
	if(!isset($_SESSION["formkeys"]) || !is_array($_SESSION["formkeys"])) {
		$_SESSION["formkeys"] = array();
	}
}


//Check key, not deletion
function formKeyCheck($key) {
	if(!isset($_SESSION["formkeys"]) || !is_array($_SESSION["formkeys"])) {
		$_SESSION["formkeys"] = array();
	}
}


//Deletes key, no key check
function formKeyDelete($key) {
	if(!isset($_SESSION["formkeys"]) || !is_array($_SESSION["formkeys"])) {
		$_SESSION["formkeys"] = array();
	}
	if(isset($_SESSION["formkeys"][$key]))
		unset($_SESSION["formkeys"][$key]);
		
	return true;
}


//Checks all keys, and deletes them if neccesery
function formKeyUpdate() {
	if(!isset($_SESSION["formkeys"]) || !is_array($_SESSION["formkeys"])) {
		$_SESSION["formkeys"] = array();
	}
}

?>