// five.cpp: ������� ���� �������.

#include "stdafx.h"

#include <fstream>
#include <sstream>
#include "Transform.h"
#include "Clip.h"
#include "Function.h"
#include "Form1.h"

using namespace five;

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
