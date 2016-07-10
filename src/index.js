require("./styles.css");

var Elm = require('./Main');
var app = Elm.Main.fullscreen();

app.ports.output.subscribe(function () {
	console.log('JS called by Elm');
	var random = Math.round(Math.random() * 100);
	console.log('JS send to Elm ' + random);
	app.ports.input.send(random);
});
