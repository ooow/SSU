package lucene.search;

import java.io.IOException;

/**
 * Created by goga on 16.11.16.
 */
public class JustIndexer {
    public static void main(String[] args) throws IOException {
        LuceneSearch tester = new LuceneSearch();
        tester.createIndex();
    }
}
