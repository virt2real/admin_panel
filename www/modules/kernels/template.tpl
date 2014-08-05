<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function SaveSettings(text){
		$("#kernels_status").html('<img src="/imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#kernels_status").html(response);
			}
			if (savestatus == "error") {
				$("#kernels_status").html("%L_FAIL%");
			}
		});
	}
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_LIST%</p>

		{kernelslist}

		<p></p>
		<p><a class="buttonlink" href="#" onclick='var kernel = $("input[name=kernel]:radio:checked").attr("id"); SaveSettings(kernel); return false;'>[ %L_SAVE% ]</a></p>

		<div id="kernels_status" class="bluetitle"></div>
	</div>

</div>
