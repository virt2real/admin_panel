<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>

	$("#interfacelist").accordion({ fillSpace: false, autoHeight: false, navigation: false});

	function changeType(name, value){
		if (value == "static")
			$("." + name).removeClass("hidden");
		else
		if (value == "dhcp")
			$("." + name).addClass("hidden");
	}

	function ToggleExtended(name) {
		var state = $("#" + name + "_extended").css("display");
		if (state == "none")
			state = "block";
		else
			state = "none";
		$("#" + name + "_extended").css("display", state);
	}

	function SaveInterfaces(){

		var ifacelist = "";
		var nslist = "";

		$(".interfaceblock").each(function(i, elem) {
			var ifacename = $(elem).attr("name");

			var auto = $("#" + ifacename + "_auto").attr("checked");
			var static = $("#" + ifacename + "_static").val();
			var address = $("#" + ifacename + "_address").val();
			var netmask = $("#" + ifacename + "_netmask").val();
			var gateway = $("#" + ifacename + "_gateway").val();
			var hwaddress = $("#" + ifacename + "_hwaddress").val();
			var preup = $("#" + ifacename + "_preup").val();
			var up = $("#" + ifacename + "_up").val();
			var postup = $("#" + ifacename + "_postup").val();
			var predown = $("#" + ifacename + "_predown").val();
			var down = $("#" + ifacename + "_down").val();
			var postdown = $("#" + ifacename + "_postdown").val();

			var tmp = "";
			if (auto == "checked") tmp += "auto " + ifacename + "\n";
			if (static) tmp += "iface " + ifacename + " inet " + static + "\n";
			if (address) tmp += "  address " + address + "\n";
			if (netmask) tmp += "  netmask " + netmask + "\n";
			if (gateway) tmp += "  gateway " + gateway + "\n";
			if (hwaddress) tmp += "  hwaddress ether " + hwaddress + "\n";
			if (preup) tmp += "  pre-up " + preup + "\n";
			if (up) tmp += "  up " + up + "\n";
			if (postup) tmp += "  post-up " + postup + "\n";
			if (predown) tmp += "  pre-down " + predown + "\n";
			if (down) tmp += "  down " + down + "\n";
			if (postdown) tmp += "  post-down " + postdown + "\n";
			tmp += "\n\n";

			ifacelist += tmp;
		});


		$(".nameservers").each(function(i, elem) {
			var ns = $(elem).val();
			if (ns) nslist += "nameserver " + ns + "\n";
		});

		$("#saveinterfaces").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/saveinterfaces.php?rnd=" + Math.random(), {ifacelist: ifacelist, nslist: nslist}, function(response, status, xhr) {
			if (status == "success") {
				$("#saveinterfaces").html(response);
			}
			if (savestatus == "error") {
				$("#saveinterfaces").html("%L_FAIL%");
			}
		});

	}


</script>

<style>
.hidden {
  display: none;
}
</style>

<div id="accordion" style="margin:0; padding:0;">


	<h3><a href="#">%M_INTERFACE_DNS_CFG%</a></h3>
	<div>

		<table width="100%">
			<tr valign=top>
				<td>
					<p><a href="#" class="buttonlink" onclick="SaveInterfaces(text); return false;">[ %L_SAVE% ]</a></p>

					<div class="bluetitle">%M_INTERFACE_LIST%</div>

					<div id="interfacelist" style="width: 95%;">
						{ifacelist}
   					</div>

					<p><a href="#" class="buttonlink" onclick="SaveInterfaces(text); return false;">[ %L_SAVE% ]</a></p>
					<span id="saveinterfaces"></span>

					<p>&nbsp;</p>
					<div class="bluetitle">%M_DNS_SERVER_LIST%</div>
					<p>{nameserverlist}</p>

				</td>
				<td width="250">
					<p><div class="bluetitle">%M_IP4_ADDRESS%</div> %M_IP4_ADDRESS_DESC%</p>
					<p><div class="bluetitle">%M_NETMASK%</div> %M_NETMASK_DESC%</p>
					<p><div class="bluetitle">%M_GATEWAY%</div> %M_GATEWAY_DESC%</p>
					<p><div class="bluetitle">%M_PRE_UP%</div> %M_PRE_UP_DESC%</p>
					<p><div class="bluetitle">%M_UP%</div> %M_UP_DESC%</p>
					<p><div class="bluetitle">%M_POST_UP%</div> %M_POST_UP_DESC%</p>
					<p><div class="bluetitle">%M_PRE_DOWN%</div> %M_PRE_DOWN_DESC%</p>
					<p><div class="bluetitle">%M_DOWN%</div> %M_DOWN_DESC%</p>
					<p><div class="bluetitle">%M_POST_DOWN%</div> %M_POST_DOWN_DESC%</p>
				</td>
			</tr>
		</table>


	</div>


	<h3><a href="#">%M_ACTIVE_INTERFACES%</a></h3>
	<div>
		<p class="bluetitle">%M_CURRENTLY_ACTIVE%</p>
		<div id="currentlanconnection">
		{currentstate}
		</div>
	</div>

</div>
