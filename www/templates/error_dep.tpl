<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {} });
	});

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%L_DEP_ERROR%</a></h3>
	<div>
		<p class="bluetitle">%L_FILES_NEEDED%</p>
		<div>{dep_files}</div>
		<p></p>
		<p class="bluetitle">%L_TRY_INSTALLING%</p>
		<div>{dep_descr}</div>
	</div>
</div>

</div>
