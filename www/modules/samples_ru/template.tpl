<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});


	$("#kb").keyup(function(e) {
		if (e.keyCode=='49')  $.post("modules/{module_name}/setgpio.php?num=73&dir=output&val=1&rnd=" + Math.random(), null, function(response, status, xhr) {});

		if (e.keyCode=='50')  $.post("modules/{module_name}/setgpio.php?num=73&dir=output&val=0&rnd=" + Math.random(), null, function(response, status, xhr) {});
	});

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Функции для экспериментов</a></h3>

	<div>
		<p>
		Подробности про этот обучающий модуль смотрите во <a href="http://wiki.virt2real.ru/wiki/Виртурилка_для_чайников_-_статья_вторая">"второй статье для чайников"</a>
		<br><br>
		</p>

		<!-- ПЕРВЫЙ ПРИМЕР КОДА - ЗАПУСКАЕМ СКРИПТ ССЫЛКОЙ -->
		<p>
			<p class="bluetitle">Первый пример</p>
			<a href="/modules/{module_name}/simplerun.php" target="_blank">Start test.sh script</a>
		</p>
		<!-- окончание первого примера-->

		<br><br>


		<!-- ВТОРОЙ ПРИМЕР КОДА - ЗАПУСКАЕМ СКРИПТ С ПАРАМЕТРАМИ -->
		<form action="/modules/{module_name}/run.php" method="post" target="_blank">
			<p class="bluetitle">Запустить скрипт</p>
			<p> <input type="text" name="path" value="./test.sh"> Путь к исполняемому скрипту </p>
			<p> <input type="submit"> </p>
		</form>
		<!-- окончание второго примера-->

		<br><br>

		<!-- ТРЕТИЙ ПРИМЕР КОДА - ДОСТУП К ДРАЙВЕРУ -->
		<form action="/modules/{module_name}/setgpio.php" target="_blank">
			<p class="bluetitle">Установить значение GPIO</p>
			<p> <input type="text" name="num" value="73"> GPIO number (номер GPIO) </p>
			<p> <input type="text" name="dir" value="output"> Направление работы: output или input (вывод или ввод) </p>
			<p> <input type="text" name="val" value="1"> Значение. Введите 0 или 1 </p>
			<input type="submit">
		</form>
		<!-- окончание третьего примера-->

		<br><br>

		<!-- ЧЕТВЕРТЫЙ ПРИМЕР КОДА - СКРИПТ -->
		<p class="bluetitle">Пример для самостоятельного анализа</p>
		<p><input type="text" placeholder="test field" id="kb" /><p>

	</div>

</div>
