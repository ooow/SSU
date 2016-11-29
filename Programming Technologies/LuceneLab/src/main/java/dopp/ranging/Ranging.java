package dopp.ranging;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by goga on 24.11.16.
 */
public class Ranging {

    public void ranging(Integer[][] arr) {
        ArrayList<Double> res = new ArrayList<>();
        for (Integer[] i : arr) {
            res.add(qc(i));
        }

        double relResult = 0;
        for (double v : res) {
            relResult += v;
        }

        System.out.println("Оценка качества поиска: \n" + (relResult / res.size()));
    }

    // оценка качества NDCG
    public double qc(Integer[] arr) {
        int length = arr.length;

        double DCG = arr[0].doubleValue();
        for (int i = 1; i < length; i++) {
            DCG += arr[i].doubleValue() / (log2(i + 1));
        }

        List<Integer> list = new ArrayList<>(Arrays.asList(arr));
        list.sort((o1, o2) -> -1 * new Double(o1.doubleValue()).compareTo(o2.doubleValue()));

        double IDCG = list.get(0).doubleValue();
        for (int i = 1; i < length; i++) {
            IDCG += list.get(i).doubleValue() / (log2(i + 1));
        }

        return DCG / IDCG;
    }

    private double log2(double x) {
        return Math.log(x) / Math.log(2.0);
    }
}

