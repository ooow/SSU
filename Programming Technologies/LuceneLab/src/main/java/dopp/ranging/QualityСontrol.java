package dopp.ranging;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;

/**
 * Created by goga on 23.11.16.
 */
public class QualityСontrol {
    public static void main(String[] args) {
        // Оценка качества

        Ranging rang = new Ranging();
        rang.ranging(getRating());
    }


    public static Integer[][] getRating() {
        Integer[][] arr = new Integer[10][10];
        try {
            Scanner sc = new Scanner(new FileReader("ranging/rating.txt"));
            for (int i = 0; i < arr.length; i++) {
                String[] oneLineDate = sc.nextLine().split(" ");
                for (int j = 0; j < 10; j++) {
                    arr[i][j] = Integer.valueOf(oneLineDate[j].substring(oneLineDate[j].indexOf(":") + 1));
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return arr;
    }
}
