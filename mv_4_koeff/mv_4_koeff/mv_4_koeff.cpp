#define _CRT_SECURE_NO_WARNINGS
#define M_PI       3.141592653589793238462
#include <iostream>
#include <vector>
#include <cmath>
#include <math.h>
#include <fstream>

using namespace std;
const long double eps = 1e-8;
int n;
vector <long double> mx;
vector <long double> my;
vector <long double> sm;

vector <long double> operator* (vector<long double> v, const long double a)
{
	for (int i = 0; i < n; ++i)
		v[i] *= a;
	return v;
}

vector <long double> operator/ (vector<long double> v, const long double a)
{
	for (int i = 0; i < n; ++i)
		v[i] /= a;
	return v;
}

vector <long double> operator+ (vector<long double> v, vector<long double> v1)
{
	vector <long double> rs(n);
	for (int i = 0; i < n; ++i)
		rs[i] = v[i] + v1[i];
	return rs;
}

vector <long double> operator* (vector<long double> &v, const pair<long double, long double>&x)
{
	vector <long double> rs = v;
	for (int i = 1; i < n; i++)
		rs[i] += (v[i - 1] * x.second);
	return rs;
}

long double get_den(int k)
{
	long double rs = 1.0;
	for (int j = 0; j < n; ++j)
		if (j != k)
			rs *= (mx[k] - mx[j]);
	return rs;
}

vector <long double> gn(int k)
{
	vector <long double> rs(n);
	rs[0] = 1.0;
	for (int j = 0; j < n; ++j)
		if (j != k)
			rs = rs * make_pair(1.0, mx[j] * (-1));
	return rs;
}

vector <long double> lnk(int k)
{
	long double den = get_den(k);
	vector <long double> num = gn(k);
	return num / den;
}

int main()
{
	freopen("input.txt", "r", stdin);
	freopen("output.txt", "w", stdout);
	cin >> n;
	n++;
	mx.resize(n);
	my.resize(n);
	sm.resize(n);
	for(int i = 0; i < n; ++i)
		cin >> mx[i];
	for(int i = 0; i < n; ++i)
		cin >> my[i];
	for (int i = 0; i < n; ++i)
		sm = sm + (lnk(i) * my[i]);

	cout.precision(10);
	cout << fixed;
	for(int i = 0; i < n; ++i)
		cout << sm[i] << ' ';
	return 0;
}