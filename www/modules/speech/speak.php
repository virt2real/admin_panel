<?php

/*****************************************************
* modules/speech/speak.php
* speak text
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['text'])) die('empty text');

include('/etc/virt2real/speech/config.php');

/* override lang setting */
if (isset($_POST['lang'])) $LANG = $_POST['lang'];

/* override engine setting */
if (isset($_POST['engine'])) $SPEECH_ENGINE = $_POST['engine'];

include('/etc/virt2real/speech/include.php');

Speak($_POST['text']);

?>