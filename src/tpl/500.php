<?php
http_response_code(500);
$pagename = "500, Er ging iets mis op de server";
$pagecontents .= file_get_contents(__DIR__ . "/500.tpl");
$subpagename = "";
