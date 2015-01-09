var http = require('http');
var url = require('url');

var ssdp = require("./peer-ssdp");
var peer = ssdp.createPeer();

var deviceInstance = new Object();
var saveFile = "";

/* parse cmd line params */
var scanTimelimit = process.argv[2]; // time limit for scan (seconds)
var deviceFilter = process.argv[3]; // ssdp device filter
saveFile = process.argv[4]; // save output to file

function stopScan () {
    peer.close();
}

var limitTimer;
if (scanTimelimit > 0)
    limitTimer = setTimeout(stopScan, scanTimelimit * 1000);


peer.on("ready", function () {
    onReady();
});

peer.on("close", function () {
    clearTimeout(limitTimer);
});

peer.on("notify", function (headers, address) {
	console.log("found: " + headers.SERVER);
	if (headers.SERVER.indexOf(deviceFilter) > -1) {
		deviceParse(headers);
		peer.close();
	}
});

peer.start();

var onReady = function () {
    console.log("search for devices");
    peer.search({
        ST: "upnp:rootdevice"
    });
};

function deviceParse (headers) {
	deviceInstance["server"] = headers.SERVER;
	deviceInstance["location"] = headers.LOCATION;
	deviceInstance["timestamp"] = new Date().getTime();

	http.get(headers.LOCATION, function(res) {
		res.on('data', function (chunk) {
			deviceInfoParse(chunk);
		});
	}).on('error', function(e) {
		console.log("error: " + e.message);
		//console.log("search again");
		//peer.start();
	});
}

function deviceInfoParse (str) {
	var reg;
	var tagArray = ["friendlyName", "manufacturer", "manufacturerURL", "modelDescription", "modelName", "modelURL", "av:X_ScalarWebAPI_ActionList_URL", "av:X_ScalarWebAPI_LiveView_URL"]

	/* parse fields from XML */
	for (var i in tagArray) {
		//reg = /<tag>(.*?)<\/tag>/gi;
		reg = "<" + tagArray[i] + ">(.*?)<\/" + tagArray[i] + ">";
		var expr = new RegExp(reg, "gi");
		var vals = expr.exec(str);
		if (!vals) continue;
		var val = vals[1];
		deviceInstance[tagArray[i]] = val;
		//console.log("\t" + tagArray[i] + ": " + val);
	}

	/* check main field */
	if (deviceInstance["av:X_ScalarWebAPI_ActionList_URL"] != undefined) {
		deviceInstance["actionUrl"] = deviceInstance["av:X_ScalarWebAPI_ActionList_URL"] + "/camera";

		/* save to file or show in console */
		if (saveFile)
			writeFile (saveFile, JSON.stringify(deviceInstance));
		else 
			console.log(deviceInstance);

		// only for SONY, send sample command (take a photo)
		//sendCommand("actTakePicture", [], deviceInstance["actionUrl"]);

	} else {
		//console.log("action URL not found, search again");
		//peer.start();
	}
}

function writeFile (filename, text) {
	var fs = require('fs');
	fs.writeFile(filename, text, function(err) {
	    if(err) {
    	    console.log("error: " + err);
	    } else {
        	console.log("save done");
    	}
	}); 
}

function sendRequest (command, actionurl) {
	var urlParts = url.parse(actionurl);
	var options = {
		host: urlParts.hostname,
		path: urlParts.path,
		port: urlParts.port,
		method: 'POST'
	};

	callback = function(response) {
		var str = ''
		response.on('data', function (chunk) {
			str += chunk;
		});
		response.on('end', function () {
			console.log(str);
		});
	}

	var req = http.request(options, callback);
	var strCommand = JSON.stringify(command);
	req.write(strCommand);
	console.log("sending request: " + strCommand);
	req.end();
}

function sendCommand(method, params, url) {
	var command = {
		"method": method,
		"params": params,
		"id": 1,
		"version": "1.0"
	}
	sendRequest (command, url);
}
