<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	var gpio_timer;
	var gpio_timer2;
	var gpio_timer3;

	var gpio_run1 = 0;
	var gpio_run2 = 0;
	var gpio_run3 = 0;

	var savegpiostate = "";
	var saveconstate = "";
	
	function update_gpio(){
		if (gpio_timer) 
			$("#gpioloader").css("display","block");
		else
			$("#gpioloader").css("display","none");
		
		load_gpio();
		
	}

	function load_gpio(){
		$.get("modules/{module_name}/get.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#currentgpiostate").html(response);
			}
			if (status == "error") {
				$("#currentgpiostate").html("error");
			}
			if (gpio_run1) gpio_timer = setTimeout("update_gpio()", 1000);
		});
	}


	<!-- **************************************************************-->
	<!-- 	for GPIO						   -->
	<!-- **************************************************************-->

	function update_gpio2(){
		if (gpio_timer2) 
			$("#gpioloader2").css("display","block");
		else
			$("#gpioloader2").css("display","none");
		
		load_gpio2();
		if (gpio_run2) gpio_timer2 = setTimeout("update_gpio2()", 1000);
	}


	function load_gpio2(){
		$.get("modules/{module_name}/get2.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {

				if (!savegpiostate)
					savegpiostate = response;
				else  {
					if (response != savegpiostate) {
						for (var i = 0 ; i < response.length ; i++) {
							if (savegpiostate[i] != response[i]) {
								if ($("#gpiohistory").html().length > 200) $("#gpiohistory").empty();
								$("#gpiohistory").html("GPIO " + i + " changed to " + response[i] + "<br>" + $("#gpiohistory").html());
							}
						}

						savegpiostate = response;
						
					}
				}


				for (var i=0; i < response.length; i++) {
					$("#gpio" + i + "value").html(response[i]);
					if (response[i] == "1") {
						$("#gpio" + i + "value").removeClass("gpiolow");
						$("#gpio" + i + "value").addClass("gpiohigh");
					} else {
						$("#gpio" + i + "value").removeClass("gpiohigh");
						$("#gpio" + i + "value").addClass("gpiolow");
					}
				}
			}
			if (status == "error") {
				$("#currentgpiostate2").html("error");
			}
		});
	}


	$(".gpiolist").click(function() {
		
		var result = "";
		var emptylist = true;
		
		var gpio = $(this).attr("gpio");

		if ($("#gpio" + gpio).hasClass("whiteback"))
			$("#gpio" + gpio).removeClass("whiteback");
		else
			$("#gpio" + gpio).addClass("whiteback");

		$('.gpiolist').each(function(i, elem) {

			if ($(this).hasClass("whiteback")) {

				if (emptylist) emptylist = false;
        			result += i + " ";

			}
		});

		if (result) {
			$("#gpioselectedlist").html(result);
			$("#gpioselectedblock").css("display", "block");
		}
		if (emptylist) {
			$("#gpioselectedlist").html(" ");
			$("#gpioselectedblock").css("display", "none");
		}

	});

	$(".gpiolist").mouseover(function(){
		var gpio = $(this).attr("gpio");
		$("#gpio" + gpio).addClass("bordered");
	});

	$(".gpiolist").mouseout(function(){
		var gpio = $(this).attr("gpio");
		$("#gpio" + gpio).removeClass("bordered");
	});


	function set_gpio(direction, value) {

		var selectedgpiolist = "";

		$('.gpiolist').each(function(i, elem) {
			if ($(this).hasClass("whiteback")) {
				selectedgpiolist += i + ",";
			}
		});

		$.get("modules/{module_name}/setgpio.php?num=" + selectedgpiolist + "&dir=" + direction + "&val=" + value + "&" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				load_gpio2();
			}
			if (status == "error") {
			}
		});
	}


	function clear_gpio_selection() {
		$('.gpiolist').each(function(i, elem) {
			if ($(this).hasClass("whiteback")) {
				$(this).removeClass("whiteback");
			}
		});

		$("#gpioselectedlist").html(" ");
		$("#gpioselectedblock").css("display", "none");

	}


	<!-- **************************************************************-->
	<!-- 	for CON							   -->
	<!-- **************************************************************-->

	function update_con(){

		if (gpio_timer3) 
			$("#gpioloader3").css("display","block");
		else
			$("#gpioloader3").css("display","none");
		
		load_con();
		
	}


	function load_con() { 
		$.get("modules/{module_name}/get3.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {

				if (!saveconstate)
					saveconstate = response;
				else  {
					if (response != saveconstate) {
						for (var i = 0 ; i < response.length ; i++) {
							if (saveconstate[i] != response[i]) {
								if ($("#conhistory").html().length > 200) $("#conhistory").empty();
								$("#conhistory").html("CON " + i + " changed to " + response[i] + "<br>" + $("#conhistory").html());
							}
						}

						saveconstate = response;
						
					}
				}

				for (var i=0; i < response.length; i++) {
					if ( ! $("#con" + i + "value").length) continue;
					$("#con" + i + "value").html(response[i]);
					if (response[i] == "1") {
						$("#con" + i + "value").removeClass("conlow");
						$("#con" + i + "value").addClass("conhigh");
					} else {
						$("#con" + i + "value").removeClass("conhigh");
						$("#con" + i + "value").addClass("conlow");
					}
				}
			}
			if (status == "error") {
				$("#currentconstate").html("error");
			}

			if (gpio_run3) gpio_timer3 = setTimeout("update_con()", 1000);
		});
	}



	$(".conlist").click(function() {
		
		var result = "";
		var emptylist = true;
		
		var con = $(this).attr("con");

		if ($("#con" + con).hasClass("whiteback"))
			$("#con" + con).removeClass("whiteback");
		else
			$("#con" + con).addClass("whiteback");

		$('.conlist').each(function(i, elem) {

			if ($(this).hasClass("whiteback")) {

				if (emptylist) emptylist = false;
        			result += $(elem).attr("con") + " ";
			}
		});

		if (result) {
			$("#conselectedlist").html(result);
			$("#conselectedblock").css("display", "block");
		}
		if (emptylist) {
			$("#conselectedlist").html(" ");
			$("#conselectedblock").css("display", "none");
		}

	});

	$(".conlist").mouseover(function(){
		var con = $(this).attr("con");
		$("#con" + con).addClass("bordered");
	});

	$(".conlist").mouseout(function(){
		var con = $(this).attr("con");
		$("#con" + con).removeClass("bordered");
	});

	function set_con(direction, value) {

		var selectedconlist = "";

		$('.conlist').each(function(i, elem) {
			if ($(this).hasClass("whiteback")) {
				selectedconlist += $(elem).attr("con") + ",";
			}
		});

		$.get("modules/{module_name}/setcon.php?num=" + selectedconlist + "&dir=" + direction + "&val=" + value + "&" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				load_con();
			}
			if (status == "error") {
			}
		});
	}



	function clear_con_selection() {
		$('.conlist').each(function(i, elem) {
			if ($(this).hasClass("whiteback")) {
				$(this).removeClass("whiteback");
			}
		});

		$("#conselectedlist").html(" ");
		$("#conselectedblock").css("display", "none");

	}


