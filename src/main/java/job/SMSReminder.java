/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package job;

import dao.EmailService;
import dao.EventDAO;
import entity.Event;
import java.util.ArrayList;
import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author ASUS
 */
public class SMSReminder implements org.quartz.Job{
    public SMSReminder(){
    }
    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        System.out.println("Reminder Job Running...");
        EventDAO eventDAO = new EventDAO();
        EmailService emailService = new EmailService();
            ArrayList<Event> events = eventDAO.getAllEvents();
            DateTime dateTimeToday = new DateTime();
            for (int i = 0; i < events.size(); i++) {
                Event event = events.get(i);
                int event_id = event.getEvent_id();
                if (dateTimeToday.withTimeAtStartOfDay().equals(event.getEvent_start_time().withTimeAtStartOfDay()) && event.get_reminded() == false) {
                    Minutes diff = Minutes.minutesBetween(dateTimeToday,event.getEvent_start_time());
                    if(diff.getMinutes() <= 10){
                        emailService.sendEmail(event);
                        event.set_reminded(true);
                        eventDAO.updateEvent(event);
                        System.out.println("Sending email...");
                    }
                    
                }
            }
        
    }
    
}
