package dopp;

import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.MultiFields;
import org.apache.lucene.index.TermsEnum;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.BytesRef;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 * Created by goga on 22.11.16.
 */
public class ZipfLaw {

    private static TreeMap<String, Long> multiset = new TreeMap<>();
    private static ArrayList<String> fields = new ArrayList<>();

    public static void main(String[] args) throws IOException {
        long startTime = System.currentTimeMillis();
        Directory indexDirectory = FSDirectory.open(new File("index").toPath());
        IndexReader reader = DirectoryReader.open(indexDirectory);
        MultiFields.getFields(reader).forEach(fields::add);

        TermsEnum termEnum = MultiFields.getTerms(reader, "title").iterator();
        BytesRef bytesRef;
        while ((bytesRef = termEnum.next()) != null) {
            String term = bytesRef.utf8ToString();
            if (!fields.contains(term)) {
                multiset.put(term, termEnum.totalTermFreq());
            }
        }
        List<Map.Entry<String, Long>> list = new ArrayList<>(multiset.entrySet());
        Collections.sort(list, (o1, o2) -> -1 * o1.getValue().compareTo(o2.getValue()));

        PrintWriter pw = new PrintWriter(new FileOutputStream("Diagram.txt"));
        String tableName = "Ранк\tСлово\t\t   Частота";
        pw.println(tableName);
        int rank = 1;
        String columsize = "               ";
        for (Map.Entry<String, Long> e : list) {
            String key = e.getKey();
            String value = "" + e.getValue();
            String res = rank + "\t\t" + key + columsize.substring(0, columsize.length() - key.length()) + value;
            pw.println(res);
            rank++;
        }
        long endTime = System.currentTimeMillis();
        System.out.println("Время выполнения: " + (endTime - startTime) + " мс");
        pw.close();
    }
}
