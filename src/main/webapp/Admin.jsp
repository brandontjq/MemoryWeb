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
            }

        </script>
        <style>
        .container {
            height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
        }
        </style>
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
        
        <!-- Page Content -->
        <div class="container">

            <!-- Page Heading -->
            
            
            <!-- Project One -->
            <div class="col-lg-7">
<!--            <div class="row">-->
                <h2><bold>Your Care Receivers</bold></h2>
                <table class="table table-hover">
                <%
                    PatientDAO patientDAO = new PatientDAO();
                    ArrayList<Patient> patients = patientDAO.getAllPatients();
                    DateTime dateTimeToday = new DateTime();
                    for(int i = 0; i < patients.size(); i++){
                        Patient patient = patients.get(i);
                        int patient_id = patient.getPatient_id();
                        %>
                            <tr>
                            <td>
                                <h4><p>Name: <%out.println(patient.getPatient_name());%></p></h4>
                            <h4><p>Age: <%out.println(patient.getPatient_age());%></p></h4>
                            </td>
                            <td>
                            <form action="index.jsp" method="POST">
                                <input type="hidden" name="patient_id" id="patient_id" value="<%out.println(patient_id);%>">
                                <button type="submit" class="btn btn-primary pull-right">See schedule</button>
                            </form>
                             
                            </td>
                        </tr>
                        
                    <%
                    }
            
                    
                %>
                </table>
                
            </div>
<!--                <div class="col-md-7">
                    <div class="span7 pull-right">
                        <a href="#">
                                        <img class="img-fluid rounded mb-3 mb-md-0" src="http://placehold.it/700x300" alt="">
                            <div id="map" style="width:500px;height:400px;"></div>
                            
                            Google Maps Plugin 
                            TO DO: dynamically update user location on google maps 
                            <script>
                                function myMap() {
                                    var latAndLng = {lat: 1.2973589, lng: 103.8495542};
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
                            </script>

                            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBI6Iec_nY-mLau6ibtA3FhKAa5B3nP2aA&callback=myMap"></script>
                        </a>
                    </div>
                </div>-->
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