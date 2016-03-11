<?php
if($user->isLoggedIn()) {
  header("Location: ./me");
} else {
  //header("Location: ./login");
}
//exit();
