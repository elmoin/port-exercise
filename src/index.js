require("./styles.css");

var getRandom = function () {
	return Math.round(Math.random() * 100);
}

var calculateDateDifference = function (dates) {
	var format = 'DD/MM/YYYY';
	var to = moment(dates[0], format);
	var from = moment(dates[1], format);
	return {
		years: from.diff(to, 'years'),
		months: from.diff(to, 'months'),
		days: from.diff(to, 'days')
	};
}

var date1 = "13/07/2016";
var date2 = "17/07/2016";
var model = {
	count: getRandom(),
	countedDays: 0,
	difference: calculateDateDifference([date1, date2]),
	date1: date1,
	date2: date2
}

var Elm = require('./Main');
var app = Elm.Main.fullscreen(model);

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
	app.ports.dateDifference.send(calculateDateDifference(dates));
});
