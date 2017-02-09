#define _CRT_SECURE_NO_WARNINGS
#define M_PI       3.141592653589793238462
#include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>

using namespace std;

const long double eps = 1e-8;
int n;
int N;
vector<long double> mx;
vector<long double> my;
vector<long double> sm;
vector<long double> b;

long double l(long double s)
{
	long double rs;
	int j = upper_bound(mx.begin(), mx.end(), s - eps) - mx.begin();
	rs = my[j] + b[j] * (s - mx[j]);
	return rs;
}

int main()
{
	/*freopen("input.txt", "r", stdin);
	freopen("output.txt", "w", stdout);
	cin >> n;
	cin >> N;
	long double A, B;
	cin >> A >> B;
	mx.resize(n + 1);
	my.resize(n + 1);
	b.resize(n + 1);
	sm.resize(N + 1);
	for (int i = 0; i <= n; i++)
		mx[i] = A + (B - A) * i / (long double)(n);
	for (int i = 0; i <= n; i++)
		cin >> my[i];
	for (int i = 0; i <= N; i++)
		cin >> sm[i];
	b[0] = 0.0;
	for (int i = 1; i <= n; i++)
		b[i] = (my[i - 1] - my[i]) / (mx[i - 1] - mx[i]);
	cout.precision(10);
	cout << fixed;
	for (int i = 0; i <= N; i++)
		cout << l(sm[i]) << ' '; */

	freopen("input.txt", "r", stdin);
	freopen("output.txt", "w", stdout);
	cin >> n;
	cin >> N;
	long double A = 0;
	long double B = M_PI;
	mx.resize(n + 1);
	my.resize(n + 1);
	b.resize(n + 1);
	sm.resize(N + 1);
	for (int i = 0; i <= n; i++)
		mx[i] = A + (B - A) * i / (long double)(n);
	for (int i = 0; i <= n; i++)
		my[i] = sin(mx[i]);
	long double t = M_PI / N;
	long double t1 = 0;
	for (int i = 1; i < N; i++)
	{
		
		sm[i] = t1;
		t1 += t;
	}
	b[0] = 0.0;
	for (int i = 1; i <= n; i++)
		b[i] = (my[i - 1] - my[i]) / (mx[i - 1] - mx[i]);
	cout.precision(10);
	cout << fixed;
	for (int i = 0; i <= N; i++)
		cout << sm[i] << ";" << l(sm[i]) << endl;

	for (int i = 0; i <= N; i++)
		cout << sm[i] << ";" << sin(sm[i]) << endl;

	return 0;
}