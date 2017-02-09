/**
 * Created by goga on 02.12.15.
 */

public class Solution {
    private int q = 0;
    private double e = 0.000000000001;

    public static void main(String[] args) {
        Solution sol = new Solution();
        sol.run();
    }

    public void run() {
        double pi = 3.14159265359;
        double a1 = 0;
        double b1 = pi / 2;
        double a2 = -pi;
        double b2 = pi / 2;

        //      Метод деления отрезка пополам
        System.out.println("Метод деления отрезка пополам :");
        System.out.print(inTwo(a1, b1) + ", ");
        System.out.println("итераций: " + q);
        System.out.print(inTwo(a2, b2) + ", ");
        System.out.println("итераций: " + q);
        System.out.println();

        //      Метод простой итерации
        System.out.println("Метод простой итерации:");
        System.out.print(simple(0.5) + " ");
        System.out.println("итераций: " + q);
        System.out.print(simple(-3) + ", ");
        System.out.println("итераций: " + q);
        System.out.println();

        //      Метод Ньютона
        System.out.println("Метод Ньютона:");
        System.out.print(New(0.5) + ", ");
        System.out.println("итераций: " + q);
        System.out.print(New(-3) + ", ");
        System.out.println("итераций: " + q);
        System.out.println();

        //      Модифицированный метод Ньютона
        System.out.println("Модифицированный метод Ньютона:");
        System.out.print(modNew(0.5) + ", ");
        System.out.println("итераций: " + q);
        System.out.print(modNew(-3) + ", ");
        System.out.println("итераций: " + q);
        System.out.println();

        //      Метод секущих
        System.out.println("Метод секущих:");
        System.out.print(sek(0.5, 0.3) + ", ");
        System.out.println("итераций: " + q);
        System.out.print(sek(-3, -3.3) + ", ");
        System.out.println("итераций: " + q);
    }

    double f(double x) {
        return Math.sin(x) - 2 * Math.cos(x);
    }

    double ff(double x) {
        return Math.cos(x) + 2 * Math.sin(x);
    }

    double inTwo(double a, double b) {
        q = 0;
        double x0 = 0;
        while (Math.abs(a - b) >= e) {
            q++;
            x0 = (a + b) / 2;
            if (f(x0) * f(a) < 0) {
                b = x0;
            } else a = x0;
        }
        return (a + b) / 2;
    }

    /*
    s(x) = x + t * f(x), t <>0
    t * f'(x)
    находится в промежутке -2 < t * f'(x) < 0
    если у нас f'(x) < 0,
    тогда 0 < t < 2/abs(f'(x))
    иначе -2/f'(x) < t < 0
    */

    double simple(double x0) {
        q = 1;
        double x = x0, x1 = 0, t = 0;
        if (ff(x0) < 0) t = 1 / Math.abs(ff(x0));
        else t = -1 / ff(x0);
        x1 = x + f(x) * t;
        q++;
        while (Math.abs(x1 - x) >= e) {
            q++;
            x = x1;
            x1 = x + f(x) * t;
        }
        return x1;
    }

    double New(double x0) {
        q = 0;
        double x = x0, x1 = 0;
        x1 = x - f(x) / ff(x);
        q++;
        while (Math.abs(x1 - x) >= e) {
            q++;
            x = x1;
            x1 = x - f(x) / ff(x);
        }
        return x1;
    }

    double modNew(double x0) {
        q = 0;
        double x = x0, x1 = 0, proiz = ff(x0);
        x1 = x - f(x) / proiz;
        q++;
        while (Math.abs(x1 - x) >= e) {
            q++;
            x = x1;
            x1 = x - f(x) / proiz;
        }
        return x1;
    }

    double sek(double x0, double xn) {
        q = 0;
        double x = x0, x1 = 0;
        x1 = x - f(x) * (x - xn) / (f(x) - f(xn));
        q++;
        while (Math.abs(x1 - x) >= e) {
            q++;
            xn = x;
            x = x1;
            x1 = x - f(x) * (x - xn) / (f(x) - f(xn));
        }
        return x1;
    }
}


