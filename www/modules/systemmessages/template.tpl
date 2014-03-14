<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		load_messages(50);
	}

	var messages_timer;

	function update_messages(){

		if (messages_timer)
			$("#messagesloader").css("display","block");
		else
			$("#messagesloader").css("display","none");

		load_messages(50);
		messages_timer = setTimeout("update_messages()", 1000);
	}

	function load_messages(num){
		$.get("modules/{module_name}/get.php?num=" + num + "&" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#messages_status").html(response);
			}
			if (status == "error") {
				$("#messages_status").html("%L_FAIL%");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_SYSTEM_MONITORING%</p>
		<div>

			<a href="" class="buttonlink" onclick='if (!messages_timer) messages_timer = setTimeout("update_messages()", 1); return false;'>[ %L_START_QUERY% ]</a>
			<a href="" class="buttonlink" onclick='clearInterval(messages_timer); messages_timer = false; $("#messagesloader").css("display","none"); return false;'>[ %L_STOP_QUERY% ]</a>

			<p style="height:20px;"><img id="messagesloader" src="/imgs/loader.gif" style="display: none;"></p>

			</p>
		</div>
		<div id="messages_status"></div>
	</div>
</div>

</div>
