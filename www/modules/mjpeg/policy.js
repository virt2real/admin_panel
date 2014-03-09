var net = require("net");
var policyRequest = '<policy-file-request/>\0';
var policyResponse = "<cross-domain-policy><site-control permitted-cross-domain-policies=\"master-only\"/><allow-access-from domain=\"*\" to-ports=\"*\"/></cross-domain-policy>\0";

var control = net.createServer(function (stream) {
	stream.setTimeout(0);
	stream.setNoDelay(true);
	stream.bufferSize = 512;

	stream.on("connect", function () {
		console.log("*** user connected");
	});

    stream.on("data", function (data) {
		if (data == policyRequest) {
			// flash policy request
			stream.write(policyResponse);
			return;
		}
    });

    stream.on("end", function () {
    	// user disconnected
    	console.log("*** user disconnected");
    });

    stream.on("error", function () {
    	// user stream error
		console.log("*** error user connection/disconnection or receive data");
    });

});

control.listen(843);

//hook all errors
process.on('uncaughtException', function (err) {
	console.log('Caught exception: ' + err);
});
