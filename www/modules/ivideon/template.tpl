<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});


	function init{module_name}(){
		loadconfig();
	}

	/* global config var */
	var jsonconfig;

	function loadconfig(){
		$("#ivideon_load_status").html('<img src="/imgs/loader.gif">');
		$.get("modules/{module_name}/loadconfig.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#ivideon_load_status").html('');

				try {
					jsonconfig = JSON.parse(response);
				} catch (err) {
					NotAttached();
				}

				if (jsonconfig.account.uin) {
					Attached(jsonconfig);
				} else {
					NotAttached();
				}


			}
			if (status == "error") {
				$("#ivideon_load_status").html("%L_FAIL%");
			}
		});
	}


	function save_config(text) {

		$("#ivideon_load_status").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/saveconfig.php?rnd=" + Math.random(), {text:text}, function(response, status, xhr) {
			if (status == "success") {
				$("#ivideon_load_status").html('%M_SETTINGSSAVED%');
			}
			if (savestatus == "error") {
				$("#ivideon_load_status").html("%L_FAIL%");
			}
		});
	}


	function save_common_settings() {
		var autorun = ($("#inautorun").attr("checked") == "checked") ? 1 : 0;
		$("#ivideon_load_status").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/saveparams.php?rnd=" + Math.random(), {autorun:autorun}, function(response, status, xhr) {
			if (status == "success") {
				$("#ivideon_load_status").html('%M_SETTINGSSAVED%');
			}
			if (savestatus == "error") {
				$("#ivideon_load_status").html("%L_FAIL%");
			}
		});
	}


	function NotAttached() {
		$("#message").html('%M_NCMESSAGE%');

		$("#newattach").css("display", "block");
	}


	function Attached(json) {
		$("#message").html('%M_CONMESSAGE%');

		$("#account").html(json.account.email);
		$("#uin").html(json.account.uin);
		$("#camname").html(json.account.serverName);

		$("#attachmessage").css("display", "block");
	}


	function tryattach() {
		var acc = $("#accountname").val();
		var cameraname = $("#cameraname").val();

		if (!acc) {
			$("#errormessage").html('%M_NOACC%');
			return;
		}
		if (!cameraname) {
			$("#errormessage").html('%M_NOCAMNAME%');
			return;
		}

		$("#errormessage").html("");


		$("#ivideon_load_status").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/attach.php?rnd=" + Math.random(), {acc:acc, cameraname:cameraname}, function(response, status, xhr) {
			if (status == "success") {

				$("#ivideon_load_status").html("");

				var json;
				try { 
					json = JSON.parse(response);
				} catch (err) {
					$("#errormessage").html('%M_WRONGANSW%');
					return;
				}

				if (json.code == 1) {
					$("#errormessage").html('%M_COMMONERR%');
					return;
				}
				if (json.code == 2) {
					$("#errormessage").html('%M_CONNERROR%');
					return;
				}
				if (json.code == 3) {
					$("#errormessage").html('%M_EXIST%');
					return;
				}
				if (json.code == 4) {
					$("#errormessage").html('%M_USERUNKN%');
					return;
				}
				if (json.code == 5) {
					$("#errormessage").html('%M_ERR%');
					return;
				}

			
				var json1;
				try {
					json1 = JSON.parse(json.content);
				} catch (err) {
					$("#errormessage").html('%M_WRONGANSW%');
					return;
				}
			
				$("#newattach").css("display", "none");
				$("#attachmessage").css("display", "block");

				$("#account").html(json1.account.email);
				$("#camname").html(json1.account.serverName);
				$("#uin").html(json1.account.uin);

				$("#message").html('%M_CONMESSAGE%');

				/* insert new config into previously loaded global config */
				jsonconfig.account = json1.account;
				jsonconfig.cameras[0].name = json1.account.serverName;

				save_config(JSON.stringify(jsonconfig));

			}
			if (savestatus == "error") {
				$("#ivideon_load_status").html("%L_FAIL%");
			}
		});

	}

	function trydetach() {
		jsonconfig.account.uin = 0;
		jsonconfig.account.email = "";
		jsonconfig.account.serverName = "";
		jsonconfig.account.password = "";

		save_config(JSON.stringify(jsonconfig));
	
		$("#message").html('%M_DISCONNECTED%');
		$("#attachmessage").css("display","none");
		$("#newattach").css("display","block");
	}

	function IvideonStart(action) {
		$("#ivideon_load_status").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {action:action}, function(response, status, xhr) {
			if (status == "success") {
				$("#ivideon_load_status").html("");
			}
			if (savestatus == "error") {
				$("#ivideon_load_status").html("%L_FAIL%");
			}
		});
	}

</script>

<style>
#ivideontitle {
	width:100%;
	float:right;
	text-align:right;
}

#attachmessage {
	display:none;
}

#newattach {
	display:none;
}

#errormessage {
	color:#ff0000;
}

#ivideon_load_status {
	color: #7c7c7c;
}

</style>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>

		<table width=100%>
			<tr valign=top>
				<td width=400>

					<p id="message"></p>
					<p>&nbsp;</p>

					<div id="attachmessage">

						<div style="text-align:center;">
							<span style="margin-right:50px;">
								<a href="#" onclick="IvideonStart(1); return false;" title="%M_STARTMESSAGE%"><img src="modules/{module_name}/imgs/play.png" width=40 alt="%M_STARTMESSAGE%"></a>
							</span>
							<span>
								<a href="#" onclick="IvideonStart(0); return false;" title="%M_STOPMESSAGE%"><img src="modules/{module_name}/imgs/stop.png" width=40 alt="%M_STOPMESSAGE%"></a>
							</span>
						</div>

						<p>&nbsp;</p>

						<p class="graytext">%M_ACCOUNT% <span class="bluetitle" id="account" style="margin-left:10px;width:300px;"></span> </p>
						<p class="graytext">%M_CAMNAME% <span class="bluetitle" id="camname" style="margin-left:10px;width:300px;"></span></p>						
						<p class="graytext">%M_UIN% <span class="bluetitle" id="uin" style="margin-left:10px;width:300px;"></span></p>						
						<p>&nbsp;</p>
						<p><a href="#" class="buttonlink" onclick='trydetach(); return false;'>[ %M_DEATTACH% ]</a></p>

						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p><input type="checkbox" id="inautorun" {inautorun} onclick="save_common_settings();"><label for="inautorun">%M_AUTORUN%</label></p>
						<p>&nbsp;</p>

					</div>

					<div id="newattach">
						<p class="bluetitle">%M_CAMNAME%</p>
						<div>
							<input type="text" id="cameraname" style="width:300px;" value="My IP camera Virt2real" placeholder="My IP camera Virt2real">
						</div>
						<p class="bluetitle">%M_ACCOUNT%</p>
						<div>
							<input type="text" id="accountname" style="width:300px;" placeholder="someone@example.com">
						</div>
						<p class="graytext">%M_ACCNONEINFO%</p>
						<p>&nbsp;</p>
						<p><a href="" class="buttonlink" onclick='tryattach(); return false;'>[ %M_ATTACH% ]</a></p>
						<p id="errormessage"></p>
					</div>
					
					<p id="ivideon_load_status"></p>

				</td>
				<td>
					&nbsp;
				</td>
				<td width=300 class="graytext">
					<p style="text-align:right;"><img src="modules/{module_name}/imgs/ivideon.png" width=200></p>
					<p>%M_INTRO%</p>
				</td>
			</tr>
		</table>
		

	</div>

</div>
