#define _CRT_SECURE_NO_WARNINGS
#define M_PI       3.141592653589793238462
#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <fstream>

using namespace std;

long double M = -1e+9;

int n;
int N;
long double h;
vector<long double>x;
vector<long double>y;
vector<long double>c;
vector<bool>used;

long double S(long double z)
{
	int k = upper_bound(x.begin(), x.end(), z) - x.begin();
	if (k == n)
		k--;
	long double xx = z - x[k];	long double bb;	long double dd; long double re;
	dd = ((c[k] - c[k - 1]) / h);
	bb = (((y[k] - y[k - 1]) / h) + ((h / 2.0)  *  c[k]) - (((h * h) / 6.0)  *  dd));
	re = ((y[k] + bb  *  xx) + ((c[k] / 2.0)  *  (xx  *  xx)) + ((dd / 6.0)  *  (xx  *  xx  *  xx)));
	return re;
}

int main()
{
	freopen("input.txt", "r", stdin);
	freopen("output.txt", "w", stdout);
	cin >> n >> N;
	n++;	N++;
	used.resize(n, false);
	x.resize(n);	y.resize(n);	c.resize(n);
	long double a = 0;
	long double b = M_PI;
	h = ((b - a) / ((long double)(n - 1)));

	for (int i = 0; i < n; i++)
		x[i] = a + (h  *  ((long double)i));

	for (int i = 0; i < n; i++)
		y[i] = sin(x[i]);

	vector <long double> A(n);
	vector <long double> B(n);

	A[0] = 0.0;
	for (int i = 1; i < n - 1; i++)
		A[i] = (-1.0) / (A[i - 1] + 4);

	B[0] = 0.0;
	for (int i = 1; i < n - 1; i++)
		B[i] = (6.0 / (h * h) * (y[i - 1] - 2 * y[i] + y[i + 1]) - B[i - 1]) / (A[i - 1] + 4);

	c[0] = 0.0;
	c[n - 1] = 0.0;

	for (int i = n - 2; i > 0; i--)
		c[i] = A[i]  *  c[i + 1] + B[i];
	
	cout.precision(10);
	cout << fixed;
	vector<long double> sm;
	sm.resize(N + 1);
	long double t = M_PI / N;
	long double t1 = 0;
	for (int i = 0; i < N; i++)
	{

		sm[i] = t1;
		t1 += t;
	}
	for (int i = 0; i < N; i++)
	{
		cout << sm[i] << ";" << S(sm[i]) << endl;
	}
	return 0;
}