#include "stdafx.h"
#include <algorithm>
#include "Transform.h"
#include <math.h>

using namespace std;

bool skalclip(point a, point b, polygon^ P) 
{	
	vector <point> w;
	int n = P->Count;
	for ( int i = 1; i < P->Count; i ++)
	{
		w[i].x = P[i].x - P[i-1].x; 
		w[i].y = P[i].y - P[i-1].y; 
	}
	w[0].x = P[0].x - P[n-1].x; 
	w[0].y = P[0].y - P[n-1].y; 
	int i = 1;
	int k = 0;
	bool specialCase = true;
	point v, v1;
	v.x = P[n-1].x - a.x;
	v.y = P[n-1].y - a.y;
	point E;
	E.x = (b.x - a.x) * v.x;
	E.y = (b.y - a.y) * v.y;
	while ( (i < n) && (k != 2) )
	{
		v1.x = P[i].x - a.x;
		v1.y = P[i].y - a.y;
		point N;
		N.x = (b.x - a.x) * v1.x;
		N.y = (b.y - a.y) * v1.y;
		bool pointFound = false;
		point C;
		C.x = E.x * N.x;
		C.y = E.y * N.y;
		if ( (E.x * N.x) + 
	}



	float tmin = 0, tmax = 1;
	bool visible = true;
	int n = P->Count;
	for (int i = 0; i < n; i++)
	{
		point a1,b1;
		if ( i == 0)
		{
			a1 = P[P->Count-1];
			b1 = P[0];
		}
		else
		{
			a1 = P[i-1];
			b1 = P[i];
		}

		vec A10, B10;
		point b11;
		rotate(a1.x,a1.y,1.57079633,T2);
		point2vec(b1, B10);
		timesMatVec(T2, B10, A10);
		vec2point(A10, b11);	
		point N;
		N.x = b11.x;
		N.y = b11.y;

		float Px = b.x - a.x;
		float Py = b.y - a.y;
		float Pi, Qi; 
		Pi = Px * N.x + Py * N.y;
		point F;
		F.x = a1.x;
		F.y = a1.y;	

		point V;
		V.x = a.x + (b.x - a.x);  
		V.y = a.y + (b.y - a.y);

		Qi = (V.x - F.x) * N.x + (V.y - F.y) * N.y;
		if (Pi == 0) 
		{ 
			if (Qi < 0){
				visible = false;
				return visible;
			}
		}
		else {
			if (Pi > 0)
				tmin = max(tmin, - Qi / Pi); 
			else
				tmax = min(tmax, - Qi / Pi);
			if (tmin > tmax)
			{
				visible = false;
				return visible;
			}
		}
	}
	if (visible)
	{
		float X1, Y1, X2, Y2;
		X1 = a.x + (b.x - a.x) * tmin;  
		Y1 = a.y + (b.y - a.y) * tmin;
		X2 = a.x + (b.x - a.x) * tmax;
		Y2 = a.y + (b.y - a.y) * tmax;
		a.x = X1;
		a.y = Y1;
		b.x = X2;
		b.y = Y2;
		return visible;
	}
}