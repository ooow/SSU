// three.cpp: ������� ���� �������.

#include "stdafx.h"
#include <fstream>
#include <sstream>
#include <math.h>
#include <vector>
#include <array>
#include "Transform.h"
#include "PClip.h"
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
