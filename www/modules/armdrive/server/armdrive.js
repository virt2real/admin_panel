/* turn off errors break */
process.on('uncaughtException', function (err) {
	console.log('Caught exception: ' + err);
});

/* make board object */
var virt2real = require("virt2real");
var board = new virt2real();

/* make motorshield object */
var motorshield = require("motorshield");
motorshield.setAddress(0x40);
motorshield.init();

//board.writeGPIO(33, 0);

/* default speed to move */
var speed = 60;
var direction = 0;
var part = 0;
var light = board.readPin(18);

/* timestamp for alive */
var aliveTimestamp = 0;

/* run websocket server */
var wsserver = require('./wsserver.js');
wsserver.onMessage = onMessage;
wsserver.onConnect = onConnect;
wsserver.start(8888);


/* update status every 3 seconds */
var statusTimer = setInterval(SendStatus, 3000);

function SendStatus() {
	var status = new Object();
	status.v = motorshield.getVoltage(); // voltage
	status.d = direction; // move direction
	status.p = part; // move part
	status.s = speed; // move speed
	status.l = light; // light state
	wsserver.send(JSON.stringify(status));
}

/* check alive every 1 second */
var aliveTimer = setInterval(checkAlive, 1000);

function checkAlive() {

	if (!aliveTimestamp) return;

	var d = new Date();
	if (d.getTime() > aliveTimestamp + 2000) {
		/* comething wrong, stop all motors */
		aliveTimestamp = 0;
		MoveHand1(0, 0);
		MoveHand2(0, 0);
		MoveHand3(0, 0);
		MoveWheels(0, 0);
	}
}

function onConnect(message) {
	console.log("* client connected");
	SendStatus();
}

function onMessage(message) {
	var json;

	try {
		json = JSON.parse(message);
	} catch (err) { return; }

	/* check part */
	switch (json.act) {

		case "a":
			/* update alive timestamp*/
			var d = new Date();
			aliveTimestamp = d.getTime();
			break;
	
		case "d":
			direction = json.v;
			UpdateMove(part, direction, speed);
			SendStatus();
			break;

		case "p":
			/* Part Toggle */
			part = json.v;
			UpdateMove(part, direction, speed);
			SendStatus();
			break;

		case "l":
			/* Light Toggle or Set*/
			if (json.v == 1)
				light = 1;
			else if (json.v == 2)
				light = 0;
			else
				light = (!board.readPin(18) == 1) ? 1 : 0;
			board.writePin(18, light);
			SendStatus();
			break;

		case "s":
			/* Change speed */
			speed = parseInt(json.v);
			UpdateMove(part, direction, speed);
			SendStatus();
			break;
	}

}

function UpdateMove(currentpart, dir, speed) {

	switch (currentpart) {
		case 0: 
			MoveHand1(0, 0);
			MoveHand2(0, 0);
			MoveHand3(0, 0);
			MoveWheels(dir, speed);
			break;
		case 1: 
			MoveWheels(0, 0);
			MoveHand2(0, 0);
			MoveHand3(0, 0);
			MoveHand1(dir, speed);
			break;
		case 2: 
			MoveWheels(0, 0);
			MoveHand1(0, 0);
			MoveHand3(0, 0);
			MoveHand2(dir, speed);
			break;
		case 3: 
			MoveWheels(0, 0);
			MoveHand1(0, 0);
			MoveHand2(0, 0);
			MoveHand3(dir, speed);
			break;
	}

}


