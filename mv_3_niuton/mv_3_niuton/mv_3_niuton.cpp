#define M_PI       3.141592653589793238462
#include <iostream>
#include <cmath>
#include <ctime>
#include <math.h>
#include <fstream>

using namespace std;
double mx[101];
double my[101];
double s[10001];
double w[10001];
double RR[10001];
double wx[10001];
double koef[101];
// знаменатель разделенной разности
double zn(int j, int n)
{
	double t = 1;
	for (int i = 0; i <= n; i++)
	{
		if (j != i)
			t *= mx[j] - mx[i];
	}
	return t;
}
// разделенная разность
double raz(int n)
{
	double r = 0;
	for (int j = 0; j <= n; j++)
	{
		r += my[j] / zn(j, n);
	}
	return r;
}
// дополнительный множетель (x - x0)(x - x1) ... (x - xN)
double mno(double x, int n)
{
	double r = 1;
	for (int i = 0; i < n; i++)
	{
		r *= x - mx[i];
	}
	return r;
}
// вычисление ln в точке x
double ln(double x, int n)
{
	double r = my[0];
	koef[0] = r;
	for (int k = 1; k <= n; k++)
	{
		r += RR[k] * mno(x, k);
		koef[k] = r;
	}
	return r;
}

int main()
{
	double start = clock();
	ifstream in("input.txt");
	ofstream out("output.txt");
	int n, N;
	in >> n >> N;
	double a = -1, b = 1;

	// x0, x1, ... xN
	double h = (b - a) / n;
	double h1 = (b - a) / N;
	/*for (int i = 0; i <= n; i++)
		mx[i] = cos(((2 * i + 1) * M_PI) / (2 * (n + 1)));

	// y0, y1, ... yN
	for (int i = 0; i <= n; i++)
		my[i] = abs(mx[i]);

	// Разделенная разность 1, 2, ... n - го порядка
	for (int i = 0; i <= n; i++)
		RR[i] = raz(i);

	// s0, s1, ... sN
	for (int i = 0; i <= N; i++)
		s[i] = a + i * h1; */

	for (int i = 0; i <= n; i++)
		in >> mx[i];
	for (int i = 0; i <= n; i++)
		in >> my[i];

	// Разделенная разность 1, 2, ... n - го порядка
	for (int i = 0; i <= n; i++)
		RR[i] = raz(i);


	out.precision(10);
	out << fixed;

	for (int i = 0; i <= n; i++)
		out << RR[i] << " ";


	/* long double er = 0.002;
	double e = -1;
	for (int i = 0; i < N; i ++)
	{
	wx[i] = e;
	e += er;
	}
	for (int i = 0; i <= N; i++)
	out << "(" << wx[i] << ";" << w[i] << ")" << endl;*/

	double end = clock();
	out << "\nTime: " << (end - start) / 10.0 << " msec";
	return 0;
}