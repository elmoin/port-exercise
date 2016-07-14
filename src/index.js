require("./styles.css");

var Elm = require('./Main');
var app = Elm.Main.fullscreen({
	count: (Math.round(Math.random() * 100)),
	difference: 0,
	firstField: "01-07-2016",
	secondField: "02-07-2016",
	differenceOfDates: 0
});

app.ports.outputToJS.subscribe(function () {
	console.log('Elm -> JS');
	var random = Math.round(Math.random() * 100);
	console.log('JS -> Elm ' + random);
	app.ports.inputFromJS.send(random);
});

app.ports.calculateDifference.subscribe(function() {
	var a = moment([2016, 0, 1]);
	var b = moment();
	console.log(a);
	console.log(b);
	var c = b.diff(a, 'days');
	console.log('JS -> Elm ' + c);
	app.ports.getDifference.send(c);
});

app.ports.calculateDifferenceBetweenDates.subscribe(function (dates) {
	var date1 = dates[0];
	var date2 = dates[1];

	var firstDate = moment(date1, "DD-MM-YYYY");
	var secondDate = moment(date2, "DD-MM-YYYY");
	var difference = secondDate.diff(firstDate, 'days');

	app.ports.updateDifference.send(difference);
});
