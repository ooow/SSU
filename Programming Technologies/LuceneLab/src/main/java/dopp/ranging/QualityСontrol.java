package dopp.ranging;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.Random;
import java.util.Scanner;

/**
 * Created by goga on 23.11.16.
 */
public class QualityСontrol {
    public static void main(String[] args) {
        // Оценка качества

        //generateRating();
        Ranging rang = new Ranging();
        rang.ranging(getRating());
    }


    public static Integer[][] getRating() {
        Integer[][] arr = new Integer[10][10];
        try {
            Scanner sc = new Scanner(new FileReader("ranging/rating.txt"));
            for (int i = 0; i < arr.length; i++) {
                String[] oneLineDate = sc.nextLine().split(" ");
                for (int j = 0; j < oneLineDate.length; j++) {
                    arr[i][j] = Integer.valueOf(oneLineDate[j]);
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return arr;
    }

    private static void generateRating() {
        Integer[][] arr = new Integer[10][10];
        Random r = new Random(System.currentTimeMillis());
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr[i].length; j++) {
                arr[i][j] = r.nextInt(10) + 1;
            }
        }
        try {
            PrintWriter pw = new PrintWriter(new FileOutputStream("ranging/rating.txt"));
            for (Integer[] i : arr) {
                for (Integer j : i) {
                    pw.print(j + " ");
                }
                pw.println();
            }
            pw.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
}
