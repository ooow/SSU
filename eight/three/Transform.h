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

void times(mat a, mat b, mat &c); // умножает a на b, где a и b — это матрицы и результат записывает в c
void timesMatVec(mat a, vec b, vec &c); // умножает a на b, где a — это матрица, а b - это вектор, и результат записывает в c
void set(mat a, mat &b); // переписывает матрицу a в матрицу b
void point2vec(point a, vec &b); // преобразует декартовы координаты точки, заданные структурой типа point
// в однородные координаты, заданные вектором vec
void vec2point(vec a, point &b); // делает обратное преобразование процедуре point2vec
void makeHomogenVec(float x, float y, vec &c); // преобразует координаты x и y в вектор однородных координат
void unit(mat &a); // преобразует свой аргумент в единичную матрицу
void move(float Tx, float Ty, mat &c); // преобразуют аргумент c в матрицу преобразования переноса
void rotate(float x,float y,float phi, mat &c); // преобразуют аргумент c в матрицу преобразования поворота
void scale(float S, mat &c);  // преобразуют аргумент c в матрицу преобразования масштабирования
void increase(float x, float y, float z, mat &c); // преобразуют аргумент c в матрицу преобразования масштабирования относительно x, y
void mirror (float x, float y, mat &c); // зеркальное отображение относительно y
void frame (float Vx, float Vy, float Vcx, float Vcy, float Wx, float Wy, float Wcx, float Wcy, mat &c);
void scalef(float Sx, float Sy, mat &c);
void mirrorf (float x, float y, mat &c);
