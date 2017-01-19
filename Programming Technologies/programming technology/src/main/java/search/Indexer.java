package search;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import parse.SiteParser;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class Indexer {
    private IndexWriter documents;

    public static void main(String[] args) throws IOException {
        System.out.println("Начало индексации..");
        String indexDir = "src/main/resources/index";
        Indexer indexer = new Indexer(indexDir);
        int numIndexed;
        long startTime = System.currentTimeMillis();
        numIndexed = indexer.createIndex();
        long endTime = System.currentTimeMillis();
        indexer.close();
        System.out.println("Кол-во элементов: " + numIndexed + "\nВремя индексации: " + (endTime - startTime) + " мс");
    }

    public Indexer(String dir) throws IOException {
        Directory indexDirectory = FSDirectory.open(new File(dir).toPath());
        IndexWriterConfig indexConfig = new IndexWriterConfig();
        indexConfig.setOpenMode(IndexWriterConfig.OpenMode.CREATE);
        documents = new IndexWriter(indexDirectory, indexConfig);

    }

    public int createIndex() throws IOException {
        ArrayList<Document> films = SiteParser.parse(9000);
        documents.addDocuments(films);
        return documents.numDocs();
    }

    public void close() throws IOException {
        documents.close();
    }
}
