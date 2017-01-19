package search;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class LuceneSearch {

    private static final int MAX_SEARCH = 1000;
    private IndexSearcher indexSearcher;

    public static void main(String[] args) throws IOException, ParseException {
        LuceneSearch lc = new LuceneSearch();
        lc.searchByRating("9.11");
    }


    public LuceneSearch() throws IOException {
        String indexDir = "src/main/resources/index";
        Directory indexDirectory = FSDirectory.open(new File(indexDir).toPath());
        indexSearcher = new IndexSearcher(DirectoryReader.open(indexDirectory));
    }

    protected TopDocs search(String searchQuery, String... selections) throws IOException, ParseException {
        ArrayList<QueryParser> queryParsers = new ArrayList<>();
        for (String selection : selections) {
            queryParsers.add(new QueryParser(selection, new SynonymAnalyzer()));
        }
        BooleanQuery.Builder result_query = new BooleanQuery.Builder();
        for (QueryParser query : queryParsers)
            result_query.add(query.parse(searchQuery), BooleanClause.Occur.SHOULD);
        return indexSearcher.search(result_query.build(), MAX_SEARCH);
    }

    protected Document getDocument(ScoreDoc scoreDoc) throws IOException {
        return indexSearcher.doc(scoreDoc.doc);
    }

    public ArrayList<Document> searchByName(String searchQuery) throws IOException, ParseException {
        ArrayList<Document> docs = new ArrayList<>();
        TopDocs hits = search(searchQuery, "name");
        if (hits.totalHits > 0) {
            for (ScoreDoc scoreDoc : hits.scoreDocs) {
                docs.add(getDocument(scoreDoc));
            }
        }
        return docs;
    }

    public ArrayList<Document> searchByRating(String searchQuery) throws IOException, ParseException {
        ArrayList<Document> docs = new ArrayList<>();
        double minRating = Double.valueOf(searchQuery);
        while (minRating < 10) {
            minRating = Math.round((minRating + 0.01) * 100.0) / 100.0;
            TopDocs hits = search(minRating + "", "rating");
            if (hits.totalHits > 0) {
                for (ScoreDoc scoreDoc : hits.scoreDocs) {
                    docs.add(getDocument(scoreDoc));
                }
            }
        }
        return docs;
    }
}
