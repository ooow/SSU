package dopp.ranging;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

/**
 * Created by goga on 24.11.16.
 */
public class Upgrade {

    public static void main(String[] args) throws Exception {
        // Улучшение поиска

        //makeLearnList(500000);
        LinearRegression rangingReg = new LinearRegression();
        rangingReg.learn();
        rangingReg.ranging(QualityСontrol.getRating());
    }

    private static void makeLearnList(int count) throws IOException {
        Ranging ranging = new Ranging();
        PrintWriter pw = new PrintWriter(new FileOutputStream("ranging/learn.txt"));
        Random r = new Random(System.currentTimeMillis());
        for (int i = 0; i < count; i++) {
            String str = "";
            Integer[] tmp = new Integer[10];
            for (int j = 0; j < tmp.length; j++) {
                int k = r.nextInt(2) + 1;
                tmp[j] = k;
                str += k + ":";
            }
            str += ranging.qc(tmp);
            pw.println(str);
        }
        pw.close();
    }
}
