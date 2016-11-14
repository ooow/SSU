import org.json.JSONObject;

import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Created by Гога on 12.10.2016.
 */
public class Main {

    public static void main(String[] args) throws Exception {
        SiteParser st = new SiteParser(5000);
        ArrayList<JSONObject> items = st.getItems();

        PrintWriter pw = new PrintWriter("storage.txt");

        for (int i = 0; i < items.size(); i++) {
            pw.println(items.get(i).toString());
        }
        pw.close();
    }
}
