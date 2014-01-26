<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){

		load_stream_list();

	}


	function load_stream_list() {
		$.get("modules/{module_name}/get.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			var active = "";
			var inactive = "";
			if (status == "success") {

				try {
					var json = JSON.parse(response);
					for (var i in json) {
						if (json[i].active == 1)
							active += '<a href="#" onclick=\'$("#hlsplayer").attr("src", "/hls/' + json[i].name + '/index.m3u8"); return false;\'>' + json[i].name + '</a> ';
						else
							inactive += json[i].name + ' ';
					}
				} catch (err) {}

				$("#activestreamlist").html(active);
				$("#streamlist").html(inactive);
			}
			if (savestatus == "error") {
				$("#activestreamlist").html(":-(");
				$("#streamlist").html(":-(");
			}
		});
	}


</script>

<style>

#streamlist, #activestreamlist {
  font-family: "Lucida Console", Monaco, monospace; 
  font-size:1.2em;
  color: #7c7c7c;
}

</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">HLS</a></h3>
	<div>
		<p class="bluetitle">Для просмотра HLS необходимо запустить <a href="?rtmp">трансляцию RTMP</a> на localhost</p>
		<p></p>
		<p class="bluetitle">Доступные потоки: <span id="activestreamlist"></span></p>
		<p class="bluetitle">Неполные потоки: <span id="streamlist"></span></p>
		<p></p>

		<video id="hlsplayer" width="640" height="480" controls="1" autoplay="1" src=""></video>

	</div>
</div>

</div>