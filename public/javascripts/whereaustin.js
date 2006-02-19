/*********  Icons! **************/

// Base Icon, bearing the common characteristics of all markers
var base_icon = new GIcon();
base_icon.shadow = "/images/marker_shadow.png";
base_icon.iconSize = new GSize(12, 20);
base_icon.shadowSize = new GSize(22, 20);
base_icon.iconAnchor = new GPoint(6, 20);
base_icon.infoWindowAnchor = new GPoint(5, 1);

// Icons for the music event types
var recommended_icon = new GIcon(base_icon);
recommended_icon.image = "/images/recommended.png";

var roadshow_icon = new GIcon(base_icon);
roadshow_icon.image = "/images/roadshow.png";

var music_icon = new GIcon(base_icon);
music_icon.image = "/images/music.png";

var dj_icon = new GIcon(base_icon);
dj_icon.image = "/images/dj.png";

var karaoke_icon = new GIcon(base_icon);
karaoke_icon.image = "/images/karaoke.png";

var mic_icon = new GIcon(base_icon);
mic_icon.image = "/images/mic.png";

// Icon for search results
var black_icon = new GIcon(base_icon);
black_icon.image = "/images/black.png";

// Icons for Wifi status
var wifi_online_icon = new GIcon(base_icon);
wifi_online_icon.image = "/images/wifi_online.png";

var wifi_flakey_icon = new GIcon(base_icon);
wifi_flakey_icon.image = "/images/wifi_flakey.png";

var wifi_offline_icon = new GIcon(base_icon);
wifi_offline_icon.image = "/images/wifi_offline.png";

var wifi_low_usage_icon = new GIcon(base_icon);
wifi_low_usage_icon.image = "/images/wifi_low_usage.png";

/*********** Map! ************/

var markers = [];
var htmls = [];
var i = 0;

function createMarker(point, type, html)
{
  var icon;
  
	switch(type){
	// MUSIC Icons
	case "recommended": icon = recommended_icon;  break;
	case "roadshow":    icon = roadshow_icon;     break;
	case "karaoke":     icon = karaoke_icon;      break;
	case "music":       icon = music_icon;        break;
	case "mic":         icon = mic_icon;          break;
	case "dj":          icon = dj_icon;           break;
	// WIFI Icons
	case "online":      icon = wifi_online_icon;  break;
	case "flakey":      icon = wifi_flakey_icon;  break;
	case "offline":     icon = wifi_offline_icon; break;
	case "lowusage":    icon = wifi_low_usage_icon; break;
	default:
	    alert(type);
	}
	
	var marker = new GMarker(point, icon);
	GEvent.addListener(marker, "click", function() {
	  marker.openInfoWindowHtml(html);
	});
	
	// save the info we need to use later for the table
	markers[i] = marker;
	htmls[i] = html;
	
	i++;
	return marker;
}

function click(i) {
    markers[i].openInfoWindowHtml(htmls[i]);
}


// Center the map on 6th and Congress
var map = new GMap(document.getElementById("map"));
var centerAustin = new GPoint(-97.742883, 30.268208);
var instructions = '<p id=\"instruction\">Click on the list or the map\'s markers to see what is going on in Austin.</p>';
map.addControl(new GLargeMapControl());
map.addControl(new GMapTypeControl());
map.centerAndZoom(centerAustin, 4);
map.openInfoWindowHtml(centerAustin, instructions);

var request = GXmlHttp.create();
request.open('GET', 'event/markers', true);
request.onreadystatechange = function() {
  if (request.readyState == 4) {
		var xmlDoc = request.responseXML;
		var markers = xmlDoc.documentElement.getElementsByTagName("marker");
		for (var i = 0; i < markers.length; i++) {
	  	var point = new GPoint(parseFloat(markers[i].getAttribute("lng")),
							               parseFloat(markers[i].getAttribute("lat")));
	  	var type = markers[i].getAttribute("type");
	  	var html = markers[i].getAttribute("info");
	  	var marker = createMarker(point, type, html);
	  	map.addOverlay(marker);
		}
  }
}
request.send(null);


/*

// Creates one of our markers at the given point
function createMarker(point, name, icon_type) {
  var marker = new GMarker(point, icon_type);
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
	
		var icon_type;
		switch (event[i]['type']) {
		case "recommended": icon_type = recommended_icon;	break;
		case "roadshow":    icon_type = roadshow_icon;     break;
		case "karaoke":     icon_type = karaoke_icon;      break;
		case "music":       icon_type = music_icon;        break;
		case "mic":         icon_type = mic_icon;          break;
		case "dj":          icon_type = dj_icon;           break;
		default:            alert("invalid icon type");   break;
		}
		createMarker(new GPoint(event[i]['long'], event[i]['lat']), event[i]['info'], icon_type);
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