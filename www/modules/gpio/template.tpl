<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Пины GPIO</a></h3>
	<div>
		<p>Состояние пинов</p>
			<div id="currentgpiostate">
				{gpiolist}
			</div>
		<br>
	</div>

</div>