import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Created by goga on 12.10.16.
 */
public class Main {

    public static void main(String[] args) throws IOException {
        SiteParser st = new SiteParser(5000);
        ArrayList<JSONObject> items = st.getItems();

        String pathToData = "/Users/goga/IdeaProjects/Programming Technologies/LuceneLab/Data Storage/";
        String name = "data";
        for (int i = 0; i < items.size(); i++) {
            String newFileName = pathToData + name + i + ".txt";
            File file = new File(newFileName);
            PrintWriter pw = new PrintWriter(file);
            pw.print(items.get(i).toString());
            pw.close();
        }
    }
}
