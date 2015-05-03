//http://stackoverflow.com/questions/14801349/ultra-simple-chrome-extension-doesnt-addeventlistener-to-button-onclick-event
var items = document.querySelectorAll(".savebtn");
console.log("Running");
for (var i = 0; i < items.length; i++) {
	console.log("Running Inside");
	var el = items[i];

	//capturing phase
	el.addEventListener("click", doSomething, true);
}

function doSomething(e) {
	console.log(e.currentTarget.id);
}