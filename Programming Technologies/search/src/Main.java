import javafx.util.Pair;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.*;

/**
 * Created by Гога on 07.09.2016.
 */
public class Main {
    private static ArrayList<String> lib;

    public static void main(String[] args) {

        lib = new ArrayList<>();
        try {
            Scanner sc = new Scanner(new FileReader("words.txt"));
            System.out.println("Загрузка словаря...");
            while (true) {
                String word = sc.next();
                lib.add(word);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchElementException e) {
            System.out.println("Словарь загружен.");
        }

        System.out.println("Введите слово:");
        String word = new Scanner(System.in).next();

        System.out.println("Введите k: ");
        int k = new Scanner(System.in).nextInt();

        ArrayList<String> wordd = new ArrayList<>();
        for (int i = 0; i <= word.length() - k; i++) {
            wordd.add(sub(word, k, i));
        }

        ArrayList<Pair<String, ArrayList<Integer>>> ans = new ArrayList<>();

        for (int i = 0; i < wordd.size(); i++) {
            ArrayList<Integer> con = new ArrayList<>();
            for (int j = 0; j < lib.size(); j++) {
                if (lib.get(j).contains(wordd.get(i))) {
                    con.add(j);
                }
            }
            Pair<String, ArrayList<Integer>> temp = new Pair<>(wordd.get(i), con);
            ans.add(temp);
        }

        Set<Integer> join = new HashSet<>();
        for (int i = 0; i < ans.size(); i++) {
            for (int j = 0; j < ans.get(i).getValue().size(); j++) {
                join.add(ans.get(i).getValue().get(j));
            }
        }

        ArrayList<Integer> joinN = new ArrayList<>(join);
        ArrayList<String> lib1 = new ArrayList<>();
        for (int i = 0; i < join.size(); i++) {
            lib1.add(lib.get(joinN.get(i)));
        }
        method1(word, lib);
        System.out.println("\n_____________________________УСКОРЕНИЕ_____________________________________________________\n");
        method1(word, lib1);
    }

    public static ArrayList<Integer> union(ArrayList<Integer> ar1, ArrayList<Integer> ar2) {
        ArrayList<Integer> ans = new ArrayList<>();
        for (int i = 0; i < ar1.size(); i++) {
            if (ar2.contains(ar1.get(i)))
                ans.add(ar1.get(i));
        }
        return ans;
    }

    public static String sub(String s, int k, int start) {
        String ss = "";
        for (int i = 0; i < k; i++) {
            ss += "#";
        }
        if (k + start <= s.length())
            ss = s.substring(start, start + k);
        return ss;
    }


    public static void method1(String word, ArrayList<String> lib) {
        int min = Integer.MAX_VALUE;
        int minN = 0;
        int minN1 = 0;
        int minN2 = 0;
        int minN3 = 0;
        int minN4 = 0;
        long start = System.currentTimeMillis();
        for (int i = 0; i < lib.size(); i++) {
            int k = levin(word, lib.get(i));
            if (k <= min) {
                min = k;
                minN4 = minN3;
                minN3 = minN2;
                minN2 = minN1;
                minN1 = minN;
                minN = i;
            }
        }
        long finish = System.currentTimeMillis();
        long timeConsumedMillis = finish - start;
        System.out.println(lib.get(minN));
        System.out.println(lib.get(minN1));
        System.out.println(lib.get(minN2));
        System.out.println(lib.get(minN3));
        System.out.println(lib.get(minN4));
        System.out.print("Время выполнения: ");
        System.out.println(timeConsumedMillis);
    }

    public static int levin(String s1, String s2) {
        int m = s1.length(), n = s2.length();
        int[] D1;
        int[] D2 = new int[n + 1];

        for (int i = 0; i <= n; i++)
            D2[i] = i;

        for (int i = 1; i <= m; i++) {
            D1 = D2;
            D2 = new int[n + 1];
            for (int j = 0; j <= n; j++) {
                if (j == 0) D2[j] = i;
                else {
                    int cost = (s1.charAt(i - 1) != s2.charAt(j - 1)) ? 1 : 0;
                    if (D2[j - 1] < D1[j] && D2[j - 1] < D1[j - 1] + cost)
                        D2[j] = D2[j - 1] + 1;
                    else if (D1[j] < D1[j - 1] + cost)
                        D2[j] = D1[j] + 1;
                    else
                        D2[j] = D1[j - 1] + cost;
                }
            }
        }
        return D2[n];
    }
}
