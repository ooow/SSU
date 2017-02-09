#pragma once
#include "stdafx.h"
#include <algorithm>
#include "Transform.h"
#include "Clip.h"

using namespace std;

void Clip1Left( point &a, float dx, float dy, float dxl) {

	a.y = a.y + dxl * (dy / dx);
	a.x = a.x + dxl;
}

void Clip1Top( point &a, float dx, float dy, float dyt) {

	a.x = a.x + dyt * (dx / dy);
	a.y = a.y + dyt;
}

void Clip1Bottom( point &a, float dx, float dy, float dyb) {

	a.x = a.x + dyb * (dx / dy);
	a.y = a.y + dyb;
}

void Clip2Right(point &a, point &b, float dx, float dy, float dxr) {

	b.y = a.y + dxr * (dy / dx);
	b.x = a.x + dxr;
}

void Clip2Top(point &a, point &b, float dx, float dy, float dyt) {

	b.x = a.x + dyt * (dx / dy);
	b.y = a.y + dyt;
}

void Clip2Bottom(point &a, point &b, float dx, float dy, float dyb) {

	b.x = a.x + dyb * (dx / dy);
	b.y = a.y + dyb;
}

bool clip (point &a, point &b, point Pmin, point Pmax) {

	float xmin = Pmin.x, ymin = Pmin.y;
	float xmax = Pmax.x, ymax = Pmax.y;
//1
	if (a.x > b.x) {
		swap(a.x, b.x);
		swap(a.y, b.y);
	}
//2
	int C1 = 0, C2 = 0;
	if (a.x < xmin) C1 += 1;
	if (a.x > xmax) C1 += 2;
	if (a.y < ymin) C1 += 4;
	if (a.y > ymax) C1 += 8;
	if (b.x < xmin) C2 += 1;
	if (b.x > xmax) C2 += 2;
	if (b.y < ymin) C2 += 4;
	if (b.y > ymax) C2 += 8;
//3
	if (C1 & C2) return false;
//4
	if (C1 == 0) {
		if (C2 == 0) 
			return true;
		float dx = b.x - a.x, dy = b.y - a.y;

		if (dy >= 0) {
			float dxr = xmax - a.x, dyt = ymax - a.y;

			if (dy * dxr < dx * dyt){
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxr = xmax - a.x;
				Clip2Right( a, b, dx, dy, dxr);
			}
			else {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dyt = ymax - a.y;
				Clip2Top(a, b, dx, dy, dyt);
			}
			return true;
		}
		if (dy < 0) {
			float dxr = xmax - a.x, dyb = ymin - a.y;

			if (dy * dxr < dx * dyb) {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dyb = ymin - a.y;
				Clip2Bottom(a, b, dx, dy, dyb);
			}
			else {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dyr = xmax - a.x;
				Clip2Right(a, b, dx, dy, dxr);
			}
			return true;
		}
	}
//5
	if (C1 == 1) {
		float dx = b.x - a.x, dy = b.y- a.y;
		float dxl = xmin - a.x, dyt = ymax - a.y;
		point a1 = a;

		if (C2 == 0) { 
			float dx = b.x - a.x;
			float dy = b.y - a.y;
			float dxl = xmin - a.x;
			Clip1Left(a, dx, dy, dxl); 
			return true; 
		}
		if (dy >= 0) {
			if (dy * dxl > dx * dyt) 
				return false;
			float dxr = xmax - a.x; dyt = ymax - a.y;

			if (dy * dxr < dx * dyt) {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxr = xmax - a.x;
				Clip2Right(a, b, dx, dy, dxr);
			}
			else {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dyt = ymax - a.y;
				Clip2Top(a, b, dx, dy, dyt);
			}
			float dx = b.x - a.x;
			float dy = b.y - a.y;
			float dxl = xmin - a.x;
			Clip1Left(a, dx, dy, dxl);
			return true;
		}
		if (dy < 0) {
			dxl = xmin - a.x; float dyb = ymin - a.y;

			if (dy * dxl < dx * dyb) 
				return false;
			float dxr = xmax - a.x; dyb = ymin - a.y;
			a = a;

			if (dy * dxr < dx * dyb){
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dyb = ymin - a.y;
				Clip2Bottom(a, b, dx, dy, dyb);
			}
			else {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxr = xmax - a.x;
				Clip2Right(a, b, dx, dy, dxr);
			}
			float dx = b.x - a.x;
			float dy = b.y - a.y;
			float dxl = xmin - a.x;
			Clip1Left(a, dx, dy, dxl);
			return true;
		}
	}
//6
	if (C1 == 4) {
		float dx = b.x - a.x, dy = b.y - a.y;
		float dxr = xmax - a.x, dyb = ymin - a.y;

		if (C2 == 0) {
			float dx = b.x - a.x;
			float dy = b.y - a.y;
			float dyb = ymin - a.y;
			Clip1Bottom(a, dx, dy, dyb);
			return true;
		}
		if (dy > 0) {
			if (dy * dxr < dx * dyb) 
				return false;
			float dyt = ymax - a.y;

			if (dy * dxr < dx * dyt){
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxr = xmax - a.x;
				Clip2Right(a, b, dx, dy, dxr);
			}
			else {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dyt = ymax - a.y;
				Clip2Top(a, b, dx, dy, dyt);
			}
			float dx = b.x - a.x;
			float dy = b.y - a.y;
			float dyb = ymin - a.y;
			Clip1Bottom(a, dx, dy, dyb);
			return true;
		}
		if (dy <= 0) return false;
	}
//7
	if (C1 == 5) {
		float dx = b.x - a.x, dy = b.y - a.y;

		if (dy > 0) {
			float dxl = xmin - a.x, dyt = ymax - a.y;

			if (dy * dxl > dx * dyt) 
				return false;
			float dxr = xmax - a.x, dyb = ymin - a.y;

			if (dy * dxr < dx * dyb) 
				return false;
			if (dyb * dxr < dxl * dyt) {
				if (dy * dxl < dx * dyb) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dyb = ymin - a.y;
					Clip1Bottom(a, dx, dy, dyb);
					if (b.x > xmax) {
						float dx = b.x - a.x;
						float dy = b.y - a.y;
						float dxr = xmax - a.x;
						Clip2Right(a, b, dx, dy, dxr);
					}
					return true;
				}
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxl = xmin - a.x;
				Clip1Left(a, dx, dy, dxl);
				if (C2 == 0) 
					return true;
				if (dy * dxr < dx * dyt && C2 != 0) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dxr = xmax - a.x;
					Clip2Right(a, b, dx, dy, dxr);
					return true;
				}
				dx = b.x - a.x;
				dy = b.y - a.y;
				float dyt = ymax - a.y;
				Clip2Top(a, b, dx, dy, dyt);
				return true;
			} 
			else {
				if (dy * dxr < dx * dyt) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dyb = ymin - a.y;
					Clip1Bottom(a, dx, dy, dyb);
					if (b.x > xmax) {
						float dx = b.x - a.x;
						float dy = b.y - a.y;
						float dxr = xmax - a.x;
						Clip2Right(a, b, dx, dy, dxr);
					}
					return true;
				}
				if (dy * dxl < dx * dyb) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dyb = ymin - a.y;
					Clip1Bottom(a, dx, dy, dyb);
					if (C2 != 0) {
						float dx = b.x - a.x;
						float dy = b.y - a.y;
						float dyt = ymax - a.y;
						Clip2Top(a, b, dx, dy, dyt);
					}
					return true;
				}
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxl = xmin - a.x;
				Clip1Left(a, dx, dy, dxl);
				if (C2 == 0) 
					return true;
				dx = b.x - a.x;
				dy = b.y - a.y;
				float dyt = ymax - a.y;
				Clip2Top(a, b, dx, dy, dyt);
				return true;
			}
		}
		if (dy <= 0) return false;
	}
