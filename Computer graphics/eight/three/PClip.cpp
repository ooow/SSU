// Вариант 1: алгоритм Лианга-Барски
#pragma once
#include "stdafx.h"
#include "Transform.h"
#include <math.h>

using namespace std;
using namespace System::Drawing;

polygon^ PClip (polygon^ P, point Pmin, point Pmax) {
	polygon^ P1 = gcnew polygon(0);
	int k = 0;

	point p1 = P[P->Count - 1];
	point p2;

	point in, out, tin, tout;
	float t1out, t2in, t2out;

	while (k < P->Count) 
	{  
		p2 = P[k];

		float dx = p2.x - p1.x,
			dy = p2.y - p1.y;

		if (dx > 0 || dx == 0 && p1.x > Pmax.x) 
		{
			in.x = Pmin.x;
			out.x = Pmax.x;
		} else 
		{
			in.x = Pmax.x;
			out.x = Pmin.x;
		}

		if (dy > 0 || dy == 0 && p1.y > Pmax.y) 
		{
			in.y = Pmin.y;
			out.y = Pmax.y;
		} else {
			in.y = Pmax.y;
			out.y = Pmin.y;
		}

		if (dx != 0) 
		{
			tout.x = (out.x - p1.x) / dx;
		} 
		else 
			if (p1.x >= Pmin.x && p1.x <= Pmax.x) 
			{
				tout.x = float::MaxValue;
			} 
			else 
			{
				tout.x = float::MinValue;
			}

			if (dy != 0) 
			{
				tout.y = (out.y - p1.y) / dy;
			} 
			else 
				if (p1.y >= Pmin.y && p1.y <= Pmax.y) 
				{
					tout.y = float::MaxValue;
				} 
				else 
				{
					tout.y = float::MinValue;
				}


				if (tout.x < tout.y) 
				{
					t1out = tout.x;
					t2out = tout.y;
				} 
				else 
				{
					t1out = tout.y;
					t2out = tout.x;
				}

				if (t2out > 0) 
				{

					if (dx != 0) 
					{
						tin.x = (in.x - p1.x) / dx;
					} 
					else 
					{
						tin.x = float::MinValue;
					}

					if (dy != 0) 
					{
						tin.y = (in.y - p1.y) / dy;
					}
					else 
					{
						tin.y = float::MinValue;
					}

					if (tin.x < tin.y) 
					{
						t2in = tin.y;
					} 
					else 
					{
						t2in = tin.x;
					}

					if (t1out < t2in) 
					{
						if (t1out > 0 && t1out <= 1) 
						{
							if (tin.x < tin.y) 
							{
								point z;
								z.x = out.x;
								z.y = in.y;
								P1->Add(z);
							} 
							else 
							{
								point z;
								z.x = in.x;
								z.y = out.y;
								P1->Add(z);
							}
						}

					} 
					else 
						if (t1out > 0 && t2in <= 1) 
						{
							if (t2in >= 0) 
							{
								if (tin.x > tin.y) 
								{	
									point z;
									z.x = in.x;
									z.y = p1.y + tin.x * dy;
									P1->Add(z);
								} 
								else 
								{
									point z;
									z.x = p1.x + tin.y * dx;
									z.y = in.y;
									P1->Add(z);
								}
							}
							if (t1out <= 1) 
							{
								if (tout.x < tout.y) 
								{
									point z;
									z.x = out.x;
									z.y = p1.y + tout.x * dy;
									P1->Add(z);
								} 
								else 
								{
									point z;
									z.x = p1.x + tout.y * dx;
									z.y = out.y;
									P1->Add(z);
								}
							} 
							else 
							{
								P1->Add(p2);
							}
						}

						if (t2out > 0 && t2out <= 1) 
						{
							P1->Add(out);
						}
				}
				k = k + 1;
				p1 = p2;
	}

	return P1;
}

