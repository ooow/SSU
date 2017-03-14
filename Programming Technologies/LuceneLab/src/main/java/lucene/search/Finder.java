package lucene.search;

import org.apache.lucene.queryparser.classic.ParseException;

import java.io.IOException;
import java.util.Scanner;

/**
 * Created by goga on 07.11.16.
 */
public class Finder {
    private static String request;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Введите запрос: ");
        request = sc.nextLine();
        LuceneSearch tester;
        try {
            tester = new LuceneSearch();
            //tester.createIndex();
            tester.search(request, "index", "title");
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }
}
// оценка качества/ улучшение поиска/ закон ципфа