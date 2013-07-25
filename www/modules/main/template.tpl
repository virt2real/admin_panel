<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Общая информация</a></h3>
	<div>
			<p><strong>Идентификатор устройства</strong></p>
			<p style="margin-left: 50px; font-size: 1.4em; color: #0380ea; font-weight: bold;">{deviceID}</p>
			<p><strong>Описание</strong></p>
			<p style="margin-left: 50px;">{deviceDescription}</p>

			<p>&nbsp;</p>
			<p>&nbsp;</p>

	</div>

	<h3><a href="#">Информация о ядре</a></h3>
	<div>

			<div>{linuxversion}</div>
			<br>
			<div><p>Cmdline:</p><p>{cmdline}</p></div>


	</div>

	<h3><a href="#">Информация о процессоре</a></h3>
	<div>
			<div>
			<div><p>CPU:</p><p>{cpuinfo}</p></div>
			<br>
			<div><p>Memory:</p><p>{meminfo}</p></div>
			<br>
			</div>
	</div>

	<h3><a href="#">Активные модули</a></h3>
	<div>
			<div>{modules}</div>
	</div>

</div>
