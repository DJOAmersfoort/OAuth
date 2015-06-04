<?php
http_response_code(404);
$pagename = "500, Er ging iets mis op de server";
$pagecontents .= "<p>Iemand heeft een fout gemaakt in het recept van deze pagina dus het bakken lukte niet helemaal.. probeer het later nog eens!</p><br /><a href=\"/\" class=\"btn btn-default\">Terug naar de startpagina</a>";

?>