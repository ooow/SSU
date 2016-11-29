package lucene.search;

import org.apache.lucene.document.Document;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.json.JSONObject;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * Created by goga on 07.11.16.
 */
public class LuceneSearch {
    private final String indexDir = "index";
    private Indexer indexer;
    private Searcher searcher;

    public void createIndex() throws IOException {
        System.out.println("Начало индексации..");
        indexer = new Indexer(indexDir);
        int numIndexed;
        long startTime = System.currentTimeMillis();
        numIndexed = indexer.createIndex();
        long endTime = System.currentTimeMillis();
        indexer.close();
        System.out.println("Кол-во элементов: " + numIndexed + "\nВремя индексации: " + (endTime - startTime) + " мс");
    }

    public void search(String searchQuery, String dir, String... selections) throws IOException, ParseException {
        searcher = new Searcher(dir);
        long startTime = System.currentTimeMillis();


        TopDocs hits = searcher.search(searchQuery, selections);
        long endTime = System.currentTimeMillis();

        System.out.println("Найдено " + hits.totalHits + " докупентов с запросом - \"" + searchQuery + "\". Время поиска: " + (endTime - startTime) + " мс");

        ArrayList<JSONObject> FoundFilesList = new ArrayList<>();
        if (hits.totalHits > 0) {
            System.out.println("Найденные файлы:");
            for (ScoreDoc scoreDoc : hits.scoreDocs) {
                Document doc = searcher.getDocument(scoreDoc);
                String filepath = doc.get("filepath");

                JSONObject one = readOneFile(new File(filepath));
                if (one != null) {
                    //news.setScore(scoreDoc.score);
                    FoundFilesList.add(one);
                }

                System.out.println(filepath + " - " + scoreDoc.score);
            }
        }
    }

    public JSONObject readOneFile(File file) {
        String aboutOneCar = "";
        try {
            Scanner sc = new Scanner(file);
            aboutOneCar = sc.nextLine();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        JSONObject car = new JSONObject();
        String param = aboutOneCar.substring(aboutOneCar.indexOf("param") + 8, aboutOneCar.indexOf("price") - 3);
        String price = aboutOneCar.substring(aboutOneCar.indexOf("price") + 8, aboutOneCar.indexOf("title") - 3);
        String title = aboutOneCar.substring(aboutOneCar.indexOf("title") + 8, aboutOneCar.length() - 2);
        car.put("title", title);
        car.put("price", price);
        car.put("param", param);
        return car;
    }
}
