<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}

</script>

<script>
	var dmesg_timer;

	function update_dmesg(){

		if (dmesg_timer) 
			$("#dmesgloader").css("display","block");
		else
			$("#dmesgloader").css("display","none");

		load_dmesg(20);
		dmesg_timer = setTimeout("update_dmesg()", 1000);
	}

	function load_dmesg(num){		$.get("modules/{module_name}/get.php?num=" + num + "&" + Math.random(), function(response, status, xhr) {			if (status == "success") {
				$("#dmesg_status").html(response);
			}
			if (status == "error") {
				$("#dmesg_status").html("error");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Сообщения ядра</a></h3>
	<div>
		<p class="bluetitle">Мониторинг сообщений ядра</p>
		<div>
			<form onSubmit="updateTimer(); return false;">
			</form>

			<a href="" class="buttonlink" onclick='load_dmesg(); return false;'>[ показать весь вывод dmesg ]</a>
			<a href="" class="buttonlink" onclick='if (!dmesg_timer) dmesg_timer = setTimeout("update_dmesg()", 1); return false;'>[ Запустить опрос ]</a>
			<a href="" class="buttonlink" onclick='clearInterval(dmesg_timer); dmesg_timer = false; $("#dmesgloader").css("display","none"); return false;'>[ Остановить опрос ]</a>

			<p style="height:20px;"><img id="dmesgloader" src="/imgs/loader.gif" style="display: none;"></p>

			</p>
		</div>
		<div id="dmesg_status">{dmesg_status}</div>
	</div>
</div>

</div>