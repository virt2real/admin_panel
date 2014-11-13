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

	<h3><a href="#">Functions for experimenting</a></h3>

	<div>
		<p>
		For details about this training module take a look at the <a href="http://wiki.virt2real.ru/wiki/Виртурилка_для_чайников_-_статья_вторая">second article for dummies</a>.
		<br><br>
		</p>

		<!-- FIRST CODE EXAMPLE - RUN A SCRIPT WITH A HYPERLINK -->
		<p>
			<p class="bluetitle">First example</p>
			<a href="modules/{module_name}/simplerun.php" target="_blank">Start test.sh script</a>
		</p>
		<!-- end of the first example-->

		<br><br>


		<!-- SECOND CODE EXAMPLE - RUN A SCRIPT WITH PARAMETERS -->
		<form action="modules/{module_name}/run.php" method="post" target="_blank">
			<p class="bluetitle">Start script</p>
			<p> <input type="text" name="path" value="./test.sh"> Path to executable script </p>
			<p> <input type="submit"> </p>
		</form>
		<!-- end of the second example-->

		<br><br>

		<!-- THIRD CODE EXAMPLE - ACCESSING THE DRIVER -->
		<form action="modules/{module_name}/setgpio.php" target="_blank">
			<p class="bluetitle">Set GPIO value</p>
			<p> <input type="text" name="num" value="73"> GPIO number</p>
			<p> <input type="text" name="dir" value="output"> Direction of operation: output or input</p>
			<p> <input type="text" name="val" value="1"> Value. Enter 0 or 1 </p>
			<input type="submit">
		</form>
		<!-- end of the third example-->

		<br><br>

		<!-- FOURTH CODE EXAMPLE - SCRIPT -->
		<p class="bluetitle">Example for analysing by yourself</p>
		<p><input type="text" placeholder="test field" id="kb" /><p>

	</div>

</div>
