/**
 * Created by goga on 05.11.15.
 */

import java.io.*;
import java.util.Map;
import java.util.StringTokenizer;

public class Solution {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    int n;
    Double[][] a = new Double[1000][1000];
    Double[] x = new Double[1000];

    public static void main(String[] args) throws Exception {
        Solution sol = new Solution();
        sol.read();
        sol.recap();
    }

    void read() throws IOException {
        in = new BufferedReader(new InputStreamReader(new FileInputStream("input.txt")));
        n = nextInt();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                a[i][j] = nextDouble();
            }
            a[i][n] = nextDouble();
        }
    }
    void Gauss() {
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
    }
    void recap() throws Exception {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        Gauss();
        for (int i = 0; i < n; i++) {
            out.print(x[i] + " ");
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