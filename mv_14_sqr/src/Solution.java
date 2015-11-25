/**
 * Created by goga on 25.11.15.
 */

import java.io.*;
import java.util.Map;
import java.util.StringTokenizer;

public class Solution {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    double[][] a;
    double[] t;
    double[] y;
    double[] b;
    double[] x;
    double[][] w;
    int n;

    public static void main(String[] args) throws Exception {
        Solution sol = new Solution();
        sol.read();
        sol.recap();
    }

    void read() throws IOException {
        in = new BufferedReader(new InputStreamReader(new FileInputStream("input.txt")));
        n = nextInt();
        a = new double[n][n];
        b = new double[n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                a[i][j] = nextDouble();
            }
            b[i] = nextDouble();
        }
    }

    void recap() throws Exception {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        w = new double[n][n];
        t = new double[n];
        y = new double[n];
        x = new double[n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                double sum = 0;
                for (int k = 0; k < i; k++) {
                    if (j == i) {
                        sum += w[k][i] * w[k][i] * t[k];
                    }
                    else {
                        sum += w[k][i] * w[k][j] * t[k];
                    }
                }
                if (j == i) {
                    w[i][i] = Math.sqrt(Math.abs(a[i][i] - sum));
                    if (a[i][i] - sum > 0) {
                        t[i] = 1;
                    }
                    else
                        t[i] = -1;
                }
                else {
                    if (i < j) {
                        w[i][j] = (a[i][j] - sum) / (t[i] * w[i][i]);
                    }
                    else {
                        if (i > j)
                            w[i][j] = 0;
                    }
                }
            }
        }


        double sum = 0;
        for (int i = 0; i < n; i++) {
            sum = 0;
            for (int k = 0; k < i; k++) {
                if (i == k) {
                    sum += t[k] * w[i][i] * y[k];
                }
                else
                    sum += t[k] * w[k][i] * y[k];
            }
            y[i] = (b[i] - sum) / (t[i] * w[i][i]);
        }

        double h = 0;
        for (int i = n - 1; i >= 0; i--) {
            h = 0;
            for (int k = i + 1; k < n; k++) {
                if (i == k) {
                    h += w[i][i] * x[k];
                }
                else
                    h += w[i][k] * x[k];
            }
            x[i] = (y[i] - h) / w[i][i];
        }

        for (int i = 0; i < n; i++) {
            out.print(x[i] +  " ");
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