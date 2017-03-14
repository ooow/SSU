package lucene.search;

import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

/**
 * Created by goga on 07.11.16.
 */
public class Indexer {
    private IndexWriter writer;

    public Indexer(String dir) throws IOException {
        Directory indexDirectory = FSDirectory.open(new File(dir).toPath());

        IndexWriterConfig indexConfig = new IndexWriterConfig(new SynonymAnalyzer());
        indexConfig.setOpenMode(IndexWriterConfig.OpenMode.CREATE);
        writer = new IndexWriter(indexDirectory, indexConfig);

    }

    public void close() throws IOException {
        writer.close();
    }

    public int createIndex() throws IOException {
        loadFile();
        return writer.numDocs();
    }

    public void loadFile() throws IOException {
        String pathToData = "/Users/goga/IdeaProjects/Programming Technologies/LuceneLab/Data Storage/";
        File[] files = new File(pathToData).listFiles();
        Scanner sc = null;

        for (int i = 0; i < files.length; i++) {
            sc = new Scanner(new FileReader(files[i]));
            String aboutOneCar = sc.nextLine();
            String param = aboutOneCar.substring(aboutOneCar.indexOf("param") + 8, aboutOneCar.indexOf("price") - 3);
            String price = aboutOneCar.substring(aboutOneCar.indexOf("price") + 8, aboutOneCar.indexOf("title") - 3);
            String title = aboutOneCar.substring(aboutOneCar.indexOf("title") + 8, aboutOneCar.length() - 2);
            Document doc = new Document();
            doc.add(new TextField("filepath", files[i].toString(), Field.Store.YES));
            doc.add(new TextField("title", title, Field.Store.YES));
            doc.add(new TextField("price", price, Field.Store.YES));
            doc.add(new TextField("param", param, Field.Store.YES));
            writer.addDocument(doc);
        }
    }
}
