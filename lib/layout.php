<?php

class Layout {

	private $replaceArray = array();
	private $cfg;
	private $shouldrenderlayout;
	public $menu = array("", "");
	private $m;

	public function __construct($cfg, $shouldrenderlayout) {
		global $m;

		$this->cfg = $cfg;
		$this->m = $m;
		$this->shouldrenderlayout = $shouldrenderlayout;
	}

	public function addReplace($name,$text) {
		if($name == "page") {
			$text = $this->getMoustache()->render($text, $this->getVars());
		}
		$this->replaceArray[] = array($name,$text);
	}

	public function ParsePage() {
		global $pagename, $subpagename, $_SERVER, $pagetocheck;

		$this->addReplace("year", date("Y"));
		$this->addReplace("url", "//".$_SERVER["HTTP_HOST"]);

		$page = "";
		$page .= $this->shouldrenderlayout ? file_get_contents("./tpl/page.tpl") : "<div class=\"page-header\"><h1><span id=\"pagetitle\">{{title}}</span> <small>{{subtitle}}</small> </h1></div>{{pagecontents}}";
		return $this->ParseReplaces($this->ParseReplaces($this->getMoustache()->render($page,$this->getVars())));
	}

	public function ParseReplaces($text) {
		for($i = 0; $i < count($this->replaceArray); $i++) {
			$text = str_replace("{".$this->replaceArray[$i][0]."}", $this->replaceArray[$i][1], $text);
		}
		return $text;
	}

	private function getVars() {
		global $pagename, $subpagename, $_SERVER, $pagetocheck;

		return [
			"url" => "//".$_SERVER["HTTP_HOST"],
			"navbarleft" => str_replace("\n", "\n\t\t\t\t\t\t", $this->getMenu()[0]),
			"navbarright" => str_replace("\n", "\n\t\t\t\t\t\t", $this->getMenu()[1]),
			"title" => $pagename,
			"subtitle" => $subpagename,
			"pageid" => implode("-", $pagetocheck)
		];
	}

	private function getMenu() {
		return $this->menu;
	}

	public function registerMenu($name, $url, $settings = []) {
		global $user;

		$settings = array_merge(["position" => "left", "rank" => -1], $settings);

		switch($settings["rank"]) {
			case -2:
				if ($user->isLoggedIn()) {
					return;
				}
				break;
			case -1:
				break;
			default:
				if (!$user->isLoggedIn() || !$user->hasAccessTo($settings["rank"])) {
					return;
				}
		}
		global $pagetocheck;

		if(isset($settings["subMenu"])) {

			//Check if active
			$isActive = false;
			foreach($settings["subMenu"] as $subMenu) {
				if($subMenu["pageurl"] == $pagetocheck[0]) {
					$isActive = true;
				}
			}

			$this->menu[$settings["position"] == "left" ? 0 : 1] .= $this->getMoustache()->render(file_get_contents("tpl/menu/menuWithSubMenu.tpl"),
					[
						"pageurl" => $url,
						"name" => $name,
						"subMenus" => $settings["subMenu"],
					]
			);
		} else {
			$this->menu[$settings["position"] == "left" ? 0 : 1] .= $this->getMoustache()->render(file_get_contents("tpl/menu/menu.tpl"),
					[
						"pageurl" => $url,
						"name" => $name,
						"active" => $pagetocheck[0] == $url
					]
			);
		}
	}

	public function getMoustache() {
		return $this->m;

	}

}

?>
