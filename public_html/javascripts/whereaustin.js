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

var debug = false;
var instr = false;
var centerAustin = new GPoint(-97.742883, 30.268208);
var markers = {};

// Create & Initialize Map
var map = new GMap(document.getElementById("map"));
GEvent.addListener(map, 'loading', function() {
  instr = false;
  map.closeInfoWindow();
  map.openInfoWindowHtml(centerAustin, '<p id="loading" style="width: 140px;"><img src="http://whereaustin.com/images/spinner.gif" alt="Loading..." /> Hang on a sec...</p>');
});
GEvent.addListener(map, 'addoverlay', function() {
  if (!instr){
    map.closeInfoWindow();
    map.openInfoWindowHtml(centerAustin, '<p id="instruction">Click on the list or the map\'s markers to see what is going on in Austin.</p>');
    instr = true;
  }
});
map.addControl(new GLargeMapControl());
map.addControl(new GMapTypeControl());

// Utility Functions
function say(message)
{
    if (debug){
        alert(message);
    }
}

function getIcon(type)
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
	    icon = music_icon; say(type);
	}
	return icon;
}

function createMarker(id, point, type, html)
{
  var icon = getIcon(type);
	say(html);
	var marker = new GMarker(point, icon);
	GEvent.addListener(marker, "click", function() {
	  marker.openInfoWindowHtml(html);
	});
	
	// save the info we need to use later for the table
	markers[id] = marker;

	return marker;
}

function pop(id) {
    GEvent.trigger(markers[id], 'click');
}

function getSelect(s) {
  return s.options[s.selectedIndex].value
}

function overlayMap(xml)
{
  GEvent.trigger(map, 'loading')
	map.clearOverlays();
	
	var request = GXmlHttp.create();
	request.open('GET', xml, true);
	request.onreadystatechange = function() {
	  if (request.readyState == 4) {
			var xmlDoc = request.responseXML;
			var new_markers = xmlDoc.documentElement.getElementsByTagName("marker");
			for (var i = 0; i < new_markers.length; i++) {
			  var marker = new_markers[i];
			  var id = marker.getAttribute("id");
		  	var point = new GPoint(parseFloat(marker.getAttribute("lng")),
								               parseFloat(marker.getAttribute("lat")));
		  	var type = marker.getAttribute("type");
		  	var html = marker.getAttribute("info");
	  		map.addOverlay(createMarker(id, point, type, html));
			}
	  }
	}
	request.send(null);
}