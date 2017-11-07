<%@page import="entity.Patient"%>
<%@page import="dao.PatientDAO"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="org.joda.time.format.DateTimeFormat"%>
<%@page import="entity.Event"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.EventDAO"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Memory Web</title>

        <!--     Bootstrap core CSS -->
        <!--    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        
             Custom styles for this template 
            <link href="css/1-col-portfolio.css" rel="stylesheet">-->


        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

        <!--         Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

        <!--         Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/memorywebcss.css" rel="stylesheet">
        <%
            String patient_id_str = request.getParameter("patient_id");
            int patient_id = (int) Double.parseDouble(patient_id_str);
            PatientDAO patientDAO = new PatientDAO();
            Patient patient = patientDAO.getPatient(patient_id);

        %>
        <script>
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
            function start() {
                startTime();
                getFormattedDate();
                initialiseMap();
            }
            var request;
            var latitude;
            var longitude;

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

                    myMap(latitude, longtitude);
                }
            }
            function myMap(latitude, longtitude) {
                var latAndLng = {lat: parseFloat(latitude), lng: parseFloat(longtitude)};
                var mapOptions = {
                    center: latAndLng,
                    zoom: 18,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                }
                var map = new google.maps.Map(document.getElementById("map"), mapOptions);
                var marker = new google.maps.Marker({
                    position: latAndLng,
                    map: map
                });
            }
            //Query DB every N seconds
            //setInterval(sendInfo, 2000);
        </script>
    </head>

    <body onLoad="start()">
        <nav class="navbar navbar-custom">
            <div class="container-fluid">
                <div class="navbar-header">
                    <!--      <a class="navbar-brand" href="#">Memory Web</a>-->
                    <h2 id="timeNow"></h2>
                    <h6 id="todayDate"></h6>
                </div>
                <!--                <ul class="nav pull-right">
                                      <li><a href="#"><img src="img/memorywatchlogo.jpg" width="150" height="60"></a></li>
                                </ul>-->
            </div>
        </nav>  

        <!--        <form name="vinform">  
                    <input type="hidden" name="t1" value="<%out.println(patient_id);%>">
                </form>-->
        <!-- Page Content -->
        <div class="container">

            <!-- Page Heading -->
            <h3 class='my-4'><bold>Today's Events(s) for <%out.println(patient.getPatient_name());%></bold></h3><br/>

            <!-- Project One -->
            <div class="col-md-5">
                <!--            <div class="row">-->
                <form action="AddEvent.jsp" method="POST">
                    <input type="hidden" name="patient_id" id="patient_id" value="<%out.println(patient_id);%>">
                    <button type="submit" class="btn btn-primary pull-left">Add an Event</button>
                </form><br/><br/>
                <table class="table table-hover">
                    <!--                <a href="AddEvent.jsp" class="btn btn-primary pull-left">Add an Event</a><br/><br/>-->

                    <%
                        EventDAO eventDAO = new EventDAO();
                        ArrayList<Event> events = eventDAO.getAllEvents(patient_id);
                        DateTime dateTimeToday = new DateTime();
                        for (int i = 0; i < events.size(); i++) {
                            Event event = events.get(i);
                            int event_id = event.getEvent_id();
                    %>
                    <%
                        if (dateTimeToday.withTimeAtStartOfDay().equals(event.getEvent_start_time().withTimeAtStartOfDay())) {
                    %>
                    <tr>
                        <td>
                            <h3><%out.println(event.getEvent_name());%></h3>
                            <p><%out.println(event.getEvent_description());%></p>
                            <p>Start: <%out.println(event.getEvent_start_time().toString(DateTimeFormat.forPattern("HH:mm")));%> End: <%out.println(event.getEvent_end_time().toString(DateTimeFormat.forPattern("HH:mm")));%> </p>
                            <p><%out.println("<i>" + event.getLocation() + "</i>");%></p>
                            <form action="ModifyEvent.jsp" method="POST">
                                <input type="hidden" name="event_id" id="event_id" value="<%out.println(event_id);%>">
                                <input type="hidden" name="patient_id" id="patient_id" value="<%out.println(patient_id);%>">
                                <!--                            <a class="btn btn-primary" href="ModifyEvent.jsp">Modify</a>-->
                                <button type="submit" class="btn btn-default pull-left">Modify</button>
                            </form>
                        </td>
                    </tr>
                    <%}

                    %>

                    <%                        }


                    %>
                </table>

            </div>
            <div class="col-md-7">
                <div class="span7 pull-right">
                    <a href="#">
                        <!--            <img class="img-fluid rounded mb-3 mb-md-0" src="http://placehold.it/700x300" alt="">-->
                        <div id="map" style="width:500px;height:400px;"></div>

                        <!--Google Maps Plugin -->
                        <!--TO DO: dynamically update user location on google maps -->
                        <script>
