#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <cmath>
#include <vector>
#include <fstream>
#include <algorithm>

using namespace std;
int n;

vector<long double>A;	vector<long double>B;
vector<long double>a;	vector<long double>b;
vector<long double>c;	vector<long double>d;
vector<long double>x;

void get_A()
{
	A[0] = 0.0;
	for (int i = 1; i < n - 1; i++)
		A[i] = (-1.0)*c[i] / (A[i - 1] * a[i] + b[i]);
}

void get_B()
{
	B[0] = 0.0;
	for (int i = 1; i < n - 1; i++)
		B[i] = (d[i] - B[i - 1] * a[i]) / (A[i - 1] * a[i] + b[i]);
}

void get_X()
{
	x[0] = 0.0;
	x[n - 1] = 0.0;
	for (int i = n - 2; i > 0; i--)
		x[i] = A[i] * x[i + 1] + B[i];
}

int main()
{
	freopen("input.txt", "r", stdin);
	freopen("output.txt", "w", stdout);
	cin >> n;	n++;
	A.resize(n);	B.resize(n);
	a.resize(n);	b.resize(n);
	c.resize(n);	d.resize(n);
	for (int i = 1; i < n - 1; i++)
		cin >> a[i] >> b[i] >> c[i] >> d[i];
	x.resize(n);
	get_A();	get_B();	get_X();
	cout.precision(10);
	cout << fixed;
	for (int i = 1; i < n - 1; i++)
		cout << x[i] << ' ';
	return 0;
}