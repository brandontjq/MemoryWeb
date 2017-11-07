/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.jayway.jsonpath.JsonPath;
import java.util.HashMap;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

/**
 *
 * @author ASUS
 */
public class LocationDAO {

    private static final String GOOGLE_API_KEY = "AIzaSyBI6Iec_nY-mLau6ibtA3FhKAa5B3nP2aA";
    private static final String TBLNAME = "event_location";
    public ArrayList<Double> getLocationLatLng(String location) {
        HashMap<Double, Double> latLngMap = new HashMap<Double, Double>();
        ArrayList<Double> latLngResult = new ArrayList<Double>();
        try {

            DefaultHttpClient httpClient = new DefaultHttpClient();
            HttpGet getRequest = new HttpGet(
                    "https://maps.googleapis.com/maps/api/geocode/json?address="+location+"&key="+GOOGLE_API_KEY);
            getRequest.addHeader("accept", "application/json");

            HttpResponse response = httpClient.execute(getRequest);

            if (response.getStatusLine().getStatusCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + response.getStatusLine().getStatusCode());
            }

            BufferedReader br = new BufferedReader(
                    new InputStreamReader((response.getEntity().getContent())));

            String output;
            String json = "";
            System.out.println("Output from Server .... \n");
            while ((output = br.readLine()) != null) {
                json += output;
            }
            ArrayList<String> strTest = new ArrayList<String>();
            latLngMap = JsonPath.parse(json).read("$.results[0].geometry['location']");
            Iterator it = latLngMap.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry)it.next();
                //System.out.println(pair.getKey() + " = " + pair.getValue());
                latLngResult.add(Double.parseDouble(pair.getValue().toString()));
                it.remove(); // avoids a ConcurrentModificationException
            }
            httpClient.getConnectionManager().shutdown();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return latLngResult;
    }

    public void saveLocation(int patient_id, int event_id, double event_lat, double event_lng){
        PreparedStatement stmt = null;
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();

            String query = "INSERT INTO " + TBLNAME + " (patient_id, event_id, event_lat, event_lng) VALUES (?,?,?,?);";

            stmt = conn.prepareStatement(query);

            stmt.setInt(1, patient_id);
            stmt.setInt(2, event_id);
            stmt.setDouble(3, event_lat);
            stmt.setDouble(4, event_lng);
            

            stmt.executeUpdate();
            //conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(stmt);
        }
    }
    
    public void updateLocation(int patient_id, int event_id, double event_lat, double event_lng){
        PreparedStatement stmt = null;
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();

            String query = "UPDATE " + TBLNAME + " SET patient_id = ?, event_lat = ?, event_lng = ? WHERE event_id = ?;";

            stmt = conn.prepareStatement(query);

            
            stmt.setInt(1, patient_id);
            stmt.setDouble(2, event_lat);
            stmt.setDouble(3, event_lng);
            stmt.setInt(4, event_id);
            
            stmt.executeUpdate();
            //conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(stmt);
        }
    }
    
    public String getUserLocation(int patient_id){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        String result = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT * from patient_location WHERE patient_id = ? order by patient_timestamp desc limit 1";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patient_id);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                double patient_lat = rs.getDouble("patient_lat");
                double patient_lng = rs.getDouble("patient_lng");
                result += patient_lat + "," + patient_lng;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return result;
    }

}
