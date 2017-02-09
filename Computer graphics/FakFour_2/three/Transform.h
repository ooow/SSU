#include "stdafx.h"
#include <vector>

#define M 3 // M � ������� ������ �������������� (� ��� ��������� ��������������, ������� ������� ����� ������� 3)
typedef float vec[M]; // �������� ����������� ��� ����� ������ �������� ����������� M
typedef float mat[M][M]; // �������� ����������� ��� ����� ������ ������ ����������� M


value struct point { //�������� ��������� ��� ��������� �����
	float x, y;
};

value struct line { //�������� ��������� ��� ���������� �������
	point start, end; // start � end � ����� ������ � ����� �������
	System::String^ name; // name � �������� �������
};

extern mat T; // T � ������� ������������ �������������� ��� ������ ����������
extern mat T1;
extern mat T2;
typedef System::Collections::Generic::List<point> polygon;

void times(mat a, mat b, mat c); // �������� a �� b, ��� a � b � ��� ������� � ��������� ���������� � c
void timesMatVec(mat a, vec b, vec c); // �������� a �� b, ��� a � ��� �������, � b - ��� ������, � ��������� ���������� � c
void set(mat a, mat b); // ������������ ������� a � ������� b
void point2vec(point a, vec b); // ����������� ��������� ���������� �����, �������� ���������� ���� point
// � ���������� ����������, �������� �������� vec
void vec2point(vec a, point &b); // ������ �������� �������������� ��������� point2vec
void makeHomogenVec(float x, float y, vec c); // ����������� ���������� x � y � ������ ���������� ���������
void unit(mat a); // ����������� ���� �������� � ��������� �������
void move(float Tx, float Ty, mat c); // ����������� �������� c � ������� �������������� ��������
void rotate(float x,float y,float phi, mat c); // ����������� �������� c � ������� �������������� ��������
void scale(float S, mat c);  // ����������� �������� c � ������� �������������� ���������������
void increase(float x, float y, float z, mat c); // ����������� �������� c � ������� �������������� ��������������� ������������ x, y
void mirror (float x, float y, mat c); // ���������� ����������� ������������ y
void frame (float Vx, float Vy, float Vcx, float Vcy, float Wx, float Wy, float Wcx, float Wcy, mat c);
void scalef(float Sx, float Sy, mat c);
void mirrorf (float x, float y, mat c);
bool skalclip(point a, point b, polygon^ P) ;