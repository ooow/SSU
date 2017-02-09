#include "stdafx.h"
#include <string>
#include <sstream>
#include <vector>

using namespace std;

string STs (System::String^ S);
System::String^ sTS (string s, System::Windows::Forms::Label^ l);

class Kniga{
public:
	string id, 
		name,
		avtor,
		age,
		temat,
		nn,
		prace,
		stavka;
	void read_book(System::Windows::Forms::DataGridView^ D, int i, Kniga &K)
	{
		for ( int j = 0; j < 8; j ++)
		{
			string str;
			System::String^ ss;
			ss = System::Convert::ToString(D->Rows[i]->Cells[j]->Value);
			str = STs(ss);
			if ( j == 0 )
				K.id = str;
			if ( j == 1 )
				K.name = str;
			if ( j == 2 )
				K.avtor = str;
			if ( j == 3 )
				K.age = str;
			if ( j == 4 )
				K.temat = str;
			if ( j == 5 )
				K.nn = str;
			if ( j == 6 )
				K.prace = str;
			if ( j == 7 )
				K.stavka = str;
		}
	}
	void print_book(System::Windows::Forms::DataGridView^ D, int i, Kniga K)
	{
		if (D->Rows->Count < i)
			D->Rows->Add(1);
		for ( int j = 0; j < 8; j ++)
		{

			if ( j == 0 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.id.c_str()));
			if ( j == 1 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.name.c_str()));
			if ( j == 2 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.avtor.c_str()));
			if ( j == 3 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.age.c_str()));
			if ( j == 4 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.temat.c_str()));
			if ( j == 5 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.nn.c_str()));
			if ( j == 6 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.prace.c_str()));
			if ( j == 7 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.stavka.c_str()));
		}
	}
};
class Zakaz{
public:
	string id, 
		name,
		avtor,
		age,
		prace,
		nn;
	void read_zakaz(System::Windows::Forms::DataGridView^ D, int i, Zakaz &K)
	{
		for ( int j = 0; j < 6; j ++)
		{
			string str;
			System::String^ ss;
			ss = System::Convert::ToString(D->Rows[i]->Cells[j]->Value);
			str = STs(ss);
			if ( j == 0 )
				K.id = str;
			if ( j == 1 )
				K.name = str;
			if ( j == 2 )
				K.avtor = str;
			if ( j == 3 )
				K.age = str;
			if ( j == 4 )
				K.prace = str;
			if ( j == 5 )
				K.nn = str;
		}
	}
	void print_zakaz(System::Windows::Forms::DataGridView^ D, int i, Zakaz K)
	{
		if (D->Rows->Count < i)
			D->Rows->Add(1);
		for ( int j = 0; j < 6; j ++)
		{
			if ( j == 0 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.id.c_str()));
			if ( j == 1 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.name.c_str()));
			if ( j == 2 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.avtor.c_str()));
			if ( j == 3 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.age.c_str()));
			if ( j == 4 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.prace.c_str()));
			if ( j == 5 )
				D->Rows[i]->Cells[j]->Value = (gcnew System::String(K.nn.c_str()));
		}
	}
};
class Biblioteka {
private:
	struct tBiblioteka{
		Kniga inf;
		tBiblioteka *next;
		tBiblioteka *prev;
	};

	tBiblioteka *h, *t;

public:
	Biblioteka(){
		h = t = NULL;
	}

	void Add(Kniga x){
		tBiblioteka*r = new tBiblioteka;
		r->inf = x;
		r->next = NULL;
		if (!h){
			r->prev = NULL; h = r;
		}
		else {
			t->next = r; r->prev = t;
		}
		t = r;
	}

	void Clear(){
		tBiblioteka*r;
		while (h) {
			r = h;
			if (r == t) h = t = NULL;
			else {
				h = h->next; h->prev = NULL;
			}
			delete r;
		}
	}
	Kniga pop(){
		tBiblioteka *r = h;
		Kniga i = r->inf;
		h = r->next;
		h->prev = NULL;
		delete r;
		return i;

	}
	int empty_Biblioteka(){
		return (h&&t) ? 0 : 1;
	}
};
class Spisok {
private:
	struct tSpisok{
		Zakaz inf;
		tSpisok *next;
		tSpisok *prev;
	};

	tSpisok *h, *t;

public:
	Spisok(){
		h = t = NULL;
	}

	void Add(Zakaz x){
		tSpisok*r = new tSpisok;
		r->inf = x;
		r->next = NULL;
		if (!h){
			r->prev = NULL; h = r;
		}
		else {
			t->next = r; r->prev = t;
		}
		t = r;
	}

	void Clear(){
		tSpisok*r;
		while (h) {
			r = h;
			if (r == t) h = t = NULL;
			else {
				h = h->next; h->prev = NULL;
			}
			delete r;
		}
	}
	Zakaz pop(){
		tSpisok *r = h;
		Zakaz i = r->inf;
		h = r->next;
		h->prev = NULL;
		delete r;
		return i;

	}
	int empty_Spisok(){
		return (h&&t) ? 0 : 1;
	}
};



extern Spisok B1;
extern Biblioteka B;
extern Zakaz K1;
extern Kniga K;
extern vector<int> N1;
extern vector<int> N2;

bool ravno( Kniga k1, Zakaz k2);
int sTi(std::string n);
string iTs(int n);