//                                function myMap() {
//                                    var latAndLng = {lat: 1.2973589, lng: 103.8495542};
//                                    var mapOptions = {
//                                        center: latAndLng,
//                                        zoom: 18,
//                                        mapTypeId: google.maps.MapTypeId.ROADMAP
//                                    }
//                                    var map = new google.maps.Map(document.getElementById("map"), mapOptions);
//                                    var marker = new google.maps.Marker({
//                                        position: latAndLng,
//                                        map: map
//                                    });
//                                }
                        </script>
                        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBI6Iec_nY-mLau6ibtA3FhKAa5B3nP2aA&callback=myMap"></script>
                      
                    </a>
                </div>
            </div>
        </div>
        <!-- /.row -->

        <hr>

        <!-- Project Two -->
        <!--      <div class="row">
                <div class="col-md-7">
                  <a href="#">
                    <img class="img-fluid rounded mb-3 mb-md-0" src="http://placehold.it/700x300" alt="">
                  </a>
                </div>
                <div class="col-md-5">
                  <h3>Project Two</h3>
                  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut, odit velit cumque vero doloremque repellendus distinctio maiores rem expedita a nam vitae modi quidem similique ducimus! Velit, esse totam tempore.</p>
                  <a class="btn btn-primary" href="#">View Project</a>
                </div>
              </div>
               /.row 
        
              <hr>
        
               Project Three 
              <div class="row">
                <div class="col-md-7">
                  <a href="#">
                    <img class="img-fluid rounded mb-3 mb-md-0" src="http://placehold.it/700x300" alt="">
                  </a>
                </div>
                <div class="col-md-5">
                  <h3>Project Three</h3>
                  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, temporibus, dolores, at, praesentium ut unde repudiandae voluptatum sit ab debitis suscipit fugiat natus velit excepturi amet commodi deleniti alias possimus!</p>
                  <a class="btn btn-primary" href="#">View Project</a>
                </div>
              </div>
               /.row 
        
              <hr>
        
               Project Four 
              <div class="row">
        
                <div class="col-md-7">
                  <a href="#">
                    <img class="img-fluid rounded mb-3 mb-md-0" src="http://placehold.it/700x300" alt="">
                  </a>
                </div>
                <div class="col-md-5">
                  <h3>Project Four</h3>
                  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, quidem, consectetur, officia rem officiis illum aliquam perspiciatis aspernatur quod modi hic nemo qui soluta aut eius fugit quam in suscipit?</p>
                  <a class="btn btn-primary" href="#">View Project</a>
                </div>
              </div>
               /.row 
        
              <hr>-->

        <!-- Pagination -->
        <!--      <ul class="pagination justify-content-center">
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                    <span class="sr-only">Previous</span>
                  </a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">1</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">2</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">3</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                    <span class="sr-only">Next</span>
                  </a>
                </li>
              </ul>-->

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
        <div class="container">
            <p class="m-0 text-center text-white">Copyright &copy; Memory Web</p>
        </div>
        <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper/popper.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

</body>

</html>
