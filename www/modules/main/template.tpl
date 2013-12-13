<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Общая информация</a></h3>
	<div>
			<p style="text-align: right;">Версия админки: {admin_version}</p>
			<p class="bluetitle">Идентификатор устройства</p>
			<p style="margin-left: 50px; font-size: 1.4em; ">{deviceID}</p>
			<p class="bluetitle">Описание</p>
			<p style="margin-left: 50px;">{deviceDescription}</p>

			<p><a href="?deviceid">[ изменить ]</a></p>
			<p></p>

	</div>

	<h3><a href="#">Информация о ядре</a></h3>
	<div>

			<div>{linuxversion}</div>
			<br>
			<div>
				<p class="bluetitle">Cmdline:</p>
				<p>{cmdline}</p>
			</div>


	</div>

	<h3><a href="#">Информация о процессоре</a></h3>
	<div>
			<div>
			<div><p class="bluetitle">CPU:</p><p>{cpuinfo}</p></div>
			<br>
			<div><p class="bluetitle">Memory:</p><p>{meminfo}</p></div>
			<br>
			</div>
	</div>

	<h3><a href="#">Активные модули</a></h3>
	<div>
			<div>{modules}</div>
	</div>

</div>
