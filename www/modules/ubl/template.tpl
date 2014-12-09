<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		$("#cpufreq").buttonset();
		GetInfo ();
	}

	function tryAlert(){

		if ($("#type2").attr("checked") != "checked") {
			UBL_Save();
			return;
		}

		$(function() {
			$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:250,
				width: 400,
				modal: true,
				buttons: {
					"%M_YES%": function() {
						UBL_Save();
						$( this ).dialog( "close" );
					},
					"%M_NO%": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
	}

	function GetInfo () {
		$("#cpustatus").html('<img src="imgs/loader.gif">');
		$.get("modules/{module_name}/check.php?rnd=" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				var json = "";
				var info = "";
				try {
					json = JSON.parse(response);
					info += '<p>' + '%M_FREQ%: ' + json.freq + " %M_MHZ%" + '</p>';
					info += '<p>' + '%M_BOGOMIPS%: ' + json.bogomips + '</p>';

					if (parseInt(json.freq) > 300) {
						$("#type2").attr("checked", "checked");
						$("#type2").button("refresh");
					} else {
						$("#cpualert").html('%M_ALERT%');
						$("#type1").attr("checked", "checked");
						$("#type1").button("refresh");
					}

				} catch (err) {}

				$("#cpustatus").html(info);
			}
			if (status == "error") {
				$("#cpustatus").html("%L_FAIL%");
			}
		});
	}

	function UBL_Save() {

		$("#ublsaveestatus").html('<img src="imgs/loader.gif">');

		var freq = 0;
		if ($("#type1").attr("checked") == "checked") freq = 1;
		if ($("#type2").attr("checked") == "checked") freq = 2;

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {freq: freq}, function(response, status, xhr) {
			if (status == "success") {

				var json = "";
				try {
					json = JSON.parse(response);
					if (parseInt(json.retcode) == 0) {
						$("#ublsaveestatus").html(json.output);
						$("#ublsaveestatus").append("%M_DONESUCCESS%");
					} else {
						$("#ublsaveestatus").html(json.output);
						$("#ublsaveestatus").append("%M_DONEFAIL");
					}
				} catch (err) {
					$("#ublsaveestatus").html(response);
					$("#ublsaveestatus").append("M_DONEFAIL");
				}
			}
			if (savestatus == "error") {
				$("#ublsaveestatus").html("%L_FAIL%");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_CPU_INFO%</p>
		<span id="cpustatus"></span>

		<p>&nbsp;</p>

		<p class="bluetitle">%M_ACTIONTITLE%</p>

		<p class="redtitle" id="cpualert"></p>
		<p>&nbsp;</p>
		<div id="cpufreq" style="display:inline;">
			<input type="radio" id="type1" name="radio"><label for="type1">%M_300MHZ%</label>
			<input type="radio" id="type2" name="radio"><label for="type2">%M_432MHZ%</label>
		</div>

		<p style="display:inline;"><a href="#" class="buttonlink" onclick="tryAlert(); return false;" style="padding-left:20px;">[ %M_WRITE% ]</a></p>

		<p id="ublsaveestatus"></p>

		<p class="graytext">%M_INFO%</p>

<!-- Dialog -->
<div id="dialog-confirm" title="%M_SURE%?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>%M_REALLY_LEAVE%</p>
</div>
<!-- End dialog -->


	</div>

</div>
