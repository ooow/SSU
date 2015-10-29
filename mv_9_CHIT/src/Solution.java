import java.io.*;
import java.util.StringTokenizer;

public class Solution {
    BufferedReader in;
    PrintWriter out;
    StringTokenizer st;
    double A, B;
    int n;
    double eps;
    double o = 1.0 / 3;
    double[] mx = new double[9999999];

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
            ans += (mx[i] - mx[i - 1]) * ((Math.cos(A * mx[i - 1] + B) + Math.cos(A * mx[i] + B)) / 2);
        }
        double di = (Math.sin(B + Math.PI * A)/ A) - Math.sin(B) / A;
        out.println("CHIP  " + ans);
        out.println("Integral  " + di);
        out.close();
    }
    void read_Runge() throws IOException
    {
        in = new BufferedReader(new InputStreamReader(new FileInputStream("input.txt")));
        eps = nextDouble();
        A = nextDouble();
        B = nextDouble();
    }
    double Runge(int N) throws Exception
    {
        double a = 0;
        double b = Math.PI;
        double h = (b - a) / N;
        for (int i = 0; i <= N; i ++)
        {
            mx[i] = a + h * i;
        }
        double ans = 0;
        for (int i = 1; i <= N; i ++)
        {
            ans += (mx[i] - mx[i - 1]) * ((Math.cos(A * mx[i - 1] + B) + Math.cos(A * mx[i] + B)) / 2);
        }
        return ans;
    }

    void wride_Runge() throws Exception
    {
        out = new PrintWriter(new BufferedOutputStream(new FileOutputStream("output.txt")));
        int Nn = 1;
        double t = Runge(Nn);
        Nn *= 2;
        double ans = Runge(Nn);
        while(o * Math.abs(ans - t) >= eps)
        {
            t = ans;
            Nn *= 2;
            ans = Runge(Nn);
        }

        double di = (Math.sin(B + Math.PI * A)/ A) - Math.sin(B) / A;
        out.println("CHIT  " + ans + "  N= " + Nn);
        out.println("Integral  " + di);
        out.close();
    }


    public static void main(String[] args) throws Exception {
        Solution  sol = new Solution ();
        //sol.read();
        //sol.wride();
        sol.read_Runge();
        sol.wride_Runge();
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