</script>

<style>

.conlist, .gpiolist {
  display: inline;
  margin-right: 15px;
  font-family: "Lucida Console", Monaco, monospace; 
  font-size:1.2em;
  color: #7c7c7c;
  padding: 2px;
  line-height: 20px;
}

.conhigh, .gpiohigh {
  color: #ff0000;
}

.conlow, .gpiolow {
  color: #00ff00;
}

.bordered {
  border: 1px solid #7f7f7f;
}

.whiteback {
  background-color: #ffffff;
}

#conselectedblock, #gpioselectedblock {
  display: none;
}

</style>

<div id="accordion" style="margin:0; padding:0;">


	<h3><a href="#">Пины CON через драйвер /dev/v2r_pins</a></h3>
	<div>
		<p>
			<a href="" class="buttonlink" onclick='gpio_run3 = 1; if (!gpio_timer3) gpio_timer3 = setTimeout("update_con()", 1); return false;'>[ Запустить опрос ]</a>
			<a href="" class="buttonlink" onclick='gpio_run3 = 0; clearTimeout(gpio_timer3); gpio_timer3 = false; $("#gpioloader3").css("display","none"); return false;'>[ Остановить опрос ]</a>

			<p style="height:20px;"><img id="gpioloader3" src="/imgs/loader.gif" style="display: none;"></p>
		</p>

		<div id="currentconstate">
			{conlist}
		</div>

		<div id="conselectedblock">
			<p class="bluetitle" id="selectedcontitle">Выбранные CON: <span style="padding-left: 40px;"><a href="" class="buttonlink" onclick='clear_con_selection(); return false;'>[ снять выделение ]</a></span></p>
			<div id="conselectedlist"></div>

			<p></p>
			<span class="bluetitle">Установить направление как Output и значение </span>
			<a href="" class="buttonlink" onclick='set_con(1, 0); return false;'>[ 0 ]</a>
			<a href="" class="buttonlink" onclick='set_con(1, 1); return false;'>[ 1 ]</a>

			<p></p>
			<span class="bluetitle">Установить направление как Input </span>
			<a href="" class="buttonlink" onclick='set_con(0, 0); return false;'>[ установить ]</a>

		</div>

		<p class="bluetitle">Лог изменений состояния пинов CON</p>
		<div id="conhistory"></div>

	</div>


	<h3><a href="#">GPIO через драйвер /dev/v2r_gpio</a></h3>
	<div>
		<p>
			<a href="" class="buttonlink" onclick='gpio_run2 = 1; if (!gpio_timer2) gpio_timer2 = setTimeout("update_gpio2()", 1); return false;'>[ Запустить опрос ]</a>
			<a href="" class="buttonlink" onclick='gpio_run2 = 0; clearTimeout(gpio_timer2); gpio_timer2 = false; $("#gpioloader2").css("display","none"); return false;'>[ Остановить опрос ]</a>

			<p style="height:20px;"><img id="gpioloader2" src="/imgs/loader.gif" style="display: none;"></p>
		</p>

		<div id="currentgpiostate2">
			{gpiolist2}
		</div>

		<div id="gpioselectedblock">
			<p class="bluetitle" id="selectedtitle">Выбранные GPIO: <span style="padding-left: 40px;"><a href="" class="buttonlink" onclick='clear_gpio_selection(); return false;'>[ снять выделение ]</a></span></p>
			<div id="gpioselectedlist"></div>

			<p></p>
			<span class="bluetitle">Установить направление как Output и значение </span>
			<a href="" class="buttonlink" onclick='set_gpio(1, 0); return false;'>[ 0 ]</a>
			<a href="" class="buttonlink" onclick='set_gpio(1, 1); return false;'>[ 1 ]</a>

			<p></p>
			<span class="bluetitle">Установить направление как Input </span>
			<a href="" class="buttonlink" onclick='set_gpio(0, 0); return false;'>[ установить ]</a>

		</div>


		<p class="bluetitle">Лог изменений состояния GPIO</p>
		<div id="gpiohistory"></div>

	</div>

	<h3><a href="#">GPIO в debug_fs</a></h3>
	<div>
		<p>

			<a href="" class="buttonlink" onclick='gpio_run1 = 1; if (!gpio_timer) gpio_timer = setTimeout("update_gpio()", 1); return false;'>[ Запустить опрос ]</a>
			<a href="" class="buttonlink" onclick='gpio_run1 = 1; clearTimeout(gpio_timer); gpio_timer = false; $("#gpioloader").css("display","none"); return false;'>[ Остановить опрос ]</a>

			<p style="height:20px;"><img id="gpioloader" src="/imgs/loader.gif" style="display: none;"></p>

		</p>

		<div id="currentgpiostate">
			{gpiolist}
		</div>

	</div>

</div>