<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		Scan();
	}

	function UpdateField(id, value, frombase, tobase){

		var valueInt = parseInt(value, frombase);
		var valueStr = valueInt.toString(tobase);

		if (valueStr == "NaN") valueStr = "";

		id.val(valueStr);
	}

	function SetValue(base, reg, valueHex, valueBin){

		var baseInt = parseInt(base, 16);
		base = "0x" + baseInt.toString(16);

		var regInt = parseInt(reg, 16);
		reg = "0x" + regInt.toString(16);

		var value;
		if (valueBin) {
			value = parseInt(valueBin, 2);
			valueStr = value.toString(16);
		} else {
			valueStr = valueHex;
		}

		valueStr = "0x" + valueStr;

		$("#updateresult").html('<img src="imgs/loader.gif">');
		$("#updateresult").load("modules/{module_name}/set.php?base=" + encodeURIComponent(base) + "&reg=" + encodeURIComponent(reg) + "&value=" + encodeURIComponent(valueStr),
			function(response, status, xhr) {
			if (status == "success") {
				$("#updateresult").html(response);
			}
			if (status == "error") {
				$("#updateresult").html("%L_FAIL%");
			}
		});
	}

	function GetValue(base, reg){

		var baseInt = parseInt(base, 16);
		base = "0x" + baseInt.toString(16);

		var regInt = parseInt(reg, 16);
		reg = "0x" + regInt.toString(16);


		$("#updateresult").html('<img src="imgs/loader.gif">');
		$("#updateresult").load("modules/{module_name}/get.php?base=" + encodeURIComponent(base) + "&reg=" + encodeURIComponent(reg), function(response, status, xhr) {
			if (status == "success") {
				$("#regvalhex").val(response);
				UpdateField($("#regvalbin"), response, 16, 2);
			}
			if (status == "error") {
				$("#updateresult").html("%L_FAIL%");
			}
		});

	}

	function Scan(){

		$("#scanresult").html('<img src="imgs/loader.gif">');
		$("#scanresult").load("modules/{module_name}/scan.php", function(response, status, xhr) {
			if (status == "success") {
				$("#scanresult").html(response);
			}
			if (status == "error") {
				$("#scanresult").html("%L_FAIL%");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p><pre>{ctrlname}</pre></p>

		<div id="scanresult"></div>

        	<p style="height: 20px;"></p>


		<p>%M_REG_CHANGES%</p>
		<form onSubmit="var base=$('#regbase').val(); var reg=$('#regnum').val(); var valueHex=$('#regvalhex').val(); var valueBin=$('#regvalbin').val(); SetValue(base, reg, valueHex, valueBin); return false;">
		<p>


		<p class="bluetitle">%M_REG%</p>
		<div style="display:inline-block; padding-left:40px; min-width:40px;">%M_BASE%</div>
		<div style="display:inline;">
			<input type="text" id="regbase" value="30" style="width:40px;">
		</div>
		<div style="display:inline-block; padding-left:20px; min-width:40px;">%M_PARAM%</div>
		<div style="display:inline; padding-left: 10px;">
			<input type="text" id="regnum" value="0a" style="width:40px;">
		</div>
		<p class="bluetitle">%M_VALUE%</p>
		<div style="display:inline-block; padding-left:40px; min-width:40px;">%M_HEX%</div>
		<div style="display:inline;">
			<input type="text" id="regvalhex" onKeyup='UpdateField($("#regvalbin"), this.value, 16, 2);' style="width:40px;">
		</div>
		<div style="display:inline-block; padding-left:20px; min-width:40px;">%M_BIN%</div>
		<div style="display:inline;">
			<input type="text" id="regvalbin" onKeyup='UpdateField($("#regvalhex"), this.value, 2, 16);' style="width:70px;">
		</div>

		<p>
			<a href="#" class="buttonlink" onclick="var base=$('#regbase').val(); var reg=$('#regnum').val(); var valueHex=$('#regvalhex').val(); var valueBin=$('#regvalbin').val(); SetValue(base, reg, valueHex, valueBin); return false;">[ %L_SET% ]</a>
			<a href="#" class="buttonlink" onclick="var base=$('#regbase').val(); var reg=$('#regnum').val(); GetValue(base, reg); return false;">[ %M_READ% ]</a>
			<p><div id="updateresult"></div></p>
		</p>
		</form>

	</div>

</div>
