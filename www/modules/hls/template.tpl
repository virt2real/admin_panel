<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">HLS</a></h3>
	<div>

		<video width="640" height="480" controls="1" autoplay="1" src="/hls/cam1/index.m3u8"></video>

	</div>
</div>

</div>