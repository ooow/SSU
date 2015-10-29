#pragma once
#include "stdafx.h"
#include "Transform.h"
#include <math.h>
#include <algorithm>
#include <iostream>

mat T;
mat T2;
std::vector<mat> matrices(0);

void times(mat a, mat b, mat &c) {
	for(int i = 0; i < M; i++) {
		for(int j = 0; j < M; j++) {
			float skalaar = 0;
			for(int k = 0; k < M; k++)
				skalaar += a[i][k] * b[k][j];
			c[i][j] = skalaar;
		}
	}
}

void timesMatVec(mat a, vec b, vec &c) {
	for(int i = 0; i < M; i++) {
		float skalaar = 0;
		for(int j = 0; j < M; j++)
			skalaar += a[i][j] * b[j];
		c[i] = skalaar;
	}
}
void set(mat a, mat &b) {
	for(int i = 0; i < M; i++)
		for (int j = 0; j < M; j++)
			b[i][j] = a[i][j];
}

void point2vec(point a, vec &b) {
	b[0] = a.x; b[1] = a.y; b[2] = 1;
}

void vec2point(vec a, point &b) {
	b.x = ((float)a[0])/a[2];
	b.y = ((float)a[1])/a[2];
}

void makeHomogenVec(float x, float y, vec &c){
	c[0] = x; c[1] = y; c[2] = 1;
}

void unit(mat &a) {
	for (int i = 0; i < M; i++) {
		for (int j = 0; j < M; j++) {
			if (i == j) a[i][j] = 1;
			else a[i][j] = 0;
		}
	}
}

void move(float Tx, float Ty, mat &c) {
	unit (c);
	c[0][2] = Tx;
	c[1][2] = Ty;
}

void rotate(float x,float y,float phi, mat &c) {
	unit (c);
	c[0][0] = cos(phi); c[0][1] = -sin(phi);
	c[1][0] = sin(phi); c[1][1] = cos(phi);
	c[0][2] = -x * (cos(phi)-1) + y * sin(phi);
	c[1][2] = -y * (cos(phi)-1) - x * sin(phi);
}

void scale(float S, mat &c) {
	unit (c);
	c[0][0] = S; c[1][1] = S;
}
void scalef(float Sx, float Sy, mat &c) {
	unit (c);
	c[0][0] = Sx; c[1][1] = Sy;
}
void increase(float x, float y, float z, mat &c){
	if ( z == 1 )
	{
		c[0][2] = -x*(1.1)+x;
		c[1][2] = -y*(1.1)+y;
	}
	if ( z == -1 )
	{
		c[0][2] = -x*(1/1.1)+x;
		c[1][2] = -y*(1/1.1)+y;
	}
	if ( z == 2 )
	{
		c[0][0] = 1;
		c[1][2] = -y*(1/1.1)+y;
	}
	if ( z == -2 )
	{
		c[0][0] = 1;
		c[1][2] = -y*(1.1)+y;
	}
	if ( z == -3 )
	{	
		c[1][1] = 1;
		c[0][2] = -y*(1/1.1)+y;
	}
	if ( z == 3 )
	{
		c[1][1] = 1;
		c[0][2] = -y*(1.1)+y;
	}
}
void mirror (float x, float y, mat &c){
	if ( x == 1)
	{
		unit (c);
		c[1][1] = -1;
		c[1][2] = y;
	}
	if (x == -1)
	{
		unit (c);
		c[0][0] = -1;
		c[0][2] = y;
	}
}
void mirrorf (float x, float y, mat &c){
	unit (c);
	if ( x )
	{
		c[1][1] = -1;
	}
	if ( y )
	{
		c[0][0] = -1;
	}
}
void frame (float Vx, float Vy, float Vcx, float Vcy, float Wx, float Wy, float Wcx, float Wcy, mat &c){
	unit(c);
	mat R, t;
	///
	move(-Vcx, -Vcy, R);
	times(R, c, t);
	set(t,c);
	///
	scalef(Wx / Vx, Wy / Vy, R);
	times(R, c, t);
	set(t,c);
	///
	mirrorf( 1, 0, c);
	times(R, c, t);
	set(t,c);
	///
	move(Wcx, Wcy, R);
	times(R, c, t);
	set(t,c);
}
