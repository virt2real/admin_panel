var timerRotate;
var delay;
	
timerRotate = setTimeout("rocknroll()", mkdelay());

function mkdelay(){
	return Math.floor(Math.random() * 10 + 1) * 60000;
}

function rocknroll(){
	var rotation = function (){
		$("#logo").rotate({
		angle:0, 
		animateTo:180,
		callback: backrotation
		});
	}
	var backrotation = function (){
		$("#logo").rotate({
		angle:180, 
		animateTo:0,
		callback: stoprotation
		});
	}
	var stoprotation = function (){
		$("#logo").stop();
	}
	rotation();
	timerRotate = setTimeout("rocknroll()", mkdelay());
}
