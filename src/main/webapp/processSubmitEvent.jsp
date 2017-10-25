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
    int event_id = 0;
    if(event_id_str != null && event_id_str.length() != 0){
        event_id = (int)Double.parseDouble(event_id_str);
    }
    ArrayList<String> inputParams = new ArrayList<String>();
    inputParams.add(startdate);
    inputParams.add(enddate);
    inputParams.add(eventname);
    inputParams.add(description);
    inputParams.add(location);
    
    out.println(startdate + " " + enddate + " " + description + " " + location + "event id" + event_id);
    EventDAO eventDAO = new EventDAO();
    if(event_id != 0){
        Event event = new Event(event_id,1,eventname, description, location, DateTime.parse(startdate, 
                  DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")), DateTime.parse(enddate, 
                  DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")));
        eventDAO.updateEvent(event);
    } else {
        Event event = new Event(eventDAO.getNumEvents() + 1,1,eventname, description, location, DateTime.parse(startdate, 
                      DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")), DateTime.parse(enddate, 
                      DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")));
        eventDAO.saveEvent(event);
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