/**
 * Created by goga on 25.11.15.
 */

import java.io.*;
import java.util.StringTokenizer;

public class Solution {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    int n;
    double[][] a;
    double[] x;
    double[] c;
    double[] b;
    double eps = 0.0000000001;

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

    boolean con(double[] xx, double[] cc) {
        double norm = 0.0;
        for (int i = 0; i < n; i++) {
            norm += (xx[i] - cc[i]) * (xx[i] - cc[i]);
        }
        return Math.sqrt(norm) >= eps;
    }

    void recap() throws Exception {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        x = new double[n];
        c = new double[n];
        for (int i = 0; i < n; i++) {
            x[i] = 0;
        }
        int k = 0;
        do {
            k++;
            System.arraycopy(x, 0, c, 0, n);
            for (int i = 0; i < n; i++) {
                double var = 0;
                for (int j = 0; j < i; j++) {
                    var += a[i][j] * x[j];
                }
                for (int j = i + 1; j < n; j++) {
                    var += a[i][j] * c[j];
                }
                x[i] = (b[i] - var) / a[i][i];
            }
        }
        while (con(x, c));

        for (int i = 0; i < n; i++) {
            out.print(x[i] + " ");
        }
        out.close();
        System.out.println(k);
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