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
				$("#status").html("saved");
			}
			if (status == "error") {
				$("#status").html("error");
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

	<h3><a href="#">OV2643</a></h3>
	<div>
		<p class="bluetitle">Настройки регистров камеры OV2643</p>
		<div>

		<p>Контраст <span id="value_0xbc"></span></p>
		<div class="slider" reg="0xbc" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Яркость <span id="value_0xbd"></span></p>
		<div class="slider" reg="0xbd" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Насыщенность SAT_U <span id="value_0xba"></span></p>
		<div class="slider" reg="0xba" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Насыщенность SAT_V <span id="value_0xb9"></span></p>
		<div class="slider" reg="0xb9" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>HUE_COS <span id="value_0xb7"></span></p>
		<div class="slider" reg="0xb7" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>HUE_SIN <span id="value_0xb8"></span></p>
		<div class="slider" reg="0xb8" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>0x39 <span id="value_0x39"></span></p>
		<div class="slider" reg="0x39" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>0x3d <span id="value_0x3d"></span></p>
		<div class="slider" reg="0x3d" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Lens shading <span id="value_0x40"></span></p>
		<div class="slider" reg="0x40" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Lens shading 0x4c <span id="value_0x4c"></span></p>
		<div class="slider" reg="0x4c" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Lens shading 0x4d <span id="value_0x4d"></span></p>
		<div class="slider" reg="0x4d" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Lens shading 0x4e <span id="value_0x4e"></span></p>
		<div class="slider" reg="0x4e" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Lens shading 0x4f <span id="value_0x4f"></span></p>
		<div class="slider" reg="0x4f" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Lens shading 0x50 <span id="value_0x50"></span></p>
		<div class="slider" reg="0x50" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Lens shading 0x57 <span id="value_0x57"></span></p>
		<div class="slider" reg="0x57" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Резкость? Пиксели? 0xa6 <span id="value_0xa6"></span></p>
		<div class="slider" reg="0xa6" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Резкость? Пиксели? 0xa7 <span id="value_0xa7"></span></p>
		<div class="slider" reg="0xa7" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Резкость? Пиксели? 0xa8 <span id="value_0xa8"></span></p>
		<div class="slider" reg="0xa8" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Ещё Резкость 0xa1 <span id="value_0xa1"></span></p>
		<div class="slider" reg="0xa1" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<p>Сглаживание 0xa9 <span id="value_0xa9"></span></p>
		<div class="slider" reg="0xa9" base="0x30" style="width:300px; margin-bottom: 10px;"></div>

		<div id="status"></div>

		</div>
	</div>
</div>

</div>