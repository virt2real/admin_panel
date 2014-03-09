/* turn on/off textarea words wrap */
function noWrap(obj) {
	var state = $(obj).css("white-space");
	var newstate = (state == "nowrap") ? "normal" : "nowrap";
	$(obj).css("white-space", newstate);
}

