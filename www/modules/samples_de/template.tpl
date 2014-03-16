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

	<h3><a href="#">Funktionen zum Experimentieren</a></h3>

	<div>
		<p>
		Genaueres zu diesem Lernmodul erfahren Sie in dem <a href="http://wiki.virt2real.ru/wiki/Виртурилка_для_чайников_-_статья_вторая">zweiten Einführungsartikel</a>.
		<br><br>
		</p>

		<!-- ERSTES CODEBEISPIEL - START EINES SKRIPTS MIT EINEM LINK -->
		<p>
			<p class="bluetitle">Erstes Beispiel</p>
			<a href="/modules/{module_name}/simplerun.php" target="_blank">Starte test.sh-Skript</a>
		</p>
		<!-- Ende des ersten Beispiels-->

		<br><br>


		<!-- ZWEITES CODEBEISPIEL - STARTEN EINES SKRIPTS MIT PARAMETERN -->
		<form action="/modules/{module_name}/run.php" method="post" target="_blank">
			<p class="bluetitle">Skript starten</p>
			<p> <input type="text" name="path" value="./test.sh"> Pfad zum auszuführenden Skript </p>
			<p> <input type="submit"> </p>
		</form>
		<!-- Ende des zweiten Beispiels-->

		<br><br>

		<!-- DRITTES CODEBEISPIEL - TREIBERZUGRIFF -->
		<form action="/modules/{module_name}/setgpio.php" target="_blank">
			<p class="bluetitle">GPIO-Wert setzen</p>
			<p> <input type="text" name="num" value="73"> Nummer des GPIO </p>
			<p> <input type="text" name="dir" value="output"> Arbeitsrichtung: output oder input (Ausgabe oder Eingabe) </p>
			<p> <input type="text" name="val" value="1"> Wert. Geben Sie 0 oder 1 ein </p>
			<input type="submit">
		</form>
		<!-- Ende des dritten Beispiels-->

		<br><br>

		<!-- VIERTES CODEBEISPIEL - SKRIPT -->
		<p class="bluetitle">Beispiel zur selbständigen Analyse</p>
		<p><input type="text" placeholder="test field" id="kb" /><p>

	</div>

</div>
