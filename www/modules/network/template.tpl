<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>

	$("#interfacelist").accordion({ fillSpace: false, autoHeight: false, navigation: false});

	function changeType(name, value){		if (value == "static")
			$("." + name).removeClass("hidden");
		else
		if (value == "dhcp")
			$("." + name).addClass("hidden");
	}

	function ToggleExtended(name) {		var state = $("#" + name + "_extended").css("display");
		if (state == "none")
			state = "block";
		else
			state = "none";
		$("#" + name + "_extended").css("display", state);	}

	function SaveInterfaces(){
		var ifacelist = "";
		var nslist = "";
		$(".interfaceblock").each(function(i, elem) {			var ifacename = $(elem).attr("name");

			var static = $("#" + ifacename + "_static").val();
			var address = $("#" + ifacename + "_address").val();
			var netmask = $("#" + ifacename + "_netmask").val();
			var gateway = $("#" + ifacename + "_gateway").val();
			var preup = $("#" + ifacename + "_preup").val();
			var up = $("#" + ifacename + "_up").val();
			var postup = $("#" + ifacename + "_postup").val();
			var predown = $("#" + ifacename + "_predown").val();
			var down = $("#" + ifacename + "_down").val();
			var postdown = $("#" + ifacename + "_postdown").val();

			var tmp = "auto " + ifacename + "\n";
			if (static) tmp += "iface " + ifacename + " inet " + static + "\n";
			if (address) tmp += "  address " + address + "\n";
			if (netmask) tmp += "  netmask " + netmask + "\n";
			if (gateway) tmp += "  gateway " + gateway + "\n";
			if (preup) tmp += "  pre-up " + preup + "\n";
			if (up) tmp += "  up " + up + "\n";
			if (postup) tmp += "  post-up " + postup + "\n";
			if (predown) tmp += "  pre-down " + predown + "\n";
			if (down) tmp += "  down " + down + "\n";
			if (postdown) tmp += "  post-down " + postdown + "\n";
			tmp += "\n\n";

			ifacelist += tmp;		});


		$(".nameservers").each(function(i, elem) {
			var ns = $(elem).val();
			if (ns) nslist += "nameserver " + ns + "\n";
		});
		$("#saveinterfaces").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/saveinterfaces.php?rnd=" + Math.random(), {ifacelist: ifacelist, nslist: nslist}, function(response, status, xhr) {
			if (status == "success") {
				$("#saveinterfaces").html(response);
			}
			if (savestatus == "error") {
				$("#saveinterfaces").html(":-(");
			}
		});

	}


</script>

<style>
.hidden {  display: none;}
</style>

<div id="accordion" style="margin:0; padding:0;">


	<h3><a href="#">Настройка интерфейсов и DNS</a></h3>
	<div>

		<table width="100%">
			<tr valign=top>
				<td>
					<p><a href="#" class="buttonlink" onclick="SaveInterfaces(text); return false;">[ Сохранить ]</a></p>

					<div class="bluetitle">Список интерфейсов</div>

					<div id="interfacelist" style="width: 95%;">
						{ifacelist}
   					</div>

					<p><a href="#" class="buttonlink" onclick="SaveInterfaces(text); return false;">[ Сохранить ]</a></p>
					<span id="saveinterfaces"></span>

					<p>&nbsp;</p>
					<div class="bluetitle">Список серверов DNS</div>
					<p>{nameserverlist}</p>

				</td>
				<td width="250">
					<p><div class="bluetitle">IP4 адрес</div> адрес, присваиваемый интерфейсу</p>
					<p><div class="bluetitle">маска</div> маска подсети</p>
					<p><div class="bluetitle">шлюз</div> используемый по умолчанию адрес шлюза подсети</p>
					<p><div class="bluetitle">pre-up</div> скрипт, выполняемый перед поднятием интерфейса</p>
					<p><div class="bluetitle">up</div> скрипт, выполняемый при поднятии интерфейса</p>
					<p><div class="bluetitle">post-up</div> скрипт, выполняемый после поднятия интерфейса</p>
					<p><div class="bluetitle">pre-down</div> скрипт, выполняемый перед отключением интерфейса</p>
					<p><div class="bluetitle">down</div> скрипт, выполняемый во время отключения интерфейса</p>
					<p><div class="bluetitle">post-down</div> скрипт, выполняемый после отключения интерфейса</p>
				</td>
			</tr>
		</table>


	</div>


	<h3><a href="#">Активные интерфейсы</a></h3>
	<div>
		<p class="bluetitle">Активные сетевые интерфейсы</p>
		<div id="currentlanconnection">
		{currentstate}
		</div>
	</div>

</div>