require("./styles.css");

var Elm = require('./Main');
var app = Elm.Main.fullscreen();

app.ports.outputToJS.subscribe(function () {
	console.log('Elm -> JS');
	var random = Math.round(Math.random() * 100);
	console.log('JS -> Elm ' + random);
	app.ports.inputFromJS.send(random);
});

app.ports.countDays.subscribe(function () {
	var to = moment([2016, 1, 1]);
	var from = moment();
	var days = from.diff(to, 'days');
	app.ports.daysCounted.send(days);
});
