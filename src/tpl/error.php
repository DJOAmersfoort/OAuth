<?php
http_response_code(500);
$pagename = "500, Er ging iets mis op de server";
$pagecontents .= $m->render(file_get_contents(__DIR__ . "/error.tpl"), [
  "error" => $error,
  "transistors" => rand(10,50)
]);
