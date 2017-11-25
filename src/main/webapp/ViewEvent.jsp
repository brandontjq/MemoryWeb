<%-- 
    Document   : ViewEvent
    Created on : Nov 1, 2017, 1:49:03 PM
    Author     : nicholastps
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.PatientDAO"%>
<%@page import="dao.EventDAO"%>
<%@page import="entity.Event"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
            var request;
            var latitude;
            var longtitude;
            var eventLat;
            var eventLng;
            var patientCoordinates;
            var eventCoordinates;
</script>
        <%
            String event_id_str = request.getParameter("event_id");
            event_id_str = "2";
            double event_id_double = 0;
            int event_id = 0;
            if (event_id_str != null) {
                event_id_double = Double.parseDouble(event_id_str);
                event_id = (int) event_id_double;
                //get event
                EventDAO eventDAO = new EventDAO();
                Event currentEvent = eventDAO.getEvent(2);
                //Event currentEvent = eventDAO.getEvent(event_id);
                //event coordinates
                //System.out.println(currentEvent.getEvent_name());
                double eventLat = currentEvent.getEvent_lat();
                //System.out.println(eventLat);
                double eventLng = currentEvent.getEvent_lng();
                //System.out.println(eventLng);
        %>
                <script>
                    eventLat = <%=eventLat%>;
                    eventLng = <%=eventLng%>;
                </script><%
            }
            String patient_id_str = request.getParameter("patient_id");
            double patient_id_double = 0;
            int patient_id = 0;
            Date lastSeen = null;
            double[] coordinates = null;
            //hardcode for testing
            patient_id_str = "1";
            PatientDAO patientDAO = new PatientDAO();
            if (patient_id_str != null) {
                patient_id_double = Double.parseDouble(patient_id_str);
                patient_id = (int) patient_id_double;

            }
             
        %>
<!DOCTYPE html>
 <html>
   <head>
       <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Memory Web</title>
    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script src="Scripts/moment.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <!--         Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <!--         Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="css/memorywebcss.css" rel="stylesheet">
        
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
     <title>Memory Web Events Page</title>
     <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
     <meta charset="utf-8">
     <style>
       html, body, #map_canvas {
         margin: 0;
         padding: 0;
         height: 100%;
       }
     </style>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAB8vLiub7SMxT79DBCi6o3U-BDsIJq5nQ&callback=initMap">
    </script>
<script type="text/javascript">
var map;
var marker;
function initMap() {
    startTime();
    getFormattedDate();
    var promise = getPatientLocation();
    promise.done(function(result){
    directionsDisplay = new google.maps.DirectionsRenderer();
    var node = new google.maps.LatLng(1.2997055,103.8454882);
    var mapOptions = {
      zoom: 12,
      center: {lat: 1.3521, lng: 103.8198},
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById('map'),
        mapOptions);
    directionsDisplay.setMap(map);

      navigator.geolocation.getCurrentPosition(function(position) {
        pos = new google.maps.LatLng(position.coords.latitude,
                                         position.coords.longitude);

        marker = new google.maps.Marker({
              position : pos,
              map: map,
              title:'My Location'
        });
        var marker1 = new google.maps.Marker({
              position : node,
              map: map,
              title:'Dhoby Ghaut MRT'
        });

        // map.setCenter(pos);
        var bounds = new google.maps.LatLngBounds();
        bounds.extend(marker.getPosition());
        bounds.extend(marker1.getPosition());
        map.fitBounds(bounds);
        calcRoute(pos,node);
      }, function() {
        handleNoGeolocation(true);
      });

      setInterval("getPatientLocation()", 10000);
  });
  }
  function handleNoGeolocation(status) {
    alert(latitude+longtitude);
    var node = new google.maps.LatLng(latitude, longtitude);
    var pos = new google.maps.LatLng(1.2979327, 103.8467304);

        marker = new google.maps.Marker({
              position : pos,
              map: map,
              title:'SMU SOE'
        });
        var marker1 = new google.maps.Marker({
              position : node,
              map: map,
              title:'Dhoby Ghaut MRT'
        });
        var bounds = new google.maps.LatLngBounds();
        bounds.extend(marker.getPosition());
        bounds.extend(marker1.getPosition());
        map.fitBounds(bounds);
        calcRoute(pos,node);
        
    }

google.maps.event.addDomListener(window, 'load', initialize);
function calcRoute(pos,node) {
var directionsService = new google.maps.DirectionsService();
  var request = {
      origin:pos,
      destination:node,
      travelMode: google.maps.DirectionsTravelMode.WALKING
  };

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    } else { alert("Directions failed: "+status); }
  });
}

        function startTime() {
            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('timeNow').innerHTML =
                    h + ":" + m + ":" + s;
            var t = setTimeout(startTime, 500);
        }
        function checkTime(i) {
            if (i < 10) {
                i = "0" + i
            }
            ;  // add zero in front of numbers < 10
            return i;
        }
        function getFormattedDate() {
            var todayTime = new Date();
            var month = todayTime.getMonth() + 1;
            var day = todayTime.getDate();
            var year = todayTime.getFullYear();
            document.getElementById('todayDate').innerHTML =
                    day + "/" + month + "/" + year;
        }
        
        
        function getPatientLocation() {
            var deferred = $.Deferred();
            sendInfo();
            var latlng = getInfo();
            setTimeout(function(){
                deferred.resolve(latlng);
            },5000);
            return deferred.promise();
        }
        

            function sendInfo()
            {
//var v=document.vinform.t1.value;
                var url = "processGetPatientLocation.jsp?val=" +<%out.println(patient_id);%>;

                if (window.XMLHttpRequest) {
                    request = new XMLHttpRequest();
                }
                else if (window.ActiveXObject) {
                    request = new ActiveXObject("Microsoft.XMLHTTP");
                }

                try {
                    request.onreadystatechange = getInfo;
                    request.open("GET", url, true);
                    request.send();
                } catch (e) {
                    alert("Unable to connect to server");
                }
            }

            function getInfo() {
                if (request.readyState === 4) {
                    var val = request.responseText;
                    latitude = val.substring(0, val.indexOf(","));
                    longtitude = val.substring(val.indexOf(",") + 1);
//document.getElementById('amit').innerHTML=latitude+" " + longtitude;
//document.getElementById('brandon').innerHTML=latitude+" " + longtitude;
                    return latitude+","+longtitude;

                    //myMap(latitude, longtitude);
                }
            }
</script>
   </head>
   <body>
       <nav class="navbar navbar-custom">
            <div class="container-fluid">
                <div class="navbar-header">
                    <!--      <a class="navbar-brand" href="#">Memory Web</a>-->
                    <bold><h2 id="timeNow"></h2></bold></a>
                    <h6 id="todayDate"></h6>
                </div>

            </div>
        </nav>
     <div id="map" style="height: 400px; width:500px;"></div>
     <div id="info"></div>


   </body>
 </html>
