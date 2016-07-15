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

app.ports.calculateDateDifference.subscribe(function (dates) {
	var format = 'DD/MM/YYYY';
	var to = moment(dates[0], format);
	var from = moment(dates[1], format);
	app.ports.dateDifference.send({
		years: from.diff(to, 'years'),
		months: from.diff(to, 'months'),
		days: from.diff(to, 'days')
	});
});
