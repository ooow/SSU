/**
 * Created by goga on 05.11.15.
 */

import java.io.*;
import java.util.StringTokenizer;

public class Solution {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    int n;
    Double[] a = new Double[1000];
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
            double ans = 0;
            for (int j = 0; j < i; j++) {
                double a = nextDouble();
                ans += a * x[j];
            }
            double a = nextDouble();
            double b = nextDouble();
            x[i] = (b - ans)/a;
        }
    }

    void recap() throws Exception {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
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

