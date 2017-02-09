#include "stdafx.h"
#include <array>
#include <vector>
#include <math.h>
#define M 3 
#define M1 4

typedef std::tr1::array<float, M> vec;
typedef std::tr1::array<vec, M> mat;

extern mat T;
extern mat F;

typedef std::tr1::array<float, M1> vec3D; 
typedef std::tr1::array<vec3D, M1> mat3D; 
extern mat3D Z;

extern std::vector<mat> matrices;
extern std::vector<mat3D> matrices3D;

value struct point {
	float x, y;

	point(float x, float y) 
	{
		this->x = x;
		this->y = y;
	}
};
value struct point3D 
{
	 float x, y, z;
};
value struct line { 
	point start, end; 
	System::String^ name; 
};
typedef System::Collections::Generic::List<point> polygon;
typedef System::Collections::Generic::List<point3D>  polygon3D;



//////////////////// 2D \\\\\\\\\\\\\\\\\\\\\

void unit(mat &a);
void point2vec(point a, vec &b);
void vec2point(vec a, point &b);
void makeHomogenVec(float x, float y, vec &c);
void set(mat a, mat &b);
void times(mat a, mat b, mat &c);
void timesMatVec(mat a, vec b, vec &c);
void move(float Tx, float Ty, mat &c);
void rotate(float phi, mat &c);
void scale(float S, mat &c);
void scale(float Sx, float Sy, mat &c);
void frame(float Vx, float Vy, float Vcx, float Vcy,
		   float Wx, float Wy, float Wcx, float Wcy,
		   mat &c);

/////////////////// 3D \\\\\\\\\\\\\\\\\

void set (point3D a, point &b);
void point2vec(point3D a, vec3D &b);
void vec2point (vec3D a, point3D &b);
void normalize(vec3D &a);
void unit (mat3D &a);
void set(mat3D a, mat3D &b);
void times (mat3D a, mat3D b, mat3D &c);
void timesMatVec (mat3D a, vec3D b, vec3D &c);
void move (float Tx, float Ty, float Tz, mat3D &c);
void rotate (point3D n, float phi, mat3D &c);
void LookAt (point3D eye, point3D center, point3D up, mat3D &c);
void Perspective (float fovy, float aspect, float near, float far, mat3D &c);
void Ortho (float Vx, float Vy, float near, float far, mat3D &c);