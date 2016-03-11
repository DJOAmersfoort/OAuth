<?php
http_response_code(404);
$pagename = "404, Pagina niet gevonden";
$pagecontents .= file_get_contents(__DIR__ . "/404.tpl");
$subpagename = "";
