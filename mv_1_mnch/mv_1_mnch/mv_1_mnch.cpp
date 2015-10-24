#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <vector>
#include <iomanip>
using namespace std;

vector <long double> x;
vector <long double> a;
int n;

void Pn(int i, int nk, int k, int endi, long double p)
{
	if (nk == k)
	{
		a[i] += p;
		return;
	}
	if (endi == n - 1)
		return;
	for (int j = endi + 1; j < n; j++)
		Pn(i, nk, k + 1, j, p * x[j]);
}
int main()
{
	freopen("input.txt", "r", stdin);
	freopen("output.txt", "w", stdout);
	cin >> n;
	x.resize(n);
	for (int i = 0; i < n; i ++)
		cin >> x[i];
	a.resize(n);
	for (int i = 0; i < n; i ++)
		Pn(i, i + 1, 0, -1, 1);
	long double m = -1;
	cout.fixed;
	cout.precision(10);
	for (int i = 0; i < n; i ++)
	{
		cout << a[i]  *  m << ' ';
		m *= -1;
	}
	return 0;
}