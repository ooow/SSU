/**
 * Created by goga on 12.11.15.
 */

import java.io.*;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class Solution {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    int n;
    ArrayList<ArrayList<Double>> m = new ArrayList<>();

    public static void main(String[] args) throws Exception {
        Solution sol = new Solution();
        sol.read();
        sol.recap();
    }

    Double[] Gauss(Double[][] a) {
        Double[] x = new Double[n*n];
        Double max;
        Double maxb;
        int i, j, k, m;
        for (k = 0; k < n; k++) //Поиск максимального элемента в первом столбце
        {
            max = Math.abs(a[k][k]);
            i = k;
            for (m = k + 1; m < n; m++)
                if (Math.abs(a[m][k]) > max) {
                    i = m;
                    max = Math.abs(a[m][k]);

                }

            if (i != k)  //  перестановка i-ой строки, содержащей главный элемент k-ой строки
            {
                for (j = k; j < n + 1; j++) {
                    maxb = a[k][j];
                    a[k][j] = a[i][j];
                    a[i][j] = maxb;
                }
            }
            max = a[k][k];//преобразование k-ой строки (Вычисление масштабирующих множителей)

            a[k][k] = 1.0;

            for (j = k + 1; j < n + 1; j++)
                a[k][j] = a[k][j] / max;

            for (i = k + 1; i < n; i++)//преобразование строк с помощью k-ой строки
            {
                maxb = a[i][k];
                a[i][k] = 0.0;
                if (maxb != 0)
                    for (j = k + 1; j < n + 1; j++)
                        a[i][j] = a[i][j] - maxb * a[k][j];
            }
        }
        for (int l = 0; l < n + 1; l++) {
            x[l] = 0.0;
        }
        for (i = n - 1; i >= 0; i--)   //Нахождение решений СЛАУ
        {
            x[i] = 0.0;
            max = a[i][n];
            for (j = n; j > i; j--)
                max = max - a[i][j] * x[j];
            x[i] = max;
        }
        return x;
    }

    ArrayList<Double> inverse_matrix (ArrayList<ArrayList<Double>> a, ArrayList<Double> b)
    {
        for (int i = 0; i < n; i++)
        {
            a.get(i).add(n, b.get(i));
        }
        Double[][] a1 = new Double[1000][1000];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= n; j++) {
                a1[i][j] = a.get(i).get(j);
            }
        }
        Double[] d = new Double[1000];
        d = Gauss(a1);
        ArrayList<Double> res = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            res.add(i,d[i]);
        }
        return res;
    }

    void read() throws IOException {
        in = new BufferedReader(new InputStreamReader(new FileInputStream("input.txt")));
        n = nextInt();

        for (int i = 0; i < n; i++) {
            ArrayList<Double> temp = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                temp.add(j,nextDouble());
            }
            m.add(i,temp);
        }
    }

    void recap() throws Exception {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        ArrayList<ArrayList<Double>> b = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            ArrayList<Double> temp = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                if (i == j)
                    temp.add(j, 1.0);
                else temp.add(j, 0.0);
            }
            b.add(i,temp);
        }

        ArrayList<ArrayList<Double>> ES = new ArrayList<>();
        for (int i = 0; i < n; i++)
        {
            ES.add(i, inverse_matrix(m, b.get(i)));
        }
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                out.print(ES.get(i).get(j) + "   ");
            out.println();
        }
        out.close();
    }

    String next() throws IOException {
        while (st == null || !st.hasMoreTokens()) {
            st = new StringTokenizer(in.readLine());
        }
        return st.nextToken();
    }

    int nextInt() throws IOException {
        return Integer.parseInt(next());
    }

    Long nextLong() throws IOException {
        return Long.parseLong(next());
    }

    double nextDouble() throws IOException {
        return Double.parseDouble(next());
    }
}