void Pfill (polygon^ P, System::Drawing::Bitmap^ image, System::Drawing::Color C){

	Graphics^ g = Graphics::FromImage(image);
	vector<vector<float>> S;
	point a, b;	
	S.resize(P->Count);
	for (int i = 0; i < S.size(); i++)
		S[i].resize(4);
	// 1
	// формируем список S
	if (P->Count != 0) {
		a = P[P->Count - 1];
		for ( int j = 0; j < P->Count; j++)
		{
			b = P[j];
			bool flag = 0;
			if (a.y > b.y)
			{
				swap(a,b);
				flag = 1;
			}
			S[j][0] = System::Math::Round(a.x);
			S[j][1] = System::Math::Round(a.y);
			S[j][2] = System::Math::Round(b.x);
			S[j][3] = System::Math::Round(b.y);
			if (!flag)
				a = b;
		}
	}
	// сортировка S
	for (int i = S.size() - 1; i >= 0; i--)
	{
		for (int j = 0; j < i; j++)
		{
			if (S[j][1] > S[j+1][1])
			{
				swap(S[j],S[j+1]);
			}
		}
	}
	int ymin = 999999;
	int ymax = -999999;
	// находим ymim
	for ( int i = 0 ; i< P->Count; i++)
	{
		a = P[i];
		if ( a.y < ymin )
			ymin = System::Math::Round(a.y);
	}
	// находим ymax
	for ( int i = 0 ; i< P->Count; i++)
	{
		a = P[i];
		if ( a.y > ymax )
			ymax = System::Math::Round(a.y);
	}
	// 3 - 4 
	vector<vector<float>> AEL;
	int yt = ymin;
	int ySnext = ymin;
	int yAELnext;
	// 4
	while ( yt <= ymax )
	{	
		if ( yt == ySnext )
		{	
			vector <float> DUB;
			DUB.resize(3);
			for (int i = 0; i < S.size(); i ++)
			{
				float x1 = S[i][0];
				float y1 = S[i][1];
				float x2 = S[i][2];
				float y2 = S[i][3];
				if ( (y1 == yt ) && (y1 != y2) ){
					DUB[0] = x1;
					DUB[1] = y2;
					DUB[2] = ( (x2-x1) / (y2-y1) );
					AEL.push_back(DUB);
				}
			}
			// 5
			for (int i = 0; i < S.size(); i ++)
			{
				float x1 = S[i][0];
				float y1 = S[i][1];
				float x2 = S[i][2];
				float y2 = S[i][3];
				if ((y1 == yt) && (y1 == y2)){
					g ->DrawLine(gcnew Pen(C, 2), x1, y1, x2, y2);
				}
			}
			// 6
			for (int i = 0; i < S.size(); i ++)
			{
				float y1 = S[i][1];
				if (y1 == yt){
					S.erase(S.begin() + i);
					i--;
				}
			}
			// 7
			ySnext =  999999;
			for (int i = 0; i < S.size(); i ++)
			{
				float y1 = S[i][1];
				if ( ySnext > y1 )
					ySnext = y1;
			}
			// 8
			// сортировка AEL
			for (int i = AEL.size() - 1; i >= 0; i--)
			{
				for (int j = 0; j < i; j++)
				{
					if (AEL[j][2] > AEL[j+1][2])
					{
						swap(AEL[j],AEL[j+1]);
					}
				}
			}
			for (int i = AEL.size() - 1; i >= 0; i--)
			{
				for (int j = 0; j < i; j++)
				{
					if (AEL[j][0] > AEL[j+1][0])
					{
						swap(AEL[j],AEL[j+1]);
					}
				}
			}

			yAELnext = 999999;
			for (int i = 0; i < AEL.size(); i++)
				if ( AEL[i][1] != yt )
					if ( yAELnext > AEL[i][1] )
						yAELnext = AEL[i][1];
		}
		//9
		for ( int i = 1; i < AEL.size(); i+=2)
		{
			g->DrawLine(gcnew Pen(C, 2),AEL[i-1][0], float(yt),AEL[i][0], float(yt));
		}
		for (int j = 0; j < AEL.size(); j++)
			AEL[j][0] = AEL[j][0] + AEL[j][2];
		yt++;

		if ( yt >= yAELnext )
		{
			for (int j = 0; j < AEL.size(); j++)
				if (AEL[j][1] <= yt )
				{
					AEL.erase(AEL.begin() + j);
					j--;
				}
				for (int j = 0; j < AEL.size(); j++)
					if (( yAELnext > AEL[j][1] ) && ( AEL[j][1] != yt ))
						yAELnext = AEL[j][1];
		}
	}
}
void Goga (polygon^ P, System::Drawing::Bitmap^ image, System::Drawing::Color C){
	Graphics^ g = Graphics::FromImage(image);
	point a,b;
	int xx=0, yy=0;
	float r =1 ;
	while ( r > 0){
		for ( int i = 1; i< P->Count; i++){
			a = P[i-1];
			b = P[i];
			if (i <= P->Count/2)
			{	
				g->DrawLine(gcnew Pen(C, 2), a.x+xx, a.y+yy, b.x+xx, b.y-yy);
			}
			else
			{
				g->DrawLine(gcnew Pen(C, 2), a.x-xx, a.y-yy, b.x-xx, b.y+yy);
			}
			a = b;
			xx++;
			yy++;
			r = b.x - xx;
		}
	}
}