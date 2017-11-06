<%@page import="dao.LocationDAO"%>
<%@page import="java.util.Locale"%>
<%@page import="org.joda.time.format.DateTimeFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="entity.Event"%>
<%@page import="dao.EventDAO"%>
<%@page import="java.util.ArrayList"%>
<%
    String startdate = request.getParameter("startdate");
    String enddate = request.getParameter("enddate");
    String eventname = request.getParameter("eventname");
    String description = request.getParameter("description");
    String location = request.getParameter("location");
    String event_id_str = request.getParameter("event_id");
    String patient_id_str = request.getParameter("patient_id");
    int event_id = 0;
    if(event_id_str != null && event_id_str.length() != 0){
        event_id = (int)Double.parseDouble(event_id_str);
    }
    int patient_id = 0;
    if(patient_id_str != null && patient_id_str.length() != 0){
        patient_id = (int)Double.parseDouble(patient_id_str);
    }
    ArrayList<String> inputParams = new ArrayList<String>();
    inputParams.add(startdate);
    inputParams.add(enddate);
    inputParams.add(eventname);
    inputParams.add(description);
    inputParams.add(location);
    
    out.println(startdate + " " + enddate + " " + description + " " + location + "event id" + event_id);
    EventDAO eventDAO = new EventDAO();
    LocationDAO locationDAO = new LocationDAO();
    ArrayList<Double> latLng = locationDAO.getLocationLatLng(location.replaceAll("\\s","+"));
    if(event_id != 0){ //Modify Event
        Event event = new Event(event_id,patient_id,eventname, description, location,latLng.get(0), latLng.get(1), DateTime.parse(startdate, 
                  DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")), DateTime.parse(enddate, 
                  DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")));
        eventDAO.updateEvent(event);
        locationDAO.updateLocation(patient_id, event_id, latLng.get(0), latLng.get(1));
    } else { //Add Event
        int event_id_updated = eventDAO.getNumEvents() + 1;
        Event event = new Event(event_id_updated,patient_id,eventname, description, location, latLng.get(0), latLng.get(1), DateTime.parse(startdate, 
                      DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")), DateTime.parse(enddate, 
                      DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")));
        eventDAO.saveEvent(event);
        locationDAO.saveLocation(patient_id, event_id_updated, latLng.get(0), latLng.get(1));
    }
    response.sendRedirect(""); 
%>

<%!
    //Simple validation to check for empty form fields
    public boolean checkEmpty(ArrayList<String> inputParams){
        for(int i = 0; i < inputParams.size(); i++ ){
            String input = inputParams.get(i);
            if(input.length() == 0){
                return true;
            }
        }
        return false;
    }
    
    
%>