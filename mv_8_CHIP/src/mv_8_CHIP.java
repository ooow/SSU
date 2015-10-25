import java.io.*;
import java.util.StringTokenizer;

public class mv_8_CHIP {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    double A, B;
    int n;
    double[] mx = new double[100000];

    void read() throws IOException {
        in = new BufferedReader(new InputStreamReader(new FileInputStream("input.txt")));
        n = nextInt();
        A = nextDouble();
        B = nextDouble();
        double a = 0;
        double b = Math.PI;
        double h = (b - a) / n;
        n++;
        for (int i = 0; i < n; i ++)
        {
            mx[i] = a + h * i;
        }
    }

    void wride() throws Exception
    {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        double ans = 0;
        for (int i = 1; i < n; i ++)
        {
            ans += (mx[i] - mx[i - 1]) * Math.cos (A * ((mx[i - 1] + mx[i]) / 2) + B);
        }
        out.println(ans);
        out.close();
    }


    public static void main(String[] args) throws Exception {
        mv_8_CHIP  sol = new mv_8_CHIP ();
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