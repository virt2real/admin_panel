<?php

/*****************************************************
* modules/speech/run.php
* run speech recognition script
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

$VERBOSE = 0;

include('/etc/virt2real/speech/include.php');

RecordSpeech('record');

if ( ($text = GetResultText('record', false)) != -1)
	echo $text;
else
	echo 'error';

?>