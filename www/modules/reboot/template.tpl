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
					"%M_YES%": function() {
						setTimeout("hard_reboot()", 100);
						$( this ).dialog( "close" );
					},
					"%M_NO%": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
	}

	function hard_reboot() {
		$("#resetStatus").load("modules/{module_name}/reboot.php");
		setTimeout('document.location.href = "/"', 1000);
	}
</script>

<!-- Dialog -->
<div id="dialog-confirm" title="%M_REBOOT%">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>%M_REALLY_REBOOT%</p>
</div>
<!-- End dialog -->


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DEVICE_CONTROL%</a></h3>
	<div>
		<p>
			<a href="" class="buttonlink" onclick="tryReboot(); return false;">[ %M_REBOOT_DEVICE% ]</a>
			<span id="resetStatus"></span>
		</p>
	</div>

</div>
