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
    double[] b;
    double[] c;

    public static void main(String[] args) throws Exception {
        Solution sol = new Solution();
        sol.read();
        sol.recap();
    }

    void read() throws IOException {
        in = new BufferedReader(new InputStreamReader(new FileInputStream("input.txt")));
        n = nextInt();
        a = new double[n][n + 1];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n + 1; j++) {
                a[i][j] = nextDouble();
            }
        }
    }

    void recap() throws Exception {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        b = new double[n];
        c = new double[n];
        double eps = 0.0000000001;
        int k = 0;
        while (true) {
            k++;
            for (int i = 0; i < n; i++) {
                c[i] = a[i][n];
                for (int j = 0; j < n; j++) {
                    if (i != j) {
                        c[i] -= a[i][j] * b[j];
                    }
                }
                c[i] /= a[i][i];
            }
            double e = 0.0;
            for (int i = 0; i < n; i++) {
                e += Math.abs(c[i] - b[i]);
            }
            if (e < eps)
                break;

            System.arraycopy(c, 0, b, 0, n);
        }
        for (int i = 0; i < n; i++) {
            out.print(b[i] + " ");
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