//8
	if (C1 == 8) {
		float dx = b.x - a.x, dy = b.y - a.y;
		float dxr = xmax - a.x, dyt = ymax - a.y;

		if (C2 == 0) {
			float dx = b.x - a.x;
			float dy = b.y - a.y;
			float dyt = ymax - a.y;
			Clip1Top(a, dx, dy, dyt);
			return true;
		}
		if (dy < 0) {
			if (dy * dxr > dx * dyt) 
				return false;
			float dyb = ymin - a.y;

			if (dy * dxr > dx * dyb) {
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxr = xmax - a.x;
				Clip2Right(a, b, dx, dy, dxr);
			}
			else{
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dyb = ymin - a.y;
				Clip2Bottom(a, b, dx, dy, dyb);
			}
			float dx = b.x - a.x;
			float dy = b.y - a.y;
			float dyt = ymax - a.y;
			Clip1Top(a, dx, dy, dyt);
			return true;
		} 
		if (dy >= 0) 
			return false;
	}
//9
	if (C1 == 9) {
		float dx = b.x - a.x, dy = b.y - a.y;

		if (dy < 0) {
			float dxr = xmax - a.x, dyt = ymax - a.y;

			if (dy * dxr > dx * dyt) 
				return false;
			float dxl = xmin - a.x, dyb = ymin - a.y;

			if (dy * dxl < dx * dyb) 
				return false;
			if (dyt * dxr > dxl * dyb) {
				if (dy * dxl > dx * dyt) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dyt = ymax - a.y;
					Clip1Top(a, dx, dy, dyt);
					if (b.x > xmax){
						float dx = b.x - a.x;
						float dy = b.y - a.y;
						float dxr = xmax - a.x;
						Clip2Right(a, b, dx, dy, dxr);
					}
					return true;
				}
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxl = xmin - a.x;
				Clip1Left(a, dx, dy, dxl);
				if (C2 == 0) 
					return true;
				if (dy * dxr > dx * dyb) {
					float dx = b.x - a.x;

					float dy = b.y - a.y;
					float dxr = xmax - a.x;
					Clip2Right(a, b, dx, dy, dxr);
					return true;
				}
				dx = b.x - a.x;
				dy = b.y - a.y;
				float dyb = ymin - a.y;
				Clip2Bottom(a, b, dx, dy, dyb);
				return true;
			} else {
				if (dy * dxr > dx * dyb) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dyt = ymax - a.y;
					Clip1Top(a, dx, dy, dyt);
					if (b.x > xmax) {
						float dx = b.x - a.x;
						float dy = b.y - a.y;
						float dxr = xmax - a.x;
						Clip2Right(a, b, dx, dy, dxr);
					}
					return true;
				}
				if (dy * dxl > dx * dyt) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dyt = ymax - a.y;
					Clip1Top(a, dx, dy, dyt);
					if (C2 != 0) {
						float dx = b.x - a.x;
						float dy = b.y - a.y;
						float dyb = ymin - a.y;
						Clip2Bottom(a, b, dx, dy, dyb);
					}
					return true;
				}
				float dx = b.x - a.x;
				float dy = b.y - a.y;
				float dxl = xmin - a.x;
				Clip1Left(a, dx, dy, dxl);
				if (C2 != 0) {
					float dx = b.x - a.x;
					float dy = b.y - a.y;
					float dyb = ymin - a.y;
					Clip2Bottom(a, b, dx, dy, dyb);
				}
				return true;
			}
		} 
		if (dy >= 0) 
			return false;
	}
}