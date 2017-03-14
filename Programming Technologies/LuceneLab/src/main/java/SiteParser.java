import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

/**
 * Created by goga on 12.10.16.
 */
public class SiteParser {
    private String site = "https://www.avito.ru";
    private ArrayList<JSONObject> items = new ArrayList<JSONObject>();
    private int count;

    public SiteParser(int coint) throws IOException {
        this.count = coint;
        parse();
    }

    public void parse() {
        try {
            URL url = new URL(site + "/saratovskaya_oblast/avtomobili");
            BufferedReader reader = new BufferedReader(new InputStreamReader(url.openConnection().getInputStream(), "UTF-8"));
            int i = 1;
            while (true) {
                String line = reader.readLine();
                if (line == null || items.size() == count)
                    break;
                if (line.indexOf("<h3 class=\"title item-description-title\">") != -1) {
                    JSONObject item = new JSONObject();
                    line = reader.readLine().substring(1);
                    item.put("title", line);
                    //System.out.println(line);
                    reader.readLine();
                    line = reader.readLine();
                    if (line.indexOf("about") != -1) {
                        line = reader.readLine();
                        item.put("price", line.substring(2, 17));
                        //System.out.println(line.substring(2, 17));
                        line = reader.readLine();
                        if (line.indexOf("params") != -1)
                            line = reader.readLine();
                        line = line.substring(line.indexOf("param") + 7, line.length() - 7);
                        line = line.replace("&nbsp", "");
                        line = line.replace("<span class=\"c-8\">Битый</span>", "Битый");
                        item.put("param", line);
                        //System.out.println(line);
                        items.add(item);
                    }
                }
                if (line.indexOf("pagination-page js-pagination-next") != -1) {
                    line = line.substring(line.indexOf("pagination-page js-pagination-next") + 42, line.length() - 2);
                    System.out.println("Обработанно страниц: " + i);
                    url = new URL(site + line);
                    reader = new BufferedReader(new InputStreamReader(url.openConnection().getInputStream(), "UTF-8"));
                    i++;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<JSONObject> getItems() {
        return items;
    }
}
