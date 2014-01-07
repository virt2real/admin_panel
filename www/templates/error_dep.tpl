<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {} });
	});

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Ошибка зависимостей</a></h3>
	<div>
		<p class="bluetitle">Для корректной работы модуля необходимы следующие файлы</p>
		<div>{dep_files}</div>
		<p></p>
		<p class="bluetitle">Для решения проблемы попробуйте установить</p>
		<div>{dep_descr}</div>
	</div>
</div>

</div>