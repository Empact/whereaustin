// Create a base icon
var baseicon = new GIcon();
baseicon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
baseicon.iconSize = new GSize(12, 20);
baseicon.shadowSize = new GSize(22, 20);
baseicon.iconAnchor = new GPoint(6, 20);
baseicon.infoWindowAnchor = new GPoint(5, 1);

// Create our recommendedicon
var recommendedicon = new GIcon(baseicon);
recommendedicon.image = "/images/recommended.png";

// Create our roadshow marker icon
var roadshowicon = new GIcon(baseicon);
roadshowicon.image = "/images/roadshow.png";

// Create our "tiny" normal marker icon
var musicicon = new GIcon(baseicon);
musicicon.image = "/images/music.png";

// create dj icon
var djicon = new GIcon(baseicon);
djicon.image = "/images/dj.png";

// create karaoke icon
var karaokeicon = new GIcon(baseicon);
karaokeicon.image = "/images/karaoke.png";

// create  mic icon
var micicon = new GIcon(baseicon);
micicon.image = "/images/mic.png";


// Center the map on 6th and Congress
var map = new GMap(document.getElementById("map"));
var centerAustin = new GPoint(-97.742883, 30.268208);
var instructions = '<p id=\"instruction\">Click on the list or the map\'s markers to see what is going on in Austin.</p>';
map.addControl(new GLargeMapControl());
map.addControl(new GMapTypeControl());
map.centerAndZoom(centerAustin, 4);
map.openInfoWindowHtml(centerAustin, instructions);
/*

// Display a given set of events


// Creates one of our markers at the given point
function createMarker(point, name, icontype) {
  var marker = new GMarker(point, icontype);
  map.addOverlay(marker);
  GEvent.addListener(marker, "click", function() {
    marker.openInfoWindowHtml(name);
  });
}

function moveAndOpenInfo(longi,latt,infoHtml){
	//alert("Moving to "+$long+ ", " + $latt);
	var xy = new GPoint(longi,latt);
	// map.openInfoWindow(xy, document.createTextNode(lat));
	map.recenterOrPanToLatLng(xy);
	
	map.openInfoWindowHtml(xy, infoHtml,new GSize(0, -20)); //Works
}

function ff(eventId) {
	// Accessor for "moveAndOpenInfo"
	moveAndOpenInfo(event[eventId]['long'], event[eventId]['lat'], event[eventId]['info']);
}

function printff(infoHTML) {     
	document.write(infoHTML);
}

function showdirform(latitude) {
	document.getElementById("latitude").style.display = "visible";
}

function getSelect(s) {
  return s.options[s.selectedIndex].name
}

function redraw (icon) {
	
	alert(event[0]['type']);
	
	map.clearOverlays();
	
	for (i = 0; i <= event.length; i++) {
		if ((event[i]['type'] != icon) && (icon != "all")){
			continue;
		}
	
		var icontype;
		switch (event[i]['type']) {
		case "recommended": icontype = recommendedicon;	break;
		case "roadshow":    icontype = roadshowicon;    break;
		case "karaoke":     icontype = karaokeicon;     break;
		case "mic":         icontype = micicon;         break;
		case "dj":          icontype = djicon;          break;
		default:            icontype = normalicon;      break;
		}
		createMarker(new GPoint(event[i]['long'], event[i]['lat']), event[i]['info'], icontype);
	}
}

function ffzoom(lng,lat,infoHTML) {
	var xy = new GPoint(lng,lat);
	// map.openInfoWindow(xy, document.createTextNode(lat));
	map.openInfoWindowHtml(xy, infoHTML,new GSize(0, -20)); //Works
}

function loadnewdate(loaddate) {
	window.location.href= "http://www.thecorporatedrone.com/jpratt/index.php?listingdate=" + loaddate;
}*/