<?php

/*****************************************************
* modules/board/pins.php
* pinout description file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

function GetPinArray() {

	$pinArray [0][] = "2. GND";
	$pinArray [0][] = "1. RESET";
	$pinArray [0][] = "2. TV OUT";
	$pinArray [0][] = "1. A_GND";

	$pinArray [1][] = "4. UART0 TXD";
	$pinArray [1][] = "3. LINE OUT";
	$pinArray [1][] = "4. SPEAKER +";
	$pinArray [1][] = "3. +3.3V";

	$pinArray [2][] = "6. UART0 RXD";
	$pinArray [2][] = "5. GPIO1";
	$pinArray [2][] = "6. SPEAKER -";
	$pinArray [2][] = "5. PWR_VIN";

	$pinArray [3][] = "8. A_GND";
	$pinArray [3][] = "7. GPIO37";
	$pinArray [3][] = "8. ADC0";
	$pinArray [3][] = "7. DSP_GND";

	$pinArray [4][] = "10. ETH_TXP";
	$pinArray [4][] = "9. GPIO36";
	$pinArray [4][] = "10. ADC1";
	$pinArray [4][] = "9. I2C DATA";

	$pinArray [5][] = "12. ETH_TXN";
	$pinArray [5][] = "11. GPIO17";
	$pinArray [5][] = "12. ADC2";
	$pinArray [5][] = "11. I2C CLK";

	$pinArray [6][] = "14. ETH_RXP";
	$pinArray [6][] = "13. GPIO16";
	$pinArray [6][] = "14. ADC3";
	$pinArray [6][] = "13. CmpPR";

	$pinArray [7][] = "16. ETH_COMMON";
	$pinArray [7][] = "15. GPIO33";
	$pinArray [7][] = "16. ADC4";
	$pinArray [7][] = "15. CmpY";

	$pinArray [8][] = "18. ETH_RXN";
	$pinArray [8][] = "17. GPIO32";
	$pinArray [8][] = "18. ADC5";
	$pinArray [8][] = "17. CmpPB";

	$pinArray [9][] = "20. GPIO15";
	$pinArray [9][] = "19. GPIO31";
	$pinArray [9][] = "20. GPIO3";
	$pinArray [9][] = "19. GPIO49";

	$pinArray [10][] = "22. GPIO14";
	$pinArray [10][] = "21. GPIO30";
	$pinArray [10][] = "22. GPIO4";
	$pinArray [10][] = "21. GPIO48";

	$pinArray [11][] = "24. GPIO13";
	$pinArray [11][] = "23. GPIO29";
	$pinArray [11][] = "24. GPIO5";
	$pinArray [11][] = "23. GPIO47";

	$pinArray [12][] = "26. GPIO12";
	$pinArray [12][] = "25. GPIO28";
	$pinArray [12][] = "26. GPIO6";
	$pinArray [12][] = "25. GPIO46";

	$pinArray [13][] = "28. GPIO11";
	$pinArray [13][] = "27. GPIO27";
	$pinArray [13][] = "28. GPIO7";
	$pinArray [13][] = "27. GPIO45";

	$pinArray [14][] = "30. GPIO10";
	$pinArray [14][] = "29. GPIO26";
	$pinArray [14][] = "30. GPIO8";
	$pinArray [14][] = "29. GPIO44";

	$pinArray [15][] = "32. GPIO90 / PWM2";
	$pinArray [15][] = "31. GPIO2";
	$pinArray [15][] = "32. GPIO9";
	$pinArray [15][] = "31. GPIO35";

	$pinArray [16][] = "34. GPIO89";
	$pinArray [16][] = "33. GPIO24";
	$pinArray [16][] = "34. GPIO82";
	$pinArray [16][] = "33. GPIO84";

	$pinArray [17][] = "36. GPIO88";
	$pinArray [17][] = "35. GPIO23";
	$pinArray [17][] = "36. GPIO79";
	$pinArray [17][] = "35. GPIO83";

	$pinArray [18][] = "38. GPIO87";
	$pinArray [18][] = "37. GPIO22";
	$pinArray [18][] = "38. GPIO86";
	$pinArray [18][] = "37. GPIO25";

	$pinArray [19][] = "40. GPIO50";
	$pinArray [19][] = "39. GPIO80 / PWM3";
	$pinArray [19][] = "40. GPIO85";
	$pinArray [19][] = "39. GPIO34";

	$pinArray [20][] = "42. PWR_VIN";
	$pinArray [20][] = "41. GPIO92 / PWM0";
	$pinArray [20][] = "42. GPIO81";
	$pinArray [20][] = "41. GND";

	$pinArray [21][] = "44. +3.3V";
	$pinArray [21][] = "43. GPIO91 / PWM1";
	$pinArray [21][] = "";
	$pinArray [21][] = "";

	return $pinArray;

}

?>