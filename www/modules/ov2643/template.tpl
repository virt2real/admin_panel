<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script type="text/javascript">
	function SetReg(reg, base, value){
		$("#status").html("");
		$("#status").load("modules/{module_name}/set.php?base=" + base + "&reg=" + reg + "&value=" + value, function(response, status, xhr) {
			if (status == "success") {
				$("#status").html("%M_SUCCESSFULLY_SAVED%");
			}
			if (status == "error") {
				$("#status").html("%L_FAIL%");
			}
		});
	}


    $(function() {
		 $( ".slider" ).slider({
			animate: true,
			range: "min",
			value: 1,
			min: 0,
			max: 255,
			step: 1,

			slide: function( event, ui ) {
				var reg = $(this).attr("reg");
				$("#value_" + reg).html( ui.value );
			},

			stop: function(event, ui) {
				var reg = $(this).attr("reg");
				var base = $(this).attr("base");
				SetReg(reg, base, ui.value);
			}
		});
    });

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_CAM_REGISTRY_CONFIG%</p>
		<div>

		<p>%M_CONTRAST% <span id="value_0xbc"></span></p>
		<div class="slider" reg="0xbc" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_BRIGHTNESS% <span id="value_0xbd"></span></p>
		<div class="slider" reg="0xbd" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_SATURATION_SAT_U% <span id="value_0xba"></span></p>
		<div class="slider" reg="0xba" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_SATURATION_SAT_V% <span id="value_0xb9"></span></p>
		<div class="slider" reg="0xb9" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_HUE_COS% <span id="value_0xb7"></span></p>
		<div class="slider" reg="0xb7" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_HUE_SIN% <span id="value_0xb8"></span></p>
		<div class="slider" reg="0xb8" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_0X39% <span id="value_0x39"></span></p>
		<div class="slider" reg="0x39" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_0X3d% <span id="value_0x3d"></span></p>
		<div class="slider" reg="0x3d" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_LENS_SHADING% <span id="value_0x40"></span></p>
		<div class="slider" reg="0x40" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_LENS_SHADING_0X4C% <span id="value_0x4c"></span></p>
		<div class="slider" reg="0x4c" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_LENS_SHADING_0X4D% <span id="value_0x4d"></span></p>
		<div class="slider" reg="0x4d" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_LENS_SHADING_0X4E% <span id="value_0x4e"></span></p>
		<div class="slider" reg="0x4e" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_LENS_SHADING_0X4F% <span id="value_0x4f"></span></p>
		<div class="slider" reg="0x4f" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_LENS_SHADING_0X50% <span id="value_0x50"></span></p>
		<div class="slider" reg="0x50" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_LENS_SHADING_0X57% <span id="value_0x57"></span></p>
		<div class="slider" reg="0x57" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_SHARP_PIXEL_0XA6% <span id="value_0xa6"></span></p>
		<div class="slider" reg="0xa6" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_SHARP_PIXEL_0XA7% <span id="value_0xa7"></span></p>
		<div class="slider" reg="0xa7" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_SHARP_PIXEL_0XA8% <span id="value_0xa8"></span></p>
		<div class="slider" reg="0xa8" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_MORE_SHARP_0XA1% <span id="value_0xa1"></span></p>
		<div class="slider" reg="0xa1" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>%M_SMOOTHING_0XA9% <span id="value_0xa9"></span></p>
		<div class="slider" reg="0xa9" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<div id="status"></div>

		</div>
	</div>
</div>

</div>
