/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Event;
import entity.Patient;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.joda.time.DateTime;

/**
 *
 * @author ASUS
 */
public class PatientDAO {
    private static final String TBLNAME = "patient";
    
    public Patient getPatient(int patient_id){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        Patient patient = null;

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT * from patient WHERE patient_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patient_id);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                int patientid = rs.getInt("patient_id");
                String patient_name = rs.getString("patient_name");
                int patient_age = rs.getInt("patient_age");
         
                patient = new Patient(patient_id, patient_name, patient_age);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return patient;
    }
    
    public ArrayList<Patient> getAllPatients(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        ArrayList<Patient> patientList = new ArrayList<Patient>();

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT * from patient";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                int patient_id = rs.getInt("patient_id");
                String patient_name = rs.getString("patient_name");
                int patient_age = rs.getInt("patient_age");
                Patient patient = new Patient(patient_id, patient_name, patient_age);
                patientList.add(patient);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return patientList;
    }
}
