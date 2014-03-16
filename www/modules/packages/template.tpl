<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		LoadPackageList();
	}


	function LoadPackageList() {
		$.get("modules/{module_name}/check.php?rnd=" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				var json;
				var packages = "";
				var odd;

				try {
					json = JSON.parse(response);

					$("#packagelist").append('<table width="100%">');
					$("#packagelist").append('<td>%M_NAME%</td><td>%M_VERSION%</td><td>%M_DESCRIPTION%</td><td>&nbsp;</td><td>%M_INSTALLED_VERSION%</td>');

					for (var i in json) {

						if (!json[i].name) continue;
						var name = json[i].name;
						var version = json[i].ver ? json[i].ver : "";
						var descr = json[i].desc ? json[i].desc : "";

						if (i % 2 == 0) odd = "odd"; else odd = "";

						//$("#packagelist").append('<p class="packages ' + odd + '"><span><a href="#" class="' + pkg_installed + '" onclick="ConfirmInstall(\'' + name +  '\'); return false;">' + name +  ' ' + version +  " " + '</a></span><span id="confirm_' + name + '" style="margin-left: 40px; display: none;"><a href="#" style="color:#0380ea" onclick="InstallPackage(\'' + name +  '\'); return false;">[ %L_SET% ]</a></span><span style="float:right; margin-right: 30px;">' + descr + '</span></p>');

						//$("#packagelist").append('<p class="packages"><span><a href="#">' + name +  ' ' + version +  " " + update_flag + " " + '</a></span><span><a href="#">[ %L_SET% ]</a></span><span>' + descr + '</span></p>');

						$("#packagelist").append('<tr class="packages ' + odd + '">');
						//$("#packagelist").append('<td>' + json[i].name + " ver:" + '</td><td>' + json[i].ver + " desc:" + json[i].desc + '</td><td>' + " dec_ver:" + json[i].dec_ver + " flag:" + json[i].flag + " inst_ver:" + json[i].inst_ver + " inst_dec_ver:" + json[i].inst_dec_ver + '</td>');
						$("#packagelist").append('<td>' + json[i].name + '</td><td>' + json[i].ver + '</td><td>' + json[i].desc + '</td><td>' + json[i].flag + '</td><td>' + json[i].inst_ver + '</td>');
						$("#packagelist").append('</tr>');
					}

					$("#packagelist").append('</table>');

				} catch (err) {}
			}
			if (status == "error") {
			}
		});
	}

	function ConfirmInstall(name) {
		if ($("#confirm_" + name).css("display") == "none")
			$("#confirm_" + name).css("display","inline");
		else
			$("#confirm_" + name).css("display","none");
	}

	function InstallPackage(name) {
		alert(name);
	}

</script>

<style>

.odd {
  background-color: #1f1f1f;
}

.packages {
  width:100%;
  padding:6px;
  margin:0px;
}

.packages a {
  color: #ffffff;
  text-decoration: none;
}

.packages td:hover {
  padding:6px;
  border:1px solid #0380ea;
}

.pkg_installed {
  color: #0380ea;
}

</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_INSTALL_PACKAGES%</a></h3>
	<div>

		<p class="bluetitle">%M_AVAILABLE_PACKAGES%</p>

		<div id="packagelist"></div>

	</div>

</div>
