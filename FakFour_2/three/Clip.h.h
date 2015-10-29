const int K = 6;
float massiv[8];

void Clip1Left (float massiv[], float dxl, float dx, float dy);
void Clip1Top (float massiv[], float dyt, float dx, float dy);
void Clip1Bottom (float massiv[], float dyb,float dx,float dy);
void Clip2Right (float massiv[], float dxr,float dx, float dy);
void Clip2Top (float massiv[], float dyt,float dx, float dy);
void Clip2Bottom (float massiv[], float dyb,float dx,float dy);
bool cut(float massiv[]);
void initMassiv(float x, float y, float x2, float y2, float x_min,
				float y_min, float x_max, float y_max, float massiv[8]);