function MoveWheels(direction, speed) {
	switch (direction) {
		case 0: /* stop */
			motorshield.J1.setSpeed(1, 0);
			motorshield.J1.setSpeed(2, 0);
			break;
		case 1:	/* up */	
			motorshield.J1.setDirection (1, 1, 0);
			motorshield.J1.setDirection (2, 0, 1);
			motorshield.J1.setSpeed(1, speed);
			motorshield.J1.setSpeed(2, speed);
			break;
		case 2: /* down */
			motorshield.J1.setDirection (1, 0, 1);
			motorshield.J1.setDirection (2, 1, 0);
			motorshield.J1.setSpeed(1, speed);
			motorshield.J1.setSpeed(2, speed);
			break;
		case 4: /* turn left  */
			motorshield.J1.setDirection (1, 1, 0);
			motorshield.J1.setDirection (2, 1, 0);
			motorshield.J1.setSpeed(1, speed);
			motorshield.J1.setSpeed(2, speed);
			break;
		case 8: /* turn right  */
			motorshield.J1.setDirection (1, 0, 1);
			motorshield.J1.setDirection (2, 0, 1);
			motorshield.J1.setSpeed(1, speed);
			motorshield.J1.setSpeed(2, speed);
			break;
		case 5: /* move forward and left  */
			motorshield.J1.setDirection (1, 1, 0);
			motorshield.J1.setSpeed(1, speed);
			motorshield.J1.setSpeed(2, 0);
			break;
		case 9: /* move forward and right  */
			motorshield.J1.setDirection (2, 0, 1);
			motorshield.J1.setSpeed(1, 0);
			motorshield.J1.setSpeed(2, speed);
			break;
		case 6: /* move back and left  */
			motorshield.J1.setDirection (2, 1, 0);
			motorshield.J1.setSpeed(2, speed);
			motorshield.J1.setSpeed(1, 0);
			break;
		case 10: /* move righter  */
			motorshield.J1.setDirection (1, 0, 1);
			motorshield.J1.setSpeed(2, 0);
			motorshield.J1.setSpeed(1, speed);
			break;
	}

}

function MoveHand1(direction, speed) {

	if (direction == 0) {
		motorshield.J1.setSpeed(3, 0);
		motorshield.J1.setSpeed(5, 0);
	}

	if (direction & 1) {
		motorshield.J1.setDirection (3, 1, 0);
		motorshield.J1.setSpeed(3, speed);
	} else
	if (direction & 2) {
		motorshield.J1.setDirection (3, 0, 1);
		motorshield.J1.setSpeed(3, speed);
	} else
		motorshield.J1.setSpeed(3, 0);

	if (direction & 4) {
		motorshield.J1.setDirection (5, 1, 0);
		motorshield.J1.setSpeed(5, speed);
	} else 
	if (direction & 8) {
		motorshield.J1.setDirection (5, 0, 1);
		motorshield.J1.setSpeed(5, speed);
	} else
		motorshield.J1.setSpeed(5, 0);

}

function MoveHand2(direction, speed) {

	if (direction == 0) {
		motorshield.J1.setSpeed(6, 0);
		motorshield.J1.setSpeed(7, 0);
	}

	if (direction & 1) {
		motorshield.J1.setDirection (6, 1, 0);
		motorshield.J1.setSpeed(6, speed);
	} else 
	if (direction & 2) {
		motorshield.J1.setDirection (6, 0, 1);
		motorshield.J1.setSpeed(6, speed);
	} else
		motorshield.J1.setSpeed(6, 0);

	if (direction & 4) {
		motorshield.J1.setDirection (7, 1, 0);
		motorshield.J1.setSpeed(7, speed);
	} else 
	if (direction & 8) {
		motorshield.J1.setDirection (7, 0, 1);
		motorshield.J1.setSpeed(7, speed);
	} else {
		motorshield.J1.setSpeed(7, 0);
	}

}

function MoveHand3(direction, speed) {

	if (direction == 0) {
		motorshield.J1.setSpeed(4, 0);
		motorshield.J1.setSpeed(7, 0);
	} 

	if (direction & 1) {
		motorshield.J1.setDirection (4, 0, 1);
		motorshield.J1.setSpeed(4, speed);
	} else 
	if (direction & 2) {
		motorshield.J1.setDirection (4, 1, 0);
		motorshield.J1.setSpeed(4, speed);
	} else
		motorshield.J1.setSpeed(4, 0);

	if (direction & 4) {
		motorshield.J1.setDirection (7, 1, 0);
		motorshield.J1.setSpeed(7, speed);
	} else 
	if (direction & 8) {
		motorshield.J1.setDirection (7, 0, 1);
		motorshield.J1.setSpeed(7, speed);
	} else
		motorshield.J1.setSpeed(7, 0);

}



