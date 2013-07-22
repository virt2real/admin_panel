<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function tryReboot(){
		$(function() {
			$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:200,
				width: 400,
				modal: true,
				buttons: {
					"Да, ребут": function() {
						reboot();
						$( this ).dialog( "close" );
					},
					"Я передумал": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
	}

	function reboot(){
		$("#resetStatus").load("modules/{module_name}/reboot.php", function(response, status, xhr) {});
	}
</script>

<!-- Dialog -->
<div id="dialog-confirm" title="Перезагрузить?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Устройство будет перезагружено. Вы уверены что хотите этого?</p>
</div>
<!-- End dialog -->


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Управление девайсом</a></h3>
	<div>
		<p><input type="button" onclick="tryReboot(); return false;" value="Перезагрузить устройство">  <span id="resetStatus"></span></p>
	</div>

</div>