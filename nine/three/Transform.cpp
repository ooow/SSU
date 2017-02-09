#pragma once
#include "stdafx.h"
#include "Transform.h"
#include <math.h>

mat T;
mat F;
mat3D Z;

std::vector<mat> matrices(0);
std::vector<mat3D> matrices3D(0);

//////////////////// 2D \\\\\\\\\\\\\\\\\\\\\

void point2vec(point a, vec &b) {
	b[0] = a.x; 
	b[1] = a.y; 
	b[2] = 1;
}

void vec2point(vec a, point &b) {
	b.x = ((float) a[0]) / a[2];
	b.y = ((float) a[1]) / a[2];
}

void makeHomogenVec(float x, float y, vec &c){
	c[0] = x; 
	c[1] = y; 
	c[2] = 1;
}

void unit(mat &a) {
	for (int i = 0; i < M; i++) {
		for (int j = 0; j < M; j++) {
			if (i == j) {
				a[i][j] = 1;
			}
			else {
				a[i][j] = 0;
			}
		}
	}
}

void set(mat a, mat &b) {
	for (int i = 0; i < M; i++) {
		for (int j = 0; j < M; j++) {
			b[i][j] = a[i][j];
		}
	}
}

void times(mat a, mat b, mat &c) {
	for (int i = 0; i < M; i++) {
		for (int j = 0; j < M; j++) {
			float scalar = 0;
			for (int k = 0; k < M; k++)
				scalar += a[i][k] * b[k][j];
			c[i][j] = scalar;
		}
	}
}

void timesMatVec(mat a, vec b, vec &c) {
	for (int i = 0; i < M; i++) {
		float skalaar = 0;
		for (int j = 0; j < M; j++)
			skalaar += a[i][j] * b[j];
		c[i] = skalaar;
	}
}

void move(float Tx, float Ty, mat &c) {
	unit (c);
	c[0][M-1] = Tx;
	c[1][M-1] = Ty;
}

void rotate(float phi, mat &c) {
	unit (c);
	c[0][0] = cos(phi); 
	c[0][1] = -sin(phi);
	c[1][0] = sin(phi); 
	c[1][1] = cos(phi);
}

void scale(float S, mat &c) {
	unit (c);
	c[0][0] = S; c[1][1] = S;
}

void scale(float Sx, float Sy, mat &c) {
	c[0][0] = Sx; 
	c[1][1] = Sy;
}

void reflect(bool aboutVert, bool aboutHor, mat &c) {
	unit (c);
	scale(aboutVert? -1 : 1, aboutHor? -1 :1, c);
}

void frame(float Vx, float Vy, float Vcx, float Vcy,
			float Wx, float Wy, float Wcx, float Wcy,
			mat &c) {
	mat tmp, tmp1;
	unit(c);

	move(- Vcx, - Vcy, tmp);
	times(tmp, c, tmp1);
	set(tmp1, c);

	scale(Wx / Vx, Wy / Vy, tmp);
	times(tmp, c, tmp1);
	set(tmp1, c);

	reflect(0, 1, tmp);
	times(tmp, c, tmp1);
	set(tmp1, c);

	move(Wcx, Wcy, tmp);
	times(tmp, c, tmp1);
	set(tmp1, c);
}

//////////////////// 3D \\\\\\\\\\\\\\\\\\\\\

void set (point3D a, point &b) {
	b.x = a.x;
	b.y = a.y;
}

void point2vec(point3D a, vec3D &b) {
	b[0] = a.x;
	b[1] = a.y;
	b[2] = a.z;
	b[3] = 1;
}

void vec2point (vec3D a, point3D &b) {
	b.x = ((float) a[0]) / a[3];
	b.y = ((float) a[1]) / a[3];
	b.z = ((float) a[2]) / a[3];
}

void normalize(vec3D &a) {
	float non = sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2]);
	if (non) {
		a[0] /= non;
		a[1] /= non;
		a[2] /= non;
	}
}

void unit (mat3D &a) {
	for (int i = 0; i < M1; i++) {
		for (int j = 0; j < M1; j++) {
			if (i == j) a[i][j] = 1;
			else       a[i][j] = 0;
		}
	}
}

