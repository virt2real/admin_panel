<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script type="text/javascript">
	$(function() {
		$( "#inputselect" ).buttonset();
	});

	function SetInput(input){

		$("#inputstatus").html('<img src="/imgs/loader.gif">');

		$.post("modules/{module_name}/set.php?rnd=" + Math.random(), {input: input}, function(response, status, xhr) {
			if (status == "success") {
				$("#inputstatus").html(response);
			}
			if (savestatus == "error") {
				$("#inputstatus").html("%L_FAIL%");
			}
		});

	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_CAM_TITLE%</p>
		<div>

			<p>&nbsp;</p>

			<div id="inputselect">
				<input onclick="SetInput(0);" type="radio" id="input1" name="radio" {input1}><label for="input1">%M_INPUT1%</label>
				<input onclick="SetInput(1);" type="radio" id="input2" name="radio" {input2}><label for="input2">%M_INPUT2%</label>
			</div>

			<p>&nbsp;</p>
			<div id="inputstatus"></div>

		</div>
	</div>
</div>

</div>
