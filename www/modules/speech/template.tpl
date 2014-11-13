<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		$("#speech_lang").buttonset();
		$("#speech_engine").buttonset();
	}


	function TextToSpeech(text){

		if (!text) {
			$("#speech_status").html('%M_ERR_NO_TEXT%');
			return false;
		}

		if ($("#lang_0").attr("checked") == "checked") lang = "ru";
		if ($("#lang_1").attr("checked") == "checked") lang = "en";
		if ($("#lang_2").attr("checked") == "checked") lang = "de";

		if ($("#engine_0").attr("checked") == "checked") engine = 0;
		if ($("#engine_1").attr("checked") == "checked") engine = 1;

		$("#speech_status").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/speak.php?rnd=" + Math.random(), {text: text, lang: lang, engine: engine}, function(response, status, xhr) {
			if (status == "success") {
				$("#speech_status").html(response);
			}
			if (savestatus == "error") {
				$("#speech_status").html("%L_FAIL%");
			}
		});
	}

	function RunRecognition() {

		if ($("#lang_0").attr("checked") == "checked") lang = "ru";
		if ($("#lang_1").attr("checked") == "checked") lang = "en";
		if ($("#lang_2").attr("checked") == "checked") lang = "de";

		if ($("#engine_0").attr("checked") == "checked") engine = 0;
		if ($("#engine_1").attr("checked") == "checked") engine = 1;

		$("#recognition_status").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {lang: lang, engine: engine}, function(response, status, xhr) {
			if (status == "success") {

				var json;
				var result = "";



				try {

					json = JSON.parse(response);

					result += '<p class="bluetitle">%M_RESULTS%:</p>';
					result += '<p><span class="graytext">%M_STATUS%:</span> ' + json.status + '</p>';
					result += '<p class="graytext">%M_HYPOTHESES%:</p>';

					var hypotheses = "";
					for (var i in json.hypotheses) {
						hypotheses += '<p style="margin-left:50px;"><a href="#" onclick="TextToSpeech(this.text); return false;">' + json.hypotheses[i].utterance + "</a> ( " + Math.round(json.hypotheses[i].confidence * 100) + "% ) " + "</p>";
					}

					result += "<p>" + hypotheses + "</p>";

				} catch (err) {}

				$("#recognition_status").html(result);

$("#recognition_status").html(response);

			}
			if (savestatus == "error") {
				$("#recognition_status").html("%L_FAIL%");
			}
		});
	}


	function SaveSpeechSettings(){

		if ($("#lang_0").attr("checked") == "checked") lang = "ru";
		if ($("#lang_1").attr("checked") == "checked") lang = "en";

		if ($("#engine_0").attr("checked") == "checked") engine = 0;
		if ($("#engine_1").attr("checked") == "checked") engine = 1;

		$("#save_status").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {lang: lang, engine: engine}, function(response, status, xhr) {
			if (status == "success") {
				$("#save_status").html("%M_OK%");
			}
			if (savestatus == "error") {
				$("#save_status").html("%L_FAIL%");
			}
		});
	}


</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>

		<table width="100%">
			<tr valign="top">
				<td>
					<p class="bluetitle">%M_SPEAK_PHRASE%</p>

					<form onSubmit="TextToSpeech($('#texttospeech').val()); return false;">
						<p>
							<input type="text" id="texttospeech" style="width: 300px;">
							<a href="#" class="buttonlink" onclick="TextToSpeech($('#texttospeech').val()); return false;" style="padding-left:20px;">[ %M_SPEAK% ]</a>
							<p></p>
							<span id="pingStatus"></span>
						</p>
					</form>

					<div id="speech_status"></div>

					<p class="graytext">
						%M_USE_CLI_COMMAND%
					</p>

					<p>&nbsp;</p>

					<p class="bluetitle">%M_VOICE_RECOGNITION%</p>

					<div>

						<p><a href="#" class="buttonlink" onclick="RunRecognition(); return false;" style="padding-left:20px;">[ %M_RUN% ]</a></p>

						<div id="recognition_status"></div>

					</div>


				</td>
				<td width="300" align=right>
					<p class="bluetitle">%M_LANGUAGE%</p>
					<div id="speech_lang">
						<input type="radio" id="lang_0" name="lang" {lang0_selected}><label for="lang_0">%M_RUSSIAN%</label>
						<input type="radio" id="lang_1" name="lang" {lang1_selected}><label for="lang_1">%M_ENGLISH%</label>
						<input type="radio" id="lang_2" name="lang" {lang2_selected}><label for="lang_2">%M_GERMAN%</label>
					</div>

					<p>&nbsp;</p>

					<p class="bluetitle">%M_VOICE_SYNTH%</p>
					<div id="speech_engine">
						<input type="radio" id="engine_0" name="engine" {eng0_selected}><label for="engine_0">%M_ESPEAK%</label>
						<input type="radio" id="engine_1" name="engine" {eng1_selected}><label for="engine_1">%M_GOOGLE%</label>
					</div>

					<p>&nbsp;</p>

					<p><a href="#" class="buttonlink" onclick="SaveSpeechSettings(); return false;" style="padding-left:20px;">[ %L_SAVE% ]</a></p>

					<p id="save_status"></p>

				</td>
			</tr>
		</table>

	</div>


</div>

</div>