void set(mat3D a, mat3D &b) {
	for(int i = 0; i < M1; i++)
		for (int j = 0; j < M1; j++)
			b[i][j] = a[i][j];
}

void times (mat3D a, mat3D b, mat3D &c) {
	for (int i = 0; i < M1; i++) {
		for (int j = 0; j < M1; j++) {
			float scalar = 0;
			for (int k = 0; k < M1; k++)
				scalar += a[i][k] * b[k][j];
			c[i][j] = scalar;
		}
	}
}

void timesMatVec (mat3D a, vec3D b, vec3D &c) {
	for(int i = 0; i < M1; i++) {
		float scalar = 0;
		for(int j = 0; j < M1; j++)
			scalar += a[i][j] * b[j];
		c[i] = scalar;
	}
}

void move (float Tx, float Ty, float Tz, mat3D &c) {
	unit(c);
	c[0][M1 - 1] = Tx;
	c[1][M1 - 1] = Ty;
	c[2][M1 - 1] = Tz;
}

void rotate (point3D n, float phi, mat3D &c)
{
	unit (c);
	c[0][0] = cos(phi) + (pow((n.x), 2) * (1 - cos(phi))); 
	c[0][1] = n.x * n.y * (1 - cos(phi)) - n.z * sin(phi);
	c[0][2] = n.x * n.z * (1 - cos(phi)) + n.y * sin(phi);
	c[1][0] = n.x * n.y * (1 - cos(phi)) + n.z * sin(phi);    
	c[1][1] = cos(phi) + n.y * n.y * (1 - cos(phi));      
	c[1][2] = n.y * n.z * (1 - cos(phi)) - n.x * sin(phi);
	c[2][0] = n.x * n.z * (1 - cos(phi)) - n.y * sin(phi);   
	c[2][1] = n.y * n.z * (1 - cos(phi)) + n.x * sin(phi); 
	c[2][2] = cos(phi) + n.z * n.z * (1 - cos(phi));
}

void LookAt (point3D eye, point3D center, point3D up, mat3D &c) {
	mat3D R1;
	move(-eye.x, -eye.y, -eye.z, R1);
	vec3D b, b1, u;	
	point2vec(eye, b);
	point2vec(center, b1);
	point2vec(up, u);
	vec3D e1, e2, e3;
	e3[0] = b[0] - b1[0];
	e3[1] = b[1] - b1[1];
	e3[2] = b[2] - b1[2];
	e3[3] = 1;
	normalize(e3);
	e1[0] = u[1] * e3[2] - u[2] * e3[1];
	e1[1] = u[2] * e3[0] - u[0] * e3[2];
	e1[2] = u[0] * e3[1] - u[1] * e3[0];
	e1[3] = 1;
	normalize(e1);
	e2[0] = e3[1] * e1[2] - e3[2] * e1[1];
	e2[1] = e3[2] * e1[0] - e3[0] * e1[2];
	e2[2] = e3[0] * e1[1] - e3[1] * e1[0];
	e2[3] = 1;
	mat3D R2;
	unit(R2);
	R2[0][0] = e1[0]; R2[0][1] = e1[1]; R2[0][2] = e1[2];
	R2[1][0] = e2[0]; R2[1][1] = e2[1]; R2[1][2] = e2[2];
	R2[2][0] = e3[0]; R2[2][1] = e3[1]; R2[2][2] = e3[2];
	times(R2, R1, c);
}

void Perspective (float fovy, float aspect, float near, float far, mat3D &c) {
	unit(c);
	c[0][0] = 1.0 / (aspect * tan(fovy / 2));
	c[1][1] = 1.0 / tan(fovy / 2);
	c[2][2] = (far + near) / (far - near);
	c[2][3] = 2 * far * near / (far - near);
	c[3][2] = -1;
	c[3][3] = 0;
}

void Ortho (float Vx, float Vy, float near, float far, mat3D &c) {
	unit(c);
	c[0][0] = 2.0 / Vx;
	c[1][1] = 2.0 / Vy;
	c[2][2] = 2.0 / (far - near);
	c[2][3] = (far + near) / (far - near);
}