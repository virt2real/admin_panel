<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function tryQuit(){
		$(function() {
			$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:250,
				width: 400,
				modal: true,
				buttons: {
					"Да": function() {
						quit();
					},
					"Я передумал": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
	}

	function quit(){
		$("#resetStatus").load("modules/{module_name}/quit.php", function(response, status, xhr) {			location.replace("/");		});
	}
</script>

<!-- Dialog -->
<div id="dialog-confirm" title="Выйти из админки?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Ваша сессия будет стёрта, потребуется новая авторизация пользователя. Вы уверены что хотите этого?</p>
</div>
<!-- End dialog -->


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Выйти из админки</a></h3>
	<div>
		<p>
			<a href="" class="buttonlink" onclick="tryQuit(); return false;">[ выйти ]</a>
			<span id="resetStatus"></span>
		</p>

		
	</div>

</div>