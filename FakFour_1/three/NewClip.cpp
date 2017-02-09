#pragma once
#include "stdafx.h"
#include <algorithm>
#include "Transform.h"
#include "NewClip.h"
#include <math.h>
using namespace std;

bool newclip(point &a, point &b, polygon^ P) 
{	
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
		point n;
		vec nr;
		vec A10;
		n.x = b1.x - a1.x;
		n.y = b1.y - a1.y;
		point2vec(n, nr);
		point b11;
		rotate(0, 0, 1.57079633, T2);
		timesMatVec(T2, nr, A10);
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
		V.x = a.x;  
		V.y = a.y;

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