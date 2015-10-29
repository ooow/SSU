#include <array>
#include <vector>
#include <math.h>

#define M 3 
typedef std::tr1::array<float, M> vec;
typedef std::tr1::array<vec, M> mat;
extern mat T;
extern mat T2;
extern std::vector<mat> matrices;

value struct point {
	float x, y;

	point(float x, float y) {
		this->x = x;
		this->y = y;
	}
};
value struct line { 
	point start, end; 
	System::String^ name; 
};
typedef System::Collections::Generic::List<point> polygon;

value struct rebro { 
	point a, b; 
};

typedef System::Collections::Generic::List<rebro> spisok;

void times(mat a, mat b, mat &c); // �������� a �� b, ��� a � b � ��� ������� � ��������� ���������� � c
void timesMatVec(mat a, vec b, vec &c); // �������� a �� b, ��� a � ��� �������, � b - ��� ������, � ��������� ���������� � c
void set(mat a, mat &b); // ������������ ������� a � ������� b
void point2vec(point a, vec &b); // ����������� ��������� ���������� �����, �������� ���������� ���� point
// � ���������� ����������, �������� �������� vec
void vec2point(vec a, point &b); // ������ �������� �������������� ��������� point2vec
void makeHomogenVec(float x, float y, vec &c); // ����������� ���������� x � y � ������ ���������� ���������
void unit(mat &a); // ����������� ���� �������� � ��������� �������
void move(float Tx, float Ty, mat &c); // ����������� �������� c � ������� �������������� ��������
void rotate(float x,float y,float phi, mat &c); // ����������� �������� c � ������� �������������� ��������
void scale(float S, mat &c);  // ����������� �������� c � ������� �������������� ���������������
void increase(float x, float y, float z, mat &c); // ����������� �������� c � ������� �������������� ��������������� ������������ x, y
void mirror (float x, float y, mat &c); // ���������� ����������� ������������ y
void frame (float Vx, float Vy, float Vcx, float Vcy, float Wx, float Wy, float Wcx, float Wcy, mat &c);
void scalef(float Sx, float Sy, mat &c);
void mirrorf (float x, float y, mat &c);
