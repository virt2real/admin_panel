<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){		Scan();
	}

	function UpdateField(id, value, frombase, tobase){
		var valueInt = parseInt(value, frombase);
		var valueStr = valueInt.toString(tobase);

		if (valueStr == "NaN") valueStr = "";
		id.val(valueStr);	}

	function SetValue(base, reg, valueHex, valueBin){
		var baseInt = parseInt(base, 16);
		base = "0x" + baseInt.toString(16);

		var regInt = parseInt(reg, 16);
		reg = "0x" + regInt.toString(16);

		var value;
		if (valueBin) {			value = parseInt(valueBin, 2);
			valueStr = value.toString(16);
		} else {			valueStr = valueHex;		}

		valueStr = "0x" + valueStr;

		$("#updateresult").html("updating...");
		$("#updateresult").load("modules/{module_name}/set.php?base=" + encodeURIComponent(base) + "&reg=" + encodeURIComponent(reg) + "&value=" + encodeURIComponent(valueStr),
			function(response, status, xhr) {
			if (status == "success") {
				$("#updateresult").html(response);
			}
			if (status == "error") {
				$("#updateresult").html("error");
			}
		});
	}

	function GetValue(base, reg){
		var baseInt = parseInt(base, 16);
		base = "0x" + baseInt.toString(16);

		var regInt = parseInt(reg, 16);
		reg = "0x" + regInt.toString(16);

		$("#updateresult").html("reading...");
		$("#updateresult").load("modules/{module_name}/get.php?base=" + encodeURIComponent(base) + "&reg=" + encodeURIComponent(reg), function(response, status, xhr) {
			if (status == "success") {
				$("#regvalhex").val(response);
				UpdateField($("#regvalbin"), response, 16, 2);
			}
			if (status == "error") {
				$("#updateresult").html("error");
			}
		});
	}

	function Scan(){

		$("#scanresult").html("scanning...");
		$("#scanresult").load("modules/{module_name}/scan.php", function(response, status, xhr) {
			if (status == "success") {
				$("#scanresult").html(response);
			}
			if (status == "error") {
				$("#scanresult").html("error");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">I2C</a></h3>
	<div>
		<p><pre>{ctrlname}</pre></p>

		<div id="scanresult"></div>

        <br><br>
		<hr/>

		<p>Изменение регистров I2C</p>
		<form onSubmit="var base=$('#regbase').val(); var reg=$('#regnum').val(); var valueHex=$('#regvalhex').val(); var valueBin=$('#regvalbin').val(); SetValue(base, reg, valueHex, valueBin); return false;">
		<p>
			<table colspan=10 cellspacing=5 cellpadding=5>
				<tr>
					<td colspan="2">Регистр</td>
				</tr>
				<tr>
					<td align=right>база</td>
					<td><input type="text" id="regbase" value="21" style="width:100px;"></td>
				</tr>
				<tr>
					<td align=right>параметр</td>
					<td><input type="text" id="regnum" value="0a" style="width:100px;"></td>
				</tr>
				<tr>
					<td colspan="2">Значение</td>
				</tr>
				<tr>
					<td align=right>hex</td>
					<td><input type="text" id="regvalhex" onKeyup='UpdateField($("#regvalbin"), this.value, 16, 2);'  style="width:100px;"></td>
				</tr>
				<tr>
					<td align=right>bin</td>
					<td><input type="text" id="regvalbin" onKeyup='UpdateField($("#regvalhex"), this.value, 2, 16);'  style="width:100px;"></td>
				</tr>
				<tr>
					<td colspan="2">
						<p><input type="submit" value="Установить"> <input type="button" value="Прочитать" onclick="var base=$('#regbase').val(); var reg=$('#regnum').val(); GetValue(base, reg); return false;"></p>
						<div id="updateresult"></div>
					<td>
				</tr>
			</table>

		</p>
		</form>
	</div>

</div>