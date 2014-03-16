<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_GENERAL_INFORMATION%</a></h3>
	<div>
			<p style="text-align: right;">%M_ADMIN_GUI_VERSION%: {admin_version}</p>
			<p class="bluetitle">%M_DEVICE_ID%</p>
			<p style="margin-left: 50px; font-size: 1.4em; ">{deviceID}</p>
			<p class="bluetitle">%M_DEVICE_DESCRIPTION%</p>
			<p style="margin-left: 50px;">{deviceDescription}</p>

			<p style="text-align: right; text-decoration: none;"><a href="?deviceid">[ %M_CHANGE% ]</a></p>
			<p></p>

	</div>

	<h3><a href="#">%M_KERNEL_INFO%</a></h3>
	<div>

			<div>{linuxversion}</div>
			<br>
			<div>
				<p class="bluetitle">%M_CMDLINE%:</p>
				<p>{cmdline}</p>
			</div>


	</div>

	<h3><a href="#">%M_CPU_INFO%</a></h3>
	<div>
			<div>
			<div><p class="bluetitle">%M_CPU%:</p><p>{cpuinfo}</p></div>
			<br>
			<div><p class="bluetitle">%M_MEMORY%:</p><p>{meminfo}</p></div>
			<br>
			</div>
	</div>

	<h3><a href="#">%M_ACTIVE_MODULES%</a></h3>
	<div>
			<div>{modules}</div>
	</div>

</div>
