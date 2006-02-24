
      var gmarkers = [];
      var htmls = [];
      var i = 0;


      // A function to create the marker and set up the event window
      function createMarker(point,icon,name,html,location,address) {

        switch (icon) {
                        case "recommended":
                        pointicon = recommendedicon;
                        break;
                case "roadshow":
                    pointicon = roadshowicon;
                    break;
                case "mic":
                        pointicon = micicon;
                    break;
                case "karaoke":
                        pointicon = karaokeicon;
                    break;
                case "dj":
                        pointicon = djicon;
                    break;
		case "wifi":
			pointicon = wifiicon;
			break;
               case "online":
                        pointicon = wifionlineicon;
                        break;
               case "lowusage":
                        pointicon = wifilowusageicon;
                        break;
               case "offline":
                        pointicon = wifiofflineicon;
                        break;
               case "flakey":
                        pointicon = wififlakeyicon;
                        break;
                default:
                        pointicon = normalicon;
                }


        var marker = new GMarker(point,pointicon);
        GEvent.addListener(marker, "click", function() {
          marker.openInfoWindowHtml(html);
        });

        // save the info we need to use later for the table
        gmarkers[i] = marker;
        htmls[i] = html;

        i++;
        return marker;
      }

      // This function picks up the click and opens the corresponding info window
      function myclick(i) {
        gmarkers[i].openInfoWindowHtml(htmls[i]);
      }


function assemblewifiMap (xmlurl) {



      // Read the data from genxml.php
      var request = GXmlHttp.create();
      request.open("GET", xmlurl, true);
      request.onreadystatechange = function() {
        if (request.readyState == 4) {   
          var xmlDoc = request.responseXML;
          // obtain the array of markers and loop through it
          var markers = xmlDoc.documentElement.getElementsByTagName("marker");

          for (var i = 0; i < markers.length; i++) {
            // obtain the attribues of each marker
            var lat = parseFloat(markers[i].getAttribute("lat"));
            var lng = parseFloat(markers[i].getAttribute("lng"));
            var point = new GPoint(lng,lat);
            var html = GXml.value(markers[i].getElementsByTagName("infowindow")[0]);
            var location = GXml.value(markers[i].getElementsByTagName("location")[0]);
            var address = GXml.value(markers[i].getElementsByTagName("address")[0]);
        var status = GXml.value(markers[i].getElementsByTagName("status")[0]); 
	   // create the marker
            var marker = createMarker(point,status, '',html,location,address);
            map.addOverlay(marker);
          }
        }
      }
      request.send(null);
     }// end assemblewifiMap();

function assembleMap (xmlurl) {
        // Read the data from genxml.php
        var request = GXmlHttp.create();
      request.open("GET", xmlurl, true);
      request.onreadystatechange = function() {
        if (request.readyState == 4) {
          var xmlDoc = request.responseXML;
          // obtain the array of markers and loop through it
          var markers = xmlDoc.documentElement.getElementsByTagName("marker");

          for (var i = 0; i < markers.length; i++) {
            // obtain the attribues of each marker
            var lat = parseFloat(markers[i].getAttribute("lat"));
            var lng = parseFloat(markers[i].getAttribute("lng"));
            var point = new GPoint(lng,lat);
            var html = GXml.value(markers[i].getElementsByTagName("infowindow")[0]);
                var icon = GXml.value(markers[i].getElementsByTagName("icon")[0]);
            var location = GXml.value(markers[i].getElementsByTagName("location")[0]);
                var address = GXml.value(markers[i].getElementsByTagName("address")[0]);
            //var html = markers[i].getAttribute("html");
          var label = GXml.value(markers[i].getElementsByTagName("name")[0]);
            // create the marker
            var marker = createMarker(point,icon, label,html,location,address);
            map.addOverlay(marker);
          }
        }
      }
      request.send(null);
     }// end assembleMap();

function getSelect(s) {
  return s.options[s.selectedIndex].value
}

function loadnewdb(loaddb) {



if (loaddb == 'wifi') {
map.clearOverlays();
gmarkers = [];
htmls = [];
i = 0;
xmlurl = "wifixml.php";
assemblewifiMap (xmlurl);
updateTable(xmlurl);
obj.setColumnCount(3);

document.getElementById("datedropdown").style.display = 'none';
document.getElementById("musicmarkers").style.display = 'none';
document.getElementById("wifiicons").style.display = 'inline';
//      provide column labels
        obj.setHeaderText(['Status','Location','Address']);
}

if (loaddb == 'events') {

var columns = ["Type", "Location", "Event", "Address"];

loaddate = document.getElementById("eventsdate").options[document.getElementById("eventsdate").selectedIndex].value;
map.clearOverlays();
gmarkers = [];
htmls = [];
i = 0;
xmlurl = "genxml.php?listingdate=" + loaddate;
assembleMap(xmlurl);
updateTable(xmlurl);
        obj.setColumnCount(4);
        //      provide column labels
        obj.setHeaderText(columns);
document.getElementById("datedropdown").style.display = 'inline';
document.getElementById("musicmarkers").style.display = 'inline';
document.getElementById("wifiicons").style.display = 'none';

}

}

function tablemapflip() {
document.getElementById("map").style.height = '20px';
document.getElementById("MusicGrid").style.height = '100%';
}


function loadnewdate(loaddate) {

map.clearOverlays();

gmarkers = [];
htmls = [];
i = 0;

xmlurl = "genxml.php?listingdate=" + loaddate;
assembleMap(xmlurl);
updateTable(xmlurl);
}


function createSearchMarker(lat,lng,name,html,address) {

        var point = new GPoint(lng,lat);
		pointicon = blackicon;
        html = name;
        var marker = new GMarker(point,pointicon);
        GEvent.addListener(marker, "click", function() {
        marker.openInfoWindowHtml(html);
        });

        map.addOverlay(marker);
        marker.openInfoWindowHtml(html);
      }


function updateTable(xmlurl) {
    table.setURL(xmlurl);
    table.request();
    obj.setCellModel(table);
}



     function onGLoad() {
      // arrays to hold copies of the markers and html used by the table
      // because the function closure trick doesnt work there

	map = new GMap(document.getElementById("map")); // not using var makes the map variable global. 

	//alert('ongload');


      // create the map
      map.addControl(new GLargeMapControl());
      map.addControl(new GMapTypeControl());
      map.centerAndZoom(new GPoint(-97.742883, 30.268208),4);    
	assembleMap("genxml.php");
  }


