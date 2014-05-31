<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){

		CheckYota();

	}


	function CheckYota(){

		$.post("modules/{module_name}/check.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			if (status == "success") {

				var json;
				var result = "";

				try {
					json = JSON.parse(response);

					for (var i in json) {
						if (i == "") continue;
						result += '<span class="graytext">' + i + ': </span><span class="bluetitle">' + json[i] + '</span><br>';
					}
				} catch (err) {}

				$("#connection_status").html(result);

			}
			if (status == "error") {
				$("#connection_status").html("%M_FAIL%");
			}

			// setTimeout("CheckYota()", 1000);
		});
	}


</script>

<style>
#connection_status {
	font-family: "Lucida Console", Monaco, monospace;
	font-size:1.2em;
}
</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p>%M_TITLE%</p>

		<p>&nbsp;</p>

		<div id="connection_status" ></div>
	</div>


</div>

</div>
