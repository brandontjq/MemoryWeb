<%@page import="org.joda.time.format.DateTimeFormat"%>
<%@page import="entity.Event"%>
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
        <script src="Scripts/jquery-3.2.1.min.js"></script>
        <script src="Scripts/moment.js"></script>
        <script src="Scripts/bootstrap.min.js"></script>
        <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBI6Iec_nY-mLau6ibtA3FhKAa5B3nP2aA&libraries=places&callback=init"
        async defer></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
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
            function validateForm() {
            var startdate = document.forms["eventForm"]["startdate"].value;
            var enddate = document.forms["eventForm"]["enddate"].value;
            var eventname = document.forms["eventForm"]["eventname"].value;
            var description = document.forms["eventForm"]["description"].value;
            var location = document.forms["eventForm"]["location"].value;
            
            var start_date_parts = startdate.split("/").join(',').split(" ").join(",").split(":").join(",").split(",");
            var start_date_day = start_date_parts[0];
            var start_date_month = start_date_parts[1];
            var start_date_year = start_date_parts[2];
            var start_date_hour = start_date_parts[3];
            var start_date_minutes = start_date_parts[4];
            var start_date = new Date();
            start_date.setDate(start_date_day);
            start_date.setMonth(start_date_month-1);
            start_date.setYear(start_date_year);
            start_date.setHours(start_date_hour);
            start_date.setMinutes(start_date_minutes);
            
            var end_date_parts = enddate.split("/").join(',').split(" ").join(",").split(":").join(",").split(",");
            var end_date_day = end_date_parts[0];
            var end_date_month = end_date_parts[1];
            var end_date_year = end_date_parts[2];
            var end_date_hour = end_date_parts[3];
            var end_date_minutes = end_date_parts[4];
            var end_date = new Date();
            end_date.setDate(end_date_day);
            end_date.setMonth(end_date_month-1);
            end_date.setYear(end_date_year);
            end_date.setHours(end_date_hour);
            end_date.setMinutes(end_date_minutes);
            if (startdate == "" || enddate == "" || eventname == "" || description == "" || location == "") {
                alert("Please fill in all fields.");
                return false;
            }
            if(end_date <= start_date){
                alert("Please enter end date after start date");
                return false;
            }
        
}   

        </script>
        <script>
            $(function () {
                $('#startdate,#enddate').datetimepicker({
                    minDate: moment(),
                    useCurrent: false,
                    format: 'dd/mm/yyyy h:ii',
                    pick12HourFormat: false,
                    autoclose: true,
                });
                $('#startdate').datetimepicker().on('dp.change', function (e) {
                    var incrementDay = moment(new Date(e.date));
                    incrementDay.add(1, 'days');
                    $('#enddate').data('DateTimePicker').minDate(incrementDay);
                    $(this).data("DateTimePicker").hide();
                });

                $('#enddate').datetimepicker().on('dp.change', function (e) {
                    var decrementDay = moment(new Date(e.date));
                    decrementDay.subtract(1, 'days');
                    $('#startdate').data('DateTimePicker').maxDate(decrementDay);
                    $(this).data("DateTimePicker").hide();
                });
            });
        </script>

    </head>

    <body onLoad="start()">
        <%
            String event_id_str = request.getParameter("event_id");
            double event_id_double = 0;
            int event_id = 0;
            if (event_id_str != null) {
                event_id_double = Double.parseDouble(event_id_str);
                event_id = (int) event_id_double;
            }
            String patient_id_str = request.getParameter("patient_id");
            double patient_id_double = 0;
            int patient_id = 0;
            if (patient_id_str != null) {
                patient_id_double = Double.parseDouble(patient_id_str);
                patient_id = (int) patient_id_double;
            }
            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.getEvent(event_id);
        %>
        <!-- NAVBAR-->
        <nav class="navbar navbar-custom">
            <div class="container-fluid">
                <div class="navbar-header">
                    <!--      <a class="navbar-brand" href="#">Memory Web</a>-->
                    <bold><h2 id="timeNow"></h2></bold>
                    <h6 id="todayDate"></h6>
                </div>

            </div>
        </nav>

        <!-- Page Content -->
        <div class="container">

            <!-- Page Heading -->
            <h1 class="my-4"><bold>Modify Event</bold></h1>
            <br></br><br></br>
            <!-- Project One -->
            <div class="container">
                <form class="form-horizontal" name="eventForm" action="processSubmitEvent.jsp" onsubmit="return validateForm()" method="POST">
                    <div class="col-md-5">

                        <div class="container">
                            <div class="form-horizontal">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label">
                                                <label for="startdate" class="control-label">Start Date</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <div class="input-group date" id="startdate">
                                                    <input type="text" name="startdate" class="form-control" value="<%out.println(event.getEvent_start_time().toString(DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")));%>" readonly/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon-calendar glyphicon"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label">
                                                <label for="enddate">End Date</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <div class="input-group date" id="enddate">
                                                    <input type="text" name="enddate" class="form-control" value="<%out.println(event.getEvent_end_time().toString(DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")));%>" readonly/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon-calendar glyphicon"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!--End of Date Time -->

                    <div class="col-md-7">
                        <div class="span7">
                            <!--            <form class="form-horizontal"  action="processSubmitEvent.jsp">-->
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="eventname">Event Name</label>
                                <div class="col-sm-8">
                                    <input type="text" name="eventname" class="form-control input-lg" id="eventname" value="<%out.println(event.getEvent_name());%>" placeholder="Enter event name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="description">Description</label>
                                <div class="col-sm-8">
                                    <input type="text" name="description" class="form-control input-lg" id="description" value="<%out.println(event.getEvent_description());%>" placeholder="Enter descripton">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="location">Location</label>
                                <div class="col-sm-8"> 
                                    <input id="location" type="text" name="location" class="form-control input-lg" value="<%out.println(event.getLocation());%>" placeholder="Enter location">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-10">
                                    <input type="hidden" name="event_id" id="event_id" value="<%out.println(event_id);%>">
                                    <input type="hidden" name="patient_id" id="patient_id" value="<%out.println(patient_id);%>">
                                </div>
                            </div>    
                            <div class="form-group"> 
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-primary pull-right">Update</button>
                                </div>
                            </div>
                            </form>
                        </div>
                    </div>
            </div>
            <!-- /.row -->

            

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

        <script>
            //This script is for the suggestion of address in the location form field.
            function init(){
                var input = document.getElementById('location');
                var autocomplete = new google.maps.places.Autocomplete(input);
            }   
            //google.maps.event.addDomListener(window, 'load', init);    
        </script>
        
    </body>

</html>

