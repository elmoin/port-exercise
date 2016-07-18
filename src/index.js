require("./styles.css");

var getRandom = function () {
	return Math.round(Math.random() * 100);
}

var Elm = require('./Main');
var app = Elm.Main.fullscreen(getRandom());

app.ports.outputToJS.subscribe(function () {
	console.log('Elm -> JS');
	var random = getRandom();
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
	var diff = {
		years: from.diff(to, 'years'),
		months: from.diff(to, 'months'),
		days: from.diff(to, 'days')
	};
	console.log('diff', diff);
	app.ports.dateDifference.send(diff);
});
