import java.io.*;
import java.util.StringTokenizer;

public class Solution {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    double A, B;
    int n;
    double[] mx = new double[1000000];

    void read() throws IOException {
        in = new BufferedReader(new InputStreamReader(new FileInputStream("input.txt")));
        n = 100000;
        A = nextDouble();
        B = nextDouble();
        double a = 0;
        double b = 2 * Math.PI;
        double h = (b - a) / n;
        n++;
        for (int i = 0; i < n; i ++)
        {
            mx[i] = a + h * i;
        }
    }

    double fun(double x)
    {
        double r = Math.sqrt(((-1) * A * Math.sin(x) * (-1) * A * Math.sin(x))  + (B * Math.cos(x)) * (B * Math.cos(x)));
        return r;
    }

    void wride() throws Exception
    {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        double ans = 0;
        for (int i = 1; i < n; i ++)
        {
            ans += ((mx[i] - mx[i - 1]) / 6) * (fun(mx[i - 1]) + 4 * fun((mx[i - 1] + mx[i]) / 2) + fun(mx[i]));
        }
        out.println(ans);
        out.close();
    }


    public static void main(String[] args) throws Exception {
        Solution  sol = new Solution ();
        sol.read();
        sol.wride();
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