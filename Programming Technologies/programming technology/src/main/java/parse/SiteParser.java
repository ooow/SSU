package parse;

import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

public class SiteParser {
    private final static String site = "http://gidonline.club/page/";

    public static ArrayList<Document> parse(int count) {
        ArrayList<Document> films = new ArrayList<>();
        try {
            int page = 1;
            URL url = new URL(site + page + "/");
            BufferedReader reader = new BufferedReader(new InputStreamReader(url.openConnection().getInputStream(), "UTF-8"));
            while (films.size() < count) {
                String line = reader.readLine();
                if (line == null)
                    break;
                if (line.indexOf("mainlink") != -1) {
                    Document film = new Document();
                    String href = line.substring(line.indexOf("href=\"") + 6, line.indexOf("itemscope") - 2);
                    String img = "http://gidonline.club" + line.substring(line.indexOf("src=\"") + 5, line.indexOf("alt=") - 2);
                    String name = line.substring(line.indexOf("=\"name\">") + 8, line.indexOf("</span>"));
                    String rating = line.substring(line.indexOf("ratingValue\" content") + 22, line.indexOf("ratingValue\" content") + 26);
                    //System.out.println(name + "\t" + rating + "\t" + img + "\t" + href);
                    film.add(new TextField("name", name, Field.Store.YES));
                    film.add(new TextField("rating", rating, Field.Store.YES));
                    film.add(new TextField("img", img, Field.Store.YES));
                    film.add(new TextField("href", href, Field.Store.YES));
                    films.add(film);
                    reader.readLine();
                }
                if (line.indexOf("nextpostslink") != -1) {
                    System.out.println("    Обработанно страниц: " + page);
                    page++;
                    url = new URL(site + page + "/");
                    reader = new BufferedReader(new InputStreamReader(url.openConnection().getInputStream(), "UTF-8"));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return films;
    }
}