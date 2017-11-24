/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import org.joda.time.DateTime;

/**
 *
 * @author ASUS
 */
public class Event {
    private int event_id;
    private int patient_id;
    private String event_name;
    private String event_description;
    private int location_id;
    private String location;
    private double event_lat;
    private double event_lng;
    private DateTime event_start_time;
    private DateTime event_end_time;
    private boolean completed;
    private boolean reminded;
    
    public Event(int event_id, int patient_id, String event_name, String event_description, String location, double event_lat, double event_lng,
            DateTime event_start_time, DateTime event_end_time){
        this.event_id = event_id;
        this.patient_id = patient_id;
        this.event_name = event_name;
        this.event_description = event_description;
        this.location = location;
        this.event_lat = event_lat;
        this.event_lng = event_lng;
        this.event_start_time = event_start_time;
        this.event_end_time = event_end_time;
        this.completed = false;
    }
    public Event(int event_id, int patient_id, String event_name, String event_description, String location,
            DateTime event_start_time, DateTime event_end_time, boolean completed, boolean reminded){
        
        this.event_id = event_id;
        this.patient_id = patient_id;
        this.event_name = event_name;
        this.event_description = event_description;
        this.location = location;
        this.event_start_time = event_start_time;
        this.event_end_time = event_end_time;
        this.completed = completed;
        this.reminded = reminded;
    }
    
    public Event(int event_id, int patient_id, String event_name, String event_description, String location,double event_lat, double event_lng,
            DateTime event_start_time, DateTime event_end_time, boolean completed, boolean reminded){
        
        this.event_id = event_id;
        this.patient_id = patient_id;
        this.event_name = event_name;
        this.event_description = event_description;
        this.location = location;
        this.event_lat = event_lat;
        this.event_lng = event_lng;
        this.event_start_time = event_start_time;
        this.event_end_time = event_end_time;
        this.completed = completed;
        this.reminded = reminded;
    }
    public boolean get_reminded(){
        return reminded;
    }
    public void set_reminded(boolean reminded){
        this.reminded = reminded;
    }
    public double getEvent_lat(){
        return event_lat;
    }
    public double getEvent_lng(){
        return event_lng;
    }
    /**
     * @return the event_id
     */
    public int getEvent_id() {
        return event_id;
    }
    
    public String getLocation(){
        return location;
    }
    /**
     * @param event_id the event_id to set
     */
    public void setEvent_id(int event_id) {
        this.event_id = event_id;
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
     * @return the event_name
     */
    public String getEvent_name() {
        return event_name;
    }

    /**
     * @param event_name the event_name to set
     */
    public void setEvent_name(String event_name) {
        this.event_name = event_name;
    }

    /**
     * @return the event_description
     */
    public String getEvent_description() {
        return event_description;
    }

    /**
     * @param event_description the event_description to set
     */
    public void setEvent_description(String event_description) {
        this.event_description = event_description;
    }

    /**
     * @return the location_id
     */
    public int getLocation_id() {
        return location_id;
    }

    /**
     * @param location_id the location_id to set
     */
    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    /**
     * @return the event_start_time
     */
    public DateTime getEvent_start_time() {
        return event_start_time;
    }

    /**
     * @param event_start_time the event_start_time to set
     */
    public void setEvent_start_time(DateTime event_start_time) {
        this.event_start_time = event_start_time;
    }

    /**
     * @return the event_end_time
     */
    public DateTime getEvent_end_time() {
        return event_end_time;
    }

    /**
     * @param event_end_time the event_end_time to set
     */
    public void setEvent_end_time(DateTime event_end_time) {
        this.event_end_time = event_end_time;
    }

    /**
     * @return the completed
     */
    public boolean isCompleted() {
        return completed;
    }

    /**
     * @param completed the completed to set
     */
    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
    
    
}
