<?php

/*****************************************************
* modules/board/pins.php
* pinout description file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

function GetPinArray() {

	include '../../parts/connectors.php';

	$pinArray [0][] = $PINS_ARRAY[1];
	$pinArray [0][] = $PINS_ARRAY[23];
	$pinArray [0][] = $PINS_ARRAY[45];
	$pinArray [0][] = $PINS_ARRAY[66];

	$pinArray [1][] = $PINS_ARRAY[2];
	$pinArray [1][] = $PINS_ARRAY[24];
	$pinArray [1][] = $PINS_ARRAY[46];
	$pinArray [1][] = $PINS_ARRAY[67];

	$pinArray [2][] = $PINS_ARRAY[3];
	$pinArray [2][] = $PINS_ARRAY[25];
	$pinArray [2][] = $PINS_ARRAY[47];
	$pinArray [2][] = $PINS_ARRAY[68];

	$pinArray [3][] = $PINS_ARRAY[4];
	$pinArray [3][] = $PINS_ARRAY[26];
	$pinArray [3][] = $PINS_ARRAY[48];
	$pinArray [3][] = $PINS_ARRAY[69];

	$pinArray [4][] = $PINS_ARRAY[5];
	$pinArray [4][] = $PINS_ARRAY[27];
	$pinArray [4][] = $PINS_ARRAY[49];
	$pinArray [4][] = $PINS_ARRAY[70];

	$pinArray [5][] = $PINS_ARRAY[6];
	$pinArray [5][] = $PINS_ARRAY[28];
	$pinArray [5][] = $PINS_ARRAY[50];
	$pinArray [5][] = $PINS_ARRAY[71];

	$pinArray [6][] = $PINS_ARRAY[7];
	$pinArray [6][] = $PINS_ARRAY[29];
	$pinArray [6][] = $PINS_ARRAY[51];
	$pinArray [6][] = $PINS_ARRAY[72];

	$pinArray [7][] = $PINS_ARRAY[8];
	$pinArray [7][] = $PINS_ARRAY[30];
	$pinArray [7][] = $PINS_ARRAY[52];
	$pinArray [7][] = $PINS_ARRAY[73];

	$pinArray [8][] = $PINS_ARRAY[9];
	$pinArray [8][] = $PINS_ARRAY[31];
	$pinArray [8][] = $PINS_ARRAY[53];
	$pinArray [8][] = $PINS_ARRAY[74];

	$pinArray [9][] = $PINS_ARRAY[10];
	$pinArray [9][] = $PINS_ARRAY[32];
	$pinArray [9][] = $PINS_ARRAY[54];
	$pinArray [9][] = $PINS_ARRAY[75];

	$pinArray [10][] = $PINS_ARRAY[11];
	$pinArray [10][] = $PINS_ARRAY[33];
	$pinArray [10][] = $PINS_ARRAY[55];
	$pinArray [10][] = $PINS_ARRAY[76];

	$pinArray [11][] = $PINS_ARRAY[12];
	$pinArray [11][] = $PINS_ARRAY[34];
	$pinArray [11][] = $PINS_ARRAY[56];
	$pinArray [11][] = $PINS_ARRAY[77];

	$pinArray [12][] = $PINS_ARRAY[13];
	$pinArray [12][] = $PINS_ARRAY[35];
	$pinArray [12][] = $PINS_ARRAY[57];
	$pinArray [12][] = $PINS_ARRAY[78];

	$pinArray [13][] = $PINS_ARRAY[14];
	$pinArray [13][] = $PINS_ARRAY[36];
	$pinArray [13][] = $PINS_ARRAY[58];
	$pinArray [13][] = $PINS_ARRAY[79];

	$pinArray [14][] = $PINS_ARRAY[15];
	$pinArray [14][] = $PINS_ARRAY[37];
	$pinArray [14][] = $PINS_ARRAY[59];
	$pinArray [14][] = $PINS_ARRAY[80];

	$pinArray [15][] = $PINS_ARRAY[16];
	$pinArray [15][] = $PINS_ARRAY[38];
	$pinArray [15][] = $PINS_ARRAY[60];
	$pinArray [15][] = $PINS_ARRAY[81];

	$pinArray [16][] = $PINS_ARRAY[17];
	$pinArray [16][] = $PINS_ARRAY[39];
	$pinArray [16][] = $PINS_ARRAY[61];
	$pinArray [16][] = $PINS_ARRAY[82];

	$pinArray [17][] = $PINS_ARRAY[18];
	$pinArray [17][] = $PINS_ARRAY[40];
	$pinArray [17][] = $PINS_ARRAY[62];
	$pinArray [17][] = $PINS_ARRAY[83];

	$pinArray [18][] = $PINS_ARRAY[19];
	$pinArray [18][] = $PINS_ARRAY[41];
	$pinArray [18][] = $PINS_ARRAY[63];
	$pinArray [18][] = $PINS_ARRAY[84];

	$pinArray [19][] = $PINS_ARRAY[20];
	$pinArray [19][] = $PINS_ARRAY[42];
	$pinArray [19][] = $PINS_ARRAY[64];
	$pinArray [19][] = $PINS_ARRAY[85];

	$pinArray [20][] = $PINS_ARRAY[21];
	$pinArray [20][] = $PINS_ARRAY[43];
	$pinArray [20][] = $PINS_ARRAY[65];
	$pinArray [20][] = $PINS_ARRAY[86];

	$pinArray [21][] = $PINS_ARRAY[22];
	$pinArray [21][] = $PINS_ARRAY[44];
	$pinArray [21][] = "";
	$pinArray [21][] = "";

	return $pinArray;

}

?>