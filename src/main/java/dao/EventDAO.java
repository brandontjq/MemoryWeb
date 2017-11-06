/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dao.ConnectionManager;
import entity.Event;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import org.joda.time.DateTime;

/**
 *
 * @author ASUS
 */
public class EventDAO {

    private static final String TBLNAME = "event";

    public void saveEvent(Event event) {
        PreparedStatement stmt = null;
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();

            String query = "INSERT INTO " + TBLNAME + " (event_id, patient_id, event_name,event_description,event_location, event_lat, event_lng, event_start_time, event_end_time,completed) VALUES (?,?,?,?,?,?,?,?,?,?);";

            stmt = conn.prepareStatement(query);

            stmt.setInt(1, event.getEvent_id());
            stmt.setInt(2, event.getPatient_id());
            stmt.setString(3, event.getEvent_name());
            stmt.setString(4, event.getEvent_description());
            stmt.setString(5, event.getLocation());
            stmt.setDouble(6, event.getEvent_lat());
            stmt.setDouble(7, event.getEvent_lng());
            stmt.setTimestamp(8, new java.sql.Timestamp(event.getEvent_start_time().getMillis()));
            stmt.setTimestamp(9, new java.sql.Timestamp(event.getEvent_end_time().getMillis()));
            stmt.setBoolean(10, false);

            stmt.executeUpdate();
            //conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(stmt);
        }
    }
    
    
    public void updateEvent(Event event){
        PreparedStatement stmt = null;
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();

            String query = "UPDATE " + TBLNAME + " SET patient_id = ?, event_name = ?,event_description =?,event_location = ?, event_lat = ?, event_lng = ?, event_start_time = ?, event_end_time = ?, completed = ? WHERE event_id = ?;";

            stmt = conn.prepareStatement(query);

            
            stmt.setInt(1, event.getPatient_id());
            stmt.setString(2, event.getEvent_name());
            stmt.setString(3, event.getEvent_description());
            stmt.setString(4, event.getLocation());
            stmt.setDouble(5, event.getEvent_lat());
            stmt.setDouble(6, event.getEvent_lng());
            stmt.setTimestamp(7, new java.sql.Timestamp(event.getEvent_start_time().getMillis()));
            stmt.setTimestamp(8, new java.sql.Timestamp(event.getEvent_end_time().getMillis()));
            stmt.setBoolean(9, false);
            stmt.setInt(10, event.getEvent_id());
            stmt.executeUpdate();
            //conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(stmt);
        }
    }
    
    public ArrayList<Event> getAllEvents(int patient_id){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        ArrayList<Event> events = new ArrayList<Event>();

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT * FROM event WHERE patient_id = ? ORDER BY event_start_time asc;";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patient_id);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int event_id = rs.getInt("event_id");
                int patientid = rs.getInt("patient_id");
                String event_name = rs.getString("event_name");
                String event_description = rs.getString("event_description");
                String event_location = rs.getString("event_location");
                DateTime event_start_time = new DateTime(rs.getTimestamp("event_start_time").getTime());
                DateTime event_end_time = new DateTime(rs.getTimestamp("event_end_time").getTime());
                boolean completed = rs.getBoolean("completed");
                Event eventTemp = new Event(event_id, patient_id, event_name, event_description, event_location, event_start_time,
                                                event_end_time, completed);
                events.add(eventTemp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return events;
    }
    
    public int getNumEvents(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        int numEvents = 0;

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT count(*) AS count FROM event;";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                numEvents = rs.getInt("count");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return numEvents;
    }
    
    public Event getEvent(int event_id){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        Event event = null;

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT * from event WHERE event_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, event_id);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int eventID = rs.getInt("event_id");
                int patient_id = rs.getInt("patient_id");
                String event_name = rs.getString("event_name");
                String event_description = rs.getString("event_description");
                String event_location = rs.getString("event_location");
                DateTime event_start_time = new DateTime(rs.getTimestamp("event_start_time").getTime());
                DateTime event_end_time = new DateTime(rs.getTimestamp("event_end_time").getTime());
                boolean completed = rs.getBoolean("completed");
                event = new Event(event_id, patient_id, event_name, event_description, event_location, event_start_time,
                                                event_end_time, completed);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return event;
    }
}
