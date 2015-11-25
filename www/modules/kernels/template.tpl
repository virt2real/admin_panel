<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});


	function init{module_name}(){
		load_videoparams();
	}

	function SaveSettings(text){
		$("#kernels_status").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#kernels_status").html(response);
				load_videoparams();
			}
			if (savestatus == "error") {
				$("#kernels_status").html("%L_FAIL%");
			}
		});
	}

	function load_videoparams(){
		$("#videoparams").html('<img src="imgs/loader.gif">');
		
		$.get("modules/{module_name}/get.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				var json = JSON.parse(response);
				var res = "";
				if (json.width) res += '<p> <span class="graytext">Ширина</span> ' + json.width + ' px</p>' + "\n";
				if (json.height) res += '<p> <span class="graytext">Высота</span> ' + json.height + ' px</p>' + "\n";
				if (json.fps) res += '<p> <span class="graytext">FPS</span> ' + json.fps + '</p>' + "\n";
				if (json.pitch) res += '<p> <span class="graytext">pitch</span> ' + json.pitch + ' px</p>' + "\n";
				if (json.buf) res += '<p> <span class="graytext">cont_bufsize</span> ' + json.buf + ' bytes</p>' + "\n";
				if (json.mem) res += '<p> <span class="graytext">mem</span> ' + json.mem + ' M</p>' + "\n";
				$("#videoparams").html(res);
			}
			if (status == "error") {
				$("#videoparams").html("");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_LIST%</p>

		{kernelslist}

		<p></p>
		<p><a class="buttonlink" href="#" onclick='var kernel = $("input[name=kernel]:radio:checked").attr("id"); SaveSettings(kernel); return false;'>[ %L_SAVE% ]</a></p>

		<div id="kernels_status" class="bluetitle"></div>

		<p>&nbsp;</p>

		<p class="bluetitle">%M_VIDEOPARAMS%</p>

		<div id="videoparams"></div>

	</div>

</div>
