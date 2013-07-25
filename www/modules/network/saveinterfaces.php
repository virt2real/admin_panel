<?php
	/*
		saveinterfaces.php
		Save interfaces settings
		(c)virt2real.ru 2012
	*/

	$filename = '/etc/network/interfaces';
	$somecontent = $_GET['text'];

	if (is_writable($filename)) {
	    if (!$handle = fopen($filename, 'w')) {
			die("can not access file $filename");
		}

    	if (fwrite($handle, $somecontent) === FALSE) {
        	die("can not write $filename");
	    }

    	echo "successfully saved";

	    fclose($handle);

	} else {
		echo "no access to $filename";
	}

?>