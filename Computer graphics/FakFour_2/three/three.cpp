// three.cpp: ������� ���� �������.

#include "stdafx.h"
#include <fstream>
#include <sstream>
#include <algorithm>
#include <vector>
#include <math.h>
#include "Transform.h"
#include "Clip.h"
#include "Form1.h"


using namespace three;

[STAThreadAttribute]
int main(array<System::String ^> ^args)
{
	// ��������� ���������� �������� Windows XP �� �������� �����-���� ��������� ����������
	Application::EnableVisualStyles();
	Application::SetCompatibleTextRenderingDefault(false); 

	// �������� �������� ���� � ��� ������
	Application::Run(gcnew Form1());
	return 0;
}
