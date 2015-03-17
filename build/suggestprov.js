var xmlHttp = new XMLHttpRequest();

function StateSuggestions() {
}

//Get list of suggestions and pass to the autosuggest
function showSuggestion(ctrl, type) {
	return function() {
		if (xmlHttp.readyState == 4) {
			var aSuggestions = [];

			var s = xmlHttp.responseXML.getElementsByTagName('CompleteSuggestion');
			for (i = 0; i < s.length; i++) {
				var text = s[i].childNodes[0].getAttribute("data");
				aSuggestions.push(text);
			}
			ctrl.autosuggest(aSuggestions, type);
		}
	}
}

//Retrieve results from google suggest
StateSuggestions.prototype.requestSuggestions = function(oAutoSuggestControl, bTypeAhead) {
	var sTextboxValue = oAutoSuggestControl.textbox.value;
	
	if (sTextboxValue.length > 0) {
		var request = "/eBay/suggest?q="+encodeURIComponent(sTextboxValue);
	
		xmlHttp.open("GET", request); 
		xmlHttp.onreadystatechange = showSuggestion(oAutoSuggestControl, bTypeAhead); 
		xmlHttp.send(null);
	}
};