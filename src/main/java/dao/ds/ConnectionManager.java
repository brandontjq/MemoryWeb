package dao.ds;
import io.deepstream.*;

public class ConnectionManager {
    private DeepstreamClient client = null;

    public ConnectionManager() {
        if (client == null) {
            try {
                client = new DeepstreamClient("192.168.1.100:6020");
                client.login();
            } catch (Exception e) {}
        }
    }

    public DeepstreamClient getClient() {
        return client;
    }
}
