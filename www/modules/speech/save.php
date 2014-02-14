<?php

/*****************************************************
* modules/speech/save.php
* save global speech settings
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

include '/etc/virt2real/speech/config.php';

/* override lang setting */
if (isset($_POST['lang'])) $LANG = $_POST['lang'];

/* override engine setting */
if (isset($_POST['engine'])) $SPEECH_ENGINE = $_POST['engine'];

SaveSettings($LANG, $SPEECH_ENGINE, $SPEAKERRORS);

?>