#define M_PI       3.141592653589793238462
#include <iostream>
#include <cmath>
#include <ctime>
#include <math.h>
#include <fstream>

using namespace std;
double mx[101];
double my[101];
double s[1001];
double w[10001];
double mm[10001];
double wx[10001];

double lnk(double x, int k, int n)
{
	double r, t = 1;
	for (int j = 0; j <= n; j++)
	{
		if (j != k)
		{
			r = (x - mx[j]) / (mx[k] - mx[j]);
			t *= r;
		}
	}
	return t;
}

double ln(double x, int n)
{
	double r = 0;
	for (int k = 0; k <= n; k++)
	{
		r += my[k] * lnk(x, k, n);
	}
	return r;
}

int main()
{
	double start = clock();
	ifstream in("input.txt");
	ofstream out("output.txt");
	/*int n, N;
	in >> n >> N;
	for (int i = 0; i <= n; i++)
	in >> mx[i];
	for (int i = 0; i <= n; i++)
	in >> my[i];
	for (int i = 0; i <= N; i++)
	in >> s[i];
	for (int i = 0; i <= N; i++)
	w[i] = ln(s[i],n);
	out.precision(6);
	out << fixed;
	for (int i = 0; i <= N; i++)
	out << w[i] << " ";*/
	int n, N;
	in >> n >> N;
	double a = 0, b = M_PI;
	for (int i = 0; i <= n; i++)
	{
		mx[i] = i * b / n;
	}
	for (int i = 0; i <= n; i++)
	{
		my[i] = sin(mx[i]);
	}
	for (int i = 0; i <= N; i++)
	{
		s[i] = i * b / N;
	}
	for (int i = 0; i <= N; i++)
		w[i] = ln(s[i], n);
	/***double er = M_PI / 1000;
	double e = 0;
	for (int i = 0; i < N; i ++)
	{
		wx[i] = e;
		e += er;
	}
	for (int i = 0; i <= N; i++)
		out << "(" << wx[i] << ";" << w[i] << ")" << endl;*////
	

	/*for (int i = 0; i <= N; i++)
		mm[i] = abs(sin(s[i]) - ln(s[i], n));
	double max = INT_MIN;
	for (int i = 0; i <= N; i++)
		if (max <= mm[i])
			max = mm[i];
	out.precision(10);
	out << fixed;
	out << max << endl;
	for (int i = 0; i <= N; i++)
		out << mm[i] << endl;****/
	out.precision(10);
	out << fixed;
	for (int i = 0; i <= N; i++)
		out << w[i] << " ";
	double end = clock();
	out << "\nTime:" << (end - start) / 10.0 << " msec";
	return 0;
}