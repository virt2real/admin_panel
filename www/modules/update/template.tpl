<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		$("#updatestatus").html('<p class="bluetitle">проверка наличия обновлений...</p><p><img src="/imgs/loader.gif"></p>');
		$.get("modules/{module_name}/check.php?rnd=" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				var json = JSON.parse(response);
				var message = "";
				if (!json.state)  {
					$("#updatestatus").html("не могу проверить наличие обновлений");
					return;
				}
				if (json.last > json.current) {
					message = "Имеется более свежая версия " + json.last;
					$("#updatebutton").css("display", "block");
				} else  {
					message = "обновление не требуется, однако, если очень хочется - можно обновить принудительно";
					$("#updatebutton").css("display", "block");
				}

				$("#updatestatus").html(message);
			}
			if (status == "error") {
				$("#updatestatus").html(":-(");
			}
		});
	}

	function RunUpdate(type){

		$("#updatestatus").html('<p class="bluetitle">обновление...</p><p><img src="/imgs/loader.gif"></p>');
		$("#updatebutton").css("display", "none");
		$.get("modules/{module_name}/update.php?rnd=" + Math.random() + "&type=" + type, function(response, status, xhr) {
			if (status == "success") {
				if (response == 42) 
					response = "успешно обновлено, перезагрузите страницу";
				else 
					response = "что-то пошло не так с обновлением";
				$("#updatestatus").html(response);
			}
			if (status == "error") {
				$("#updatestatus").html(":-(");
			}
		});
	}

	function HardUpdate(){
		$(function() {
			$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:200,
				width: 400,
				modal: true,
				buttons: {
					"Да, обновить": function() {
						RunUpdate(1);
						$( this ).dialog( "close" );
					},
					"Я передумал": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
	}



</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Обновление модулей адмики</a></h3>
	<div>
		<div id="updatestatus"></div>
		<div id="updatebutton" style="display: none;">
			<p></p>
			<p></p>
			<p class="bluetitle">Мягкое обновление - будут перезаписаны только более новые файлы</p>
			<p class="bluetitle">Жёсткое обновление - полное удаление имеющегося содержимого {document_root} и запись нового</p>
			<p></p>
			<p><a href="#" class="buttonlink" onclick="RunUpdate(0); return false;">[ мягкое обновление ]</a>   <a href="#" class="buttonlink" onclick="HardUpdate(); return false;">[ жёсткое обновление ]</a></p>
		</div>
	</div>

</div>

<!-- Dialog -->
<div id="dialog-confirm" title="Действительно обновить?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Внимание, все содержимое каталога {document_root} будет стёрто. Вы уверены что хотите этого?</p>
</div>
<!-- End dialog -->
