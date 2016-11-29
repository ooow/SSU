package dopp.ranging;

import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.stream.IntStream;

;

/**
 * Created by goga on 24.11.16.
 */
public class LinearRegression {

    private double[] coefficients;

    public void learn() throws FileNotFoundException {
        OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();
        Scanner sc = new Scanner(new FileInputStream(new File("ranging/learn.txt")));

        ArrayList<Double> qc = new ArrayList<>();
        ArrayList<ArrayList<Double>> rating = new ArrayList<>();

        while (sc.hasNext()) {
            String[] oneLineDate = sc.nextLine().split(":");
            ArrayList<Double> rtg = new ArrayList<>();
            for (int i = 0; i < oneLineDate.length - 1; i++) {
                rtg.add(Double.valueOf(oneLineDate[i]));
            }
            rating.add(rtg);
            qc.add(Double.valueOf(oneLineDate[oneLineDate.length - 1]));
        }

        double[] qcArr = qc.stream().mapToDouble(i -> i).toArray();
        double[][] ratingArr = new double[qcArr.length][];
        IntStream.range(0, rating.size()).forEach(i -> ratingArr[i] = rating.get(i).stream().mapToDouble(j -> j).toArray());

        regression.newSampleData(qcArr, ratingArr);
        coefficients = regression.estimateRegressionParameters();
    }


    public void ranging(Integer[][] arr) throws Exception {
        ArrayList<Double> res = new ArrayList<>();

        for (Integer[] i : arr) {
            double coeff = coefficients[0];
            int k = 0;
            for (Integer j : i) {
                coeff += j * coefficients[k + 1];
                k++;
            }
            res.add(coeff);
        }

        double result = 0;
        for (double d : res) {
            result += d;
        }
        System.out.println("Оценка качества после применения линейной регрессии: \n" + (result / res.size()));
    }
}
