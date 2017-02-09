#include "stdafx.h"
#include "for_oop.h"


Biblioteka B;
Spisok B1;
Zakaz K1;
Kniga K;
vector<int> N1;
vector<int> N2;

string STs (System::String^ S)
{
	string s1, s;
	for (int i = 0; i < S->Length; i++)
	{
		s1 = S[i];
		s += s1;
	}
	return s;
}
System::String^ sTS (string s, System::Windows::Forms::Label^ l)
{
	l->Text = gcnew System::String(s.c_str());
	System::String ^r = System::Convert::ToString(l->Text);
	l->Text = "";
	return r;

}
bool ravno( Kniga k1, Zakaz k2)
{
	if ( k1.name == k2.name )
		if ( k1.avtor == k2.avtor )
			if ( k1.age == k2.age )
				return true;
			else
				return false;
		else
			return false;
	else
		return false;
}
int sTi(std::string n) {
    std::stringstream str;
	str << n;
	int ret;
    str >> ret;
	return ret;
}
string iTs(int n) {
    std::stringstream str;
    str << n;
	string ret;
	str >> ret;
    return ret;
}