package dao.ds;

import entity.Event;
import io.deepstream.*;
import com.google.gson.JsonObject;

public class EventDAO {
    public static final String REC_NAME = "event";

    public void saveEvent(Event event) {
        DeepstreamClient client = new ConnectionManager().getClient();
        JsonObject data = new JsonObject();
        data.addProperty("id", event.getEvent_id());
        data.addProperty("patientId", event.getPatient_id());
        data.addProperty("name", event.getEvent_name());
        data.addProperty("description", event.getEvent_description());
        data.addProperty("location", event.getLocation());
        data.addProperty("latitude", event.getEvent_lat());
        data.addProperty("longitude", event.getEvent_lng());
        data.addProperty("startTime", event.getEvent_start_time().getMillis());
        data.addProperty("endTime", event.getEvent_end_time().getMillis());
        data.addProperty("completed", false);

        String recordName = REC_NAME + "/" + event.getEvent_id();
        Record record = client.record.getRecord(recordName);
        record.set(data);

        List list = client.record.getList("events/" + event.getPatient_id());
        list.addEntry(recordName);
    }
}
