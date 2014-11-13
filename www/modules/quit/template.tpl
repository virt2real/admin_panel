<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function tryQuit(){
		$(function() {
			$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:250,
				width: 400,
				modal: true,
				buttons: {
					"%M_YES%": function() {
						quit();
					},
					"%M_NO%": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
	}

	function quit(){
		$("#resetStatus").load("modules/{module_name}/quit.php", function(response, status, xhr) {
			location.replace("./");
		});
	}
</script>

<!-- Dialog -->
<div id="dialog-confirm" title="%M_LEAVE_INTERFACE%?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>%M_REALLY_LEAVE%</p>
</div>
<!-- End dialog -->


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_LEAVE_INTERFACE%</a></h3>
	<div>
		<p>
			<a href="" class="buttonlink" onclick="tryQuit(); return false;">[ %M_LEAVE% ]</a>
			<span id="resetStatus"></span>
		</p>


	</div>

</div>
