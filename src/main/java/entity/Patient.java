/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author ASUS
 */
public class Patient {
    private int patient_id;
    private String patient_name;
    private int patient_age;
    
    public Patient(int patient_id, String patient_name, int patient_age){
        this.patient_id = patient_id;
        this.patient_name = patient_name;
        this.patient_age = patient_age;
    }

    /**
     * @return the patient_id
     */
    public int getPatient_id() {
        return patient_id;
    }

    /**
     * @param patient_id the patient_id to set
     */
    public void setPatient_id(int patient_id) {
        this.patient_id = patient_id;
    }

    /**
     * @return the patient_name
     */
    public String getPatient_name() {
        return patient_name;
    }

    /**
     * @param patient_name the patient_name to set
     */
    public void setPatient_name(String patient_name) {
        this.patient_name = patient_name;
    }

    /**
     * @return the patient_age
     */
    public int getPatient_age() {
        return patient_age;
    }

    /**
     * @param patient_age the patient_age to set
     */
    public void setPatient_age(int patient_age) {
        this.patient_age = patient_age;
    }
    
    
}
