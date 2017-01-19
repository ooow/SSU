package search;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.LowerCaseFilter;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.Tokenizer;
import org.apache.lucene.analysis.ru.RussianLightStemFilter;
import org.apache.lucene.analysis.standard.ClassicTokenizer;
import org.apache.lucene.analysis.standard.StandardFilter;
import org.apache.lucene.analysis.synonym.SynonymFilter;
import org.apache.lucene.analysis.synonym.SynonymMap;
import org.apache.lucene.util.CharsRef;

import java.io.IOException;

public class SynonymAnalyzer extends Analyzer {

    @Override
    protected TokenStreamComponents createComponents(String s) {

        SynonymMap.Builder builder = new SynonymMap.Builder(true);
        builder.add(new CharsRef("nerv"), new CharsRef("нерв"), true);
        builder.add(new CharsRef("why"), new CharsRef("почему"), true);

        SynonymMap mySynonymMap = null;
        try {
            mySynonymMap = builder.build();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Tokenizer source = new ClassicTokenizer(); // токинайзер
        TokenStream filter = new StandardFilter(new RussianLightStemFilter(new LowerCaseFilter(source))); // фильр
        filter = new SynonymFilter(filter, mySynonymMap, true);

        return new TokenStreamComponents(source, filter);
    }

}
