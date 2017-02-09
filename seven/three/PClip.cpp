#include "stdafx.h"
#include "Transform.h"

using namespace std;

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