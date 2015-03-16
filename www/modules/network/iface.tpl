<div class="interfaceblock" name="{name}">
	<p style="color:#ff0000;">{additional_message}</p>
	<p style="{is_hidden}"><input type="checkbox" id="{name}_auto" {autochecked}> %M_START_ON_BOOT%</p>
	<div style="width:100px; float: left;">%M_TYPE%</div>
	<div style="float: left;">
		<select id="{name}_static" onchange='changeType("params_{name}",$(this).val());' style="height: 22px; line-height: 22px; width:150px; margin-bottom: 10px; color: #ffffff; border:1px solid #7c7c7c;">
		  <option value="static" {static_selected}>%M_STATIC%</option>
		  <option value="dhcp" {dhcp_selected}>%M_DYNAMIC%</option>
		</select>
	</div>
</div>
<div style="float:both; clear: both;"></div>
<div class="params_{name} {hidden}">
	<div style="width:100px; float: left;">%M_IP4_ADDRESS%</div>
	<div style="float: left;"><input type="text" id="{name}_address" value="{address}"></div>
</div>
<div style="float:both; clear: both;"></div>
<div class="params_{name} {hidden}">
	<div style="width:100px; float: left;">%M_NETMASK%</div>
	<div style="float: left;"><input type="text" id="{name}_netmask" value="{netmask}"></div>
</div>
<div style="float:both; clear: both;"></div>
<div class="params_{name} {hidden}">
	<div style="width:100px; float: left;">%M_GATEWAY%</div>
	<div style="float: left;"><input type="text" id="{name}_gateway" value="{gateway}"></div>
</div>
<div style="float:both; clear: both;"></div>
<p><a href="#" onclick='ToggleExtended("{name}"); return false;'>%M_ADVANCED_CONFIG%</a></p>
<div id="{name}_extended" style="display: none;">

<div>
	<div style="width:100px; float: left;">%M_HWADDRESS%</div>
	<div style="float: left;"><input type="text" id="{name}_hwaddress" value="{hwaddress}"></div>
</div>
<div style="float:both; clear: both;"></div>


<div>
	<div style="width:100px; float: left;">%M_PRE_UP%</div>
	<div style="float: left;"><input type="text" id="{name}_preup" value="{pre-up}"></div>
</div>
<div style="float:both; clear: both;"></div>
<div>
	<div style="width:100px; float: left;">%M_UP%</div>
	<div style="float: left;"><input type="text" id="{name}_up"value="{up}"></div>
</div>
<div style="float:both; clear: both;"></div>
<div>
	<div style="width:100px; float: left;">%M_POST_UP%</div>
	<div style="float: left;"><input type="text" id="{name}_postup" value="{post-up}"></div>
</div>
<div style="float:both; clear: both;"></div>
<div>
	<div style="width:100px; float: left;">%M_PRE_DOWN%</div>
	<div style="float: left;"><input type="text" id="{name}_predown" value="{pre-down}"></div>
</div>
<div style="float:both; clear: both;"></div>
<div>
	<div style="width:100px; float: left;">%M_DOWN%</div>
	<div style="float: left;"><input type="text" id="{name}_down" value="{down}"></div>
</div>
<div style="float:both; clear: both;"></div>
<div>
	<div style="width:100px; float: left;">%M_POST_DOWN%</div>
	<div style="float: left;"><input type="text" id="{name}_postdown" value="{post-down}"></div>
</div>
<div style="float:both; clear: both;"></div>
</div>

