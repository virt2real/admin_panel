<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	var gpio_timer;

	function update_gpio(){
		if (gpio_timer) 
			$("#gpioloader").css("display","block");
		else
			$("#gpioloader").css("display","none");
		
		load_gpio();
		gpio_timer = setTimeout("update_gpio()", 1000);
	}

	function load_gpio(num){
		$.get("modules/{module_name}/get.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#currentgpiostate").html(response);
			}
			if (status == "error") {
				$("#currentgpiostate").html("error");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Пины GPIO</a></h3>
	<div>
		<p>

			<a href="" class="buttonlink" onclick='if (!gpio_timer) gpio_timer = setTimeout("update_gpio()", 1); return false;'>[ Запустить опрос ]</a>
			<a href="" class="buttonlink" onclick='clearTimeout(gpio_timer); gpio_timer = false; $("#gpioloader").css("display","none"); return false;'>[ Остановить опрос ]</a>

			<p style="height:20px;"><img id="gpioloader" src="/imgs/loader.gif" style="display: none;"></p>

		</p>

		<div id="currentgpiostate">
			{gpiolist}
		</div>

	</div>

</div>