<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		$("#updatestatus").html('<p class="bluetitle">%M_CHECKING_UPDATES%</p><p><img src="/imgs/loader.gif"></p>');
		$.get("modules/{module_name}/check.php?rnd=" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				var json = JSON.parse(response);
				var message = "";
				if (!json.state)  {
					$("#updatestatus").html("%M_ERR_NO_UPDATES%");
					return;
				}
				if (json.last > json.current) {
					message = "<p>%M_NEW_VERSION% " + json.last + " (%M_CURRENT_VERSION% - " + json.current + " )</p>";
					$("#updatebutton").css("display", "block");
				} else  {
					message = "<p>%M_YOUR_CURRENT_VER% - " + json.current + ", %M_SERVER_VERSION% - " + json.last + "</p><p>%M_UP_TO_DATE%</p>";
					$("#updatebutton").css("display", "block");
				}

				$("#updatestatus").html(message);
			}
			if (status == "error") {
				$("#updatestatus").html("%L_FAIL%");
			}
		});
	}

	function RunUpdate(type){

		$("#updatestatus").html('<p class="bluetitle">%M_UPDATING%</p><p><img src="/imgs/loader.gif"></p>');
		$("#updatebutton").css("display", "none");
		$.get("modules/{module_name}/update.php?rnd=" + Math.random() + "&type=" + type, function(response, status, xhr) {
			if (status == "success") {
				if (response == 42)
					response = "%M_UPDATE_SUCCESSFUL%";
				else
					response = "%M_UPDATE_FAILED%";
				$("#updatestatus").html(response);
			}
			if (status == "error") {
				$("#updatestatus").html("%L_FAIL%");
			}
		});
	}

	function HardUpdate(){
		$(function() {
			$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:200,
				width: 400,
				modal: true,
				buttons: {
					"%M_YES%": function() {
						RunUpdate(1);
						$( this ).dialog( "close" );
					},
					"%M_NO%": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
	}



</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_UPDATE_ADMIN_MODULE%</a></h3>
	<div>
		<div id="updatestatus"></div>
		<div id="updatebutton" style="display: none;">
			<p></p>
			<p></p>
			<p class="bluetitle">%M_SOFT_UPDATE%</p>
			<p class="bluetitle">%M_HARD_UPDATE%</p>
			<p></p>
			<p><a href="#" class="buttonlink" onclick="RunUpdate(0); return false;">[ %M_SOFT_UPDATE_BUTTON% ]</a>   <a href="#" class="buttonlink" onclick="HardUpdate(); return false;">[ %M_HARD_UPDATE_BUTTON% ]</a></p>
		</div>
	</div>

</div>

<!-- Dialog -->
<div id="dialog-confirm" title="%M_REALLY_UPDATE%">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>%M_REALLY_REALLY%</p>
</div>
<!-- End dialog -->
