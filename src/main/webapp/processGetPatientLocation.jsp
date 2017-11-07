

<%@page import="dao.LocationDAO"%>
<%@page import="java.util.ArrayList"%>
<%
    String s = request.getParameter("val");
    if (s == null || s.trim().equals("")) {
        LocationDAO locationDAO = new LocationDAO();
//        ArrayList<Double> latLngList = locationDAO.getLocationLatLng("Singapore+Management+University+Singapore");
//        for(int i = 0; i < latLngList.size(); i++){
//            out.println(latLngList.get(i));
//        }
        //String result = locationDAO.getUserLocation(1);
        //out.println(result);
    } else {
        int id = Integer.parseInt(s);
        //out.print(id);
        LocationDAO locationDAO = new LocationDAO();
//        ArrayList<Double> latLngList = locationDAO.getLocationLatLng("Nanyang+Technological+University+Singapore");
//        for(int i = 0; i < latLngList.size(); i++){
//            out.println(latLngList.get(i));
//        }
        String result = locationDAO.getUserLocation(id);
        out.println(result);
    }

%>  