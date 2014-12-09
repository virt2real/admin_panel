<?php

/*****************************************************
* modules/ubl/loc/module.en.php
* module english locale file
* (c)virt2real.de 2014
* draft, by Gol
/*****************************************************/

$lang = array(// common items
              'M_DESC'               => 'Overclocking',
              // module-specific
              'M_CPU_INFO'      	 => 'Current CPU info',
              'M_FREQ'      		 => 'Frequency',
              'M_BOGOMIPS'      	 => 'BogoMIPS',
              'M_MHZ'      			 => 'MHz',
			  'M_300MHZ'			 => '300 MHz',
			  'M_432MHZ'			 => '432 MHz',
              'M_WRITE'              => 'Set',
			  'M_ACTIONTITLE'		 => 'CPU settings change',
              'M_INFO'     			 => 'CPU frequency settings is set up in UBL (User Boot Loader).<br>After pressing "Set" current UBL will be rewrited and after reboot CPU will use new parameters',
			  'M_ALERT'				 => 'ATTENTION!<br>High CPU frequency can damage Virt2real hardware.<br>Before you select "432 MHz" and push "Set", think twice.<br>The <span style="color:#ffffff;">Virt</span> <span style="color:#0000ff;">2</span> <span style="color:#ffffff;">real</span> company is not responsible for damaged hardware.',
			  'M_SURE'				 => 'Are you sure',
			  'M_REALLY_LEAVE'		 => 'Really change CPU settings?',
			  'M_YES'		 		 => 'Yes, let\'s try',
			  'M_NO'		 		 => 'No, thanx',
			  'M_DONESUCCESS'		 => 'UBL settings successfully saved.<br><br><a href=\"?reboot\">Please, reboot</a>',
			  'M_DONEFAIL'			 => 'Can\'t save UBL settings',
			  'M_ONLYFORSDBOOT'		 => 'UBL settings from NAND boot not working yet',
              );

?>
