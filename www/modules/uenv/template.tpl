<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function SaveSettings(text){
		$(".uenv_status").html('<img src="/imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$(".uenv_status").html(response);
			}
			if (savestatus == "error") {
				$(".uenv_status").html("%L_FAIL%");
			}
		});
	}
</script>

<div id="accordion" style="margin:0; padding:0;">

	{uenvcontent}

</div>
