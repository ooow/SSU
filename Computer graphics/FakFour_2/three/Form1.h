#pragma once


namespace three {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	using namespace std;

	/// <summary>
	/// ������ ��� Form1
	///
	/// ��������! ��� ��������� ����� ����� ������ ���������� ����� ��������
	///          �������� ����� ����� �������� ("Resource File Name") ��� �������� ���������� ������������ �������,
	///          ���������� �� ����� ������� � ����������� .resx, �� ������� ������� ������ �����. � ��������� ������,
	///          ������������ �� ������ ��������� �������� � ���������������
	///          ���������, ��������������� ������ �����.
	/// </summary>
	public ref class Form1 : public System::Windows::Forms::Form
	{
	public:
		Form1(void)
		{
			InitializeComponent();
			//
			//TODO: �������� ��� ������������
			//
		}

	protected:
		/// <summary>
		/// ���������� ��� ������������ �������.
		/// </summary>
		~Form1()
		{
			if (components)
			{
				delete components;
			}
		}
	private:
		System::Collections::Generic::List<polygon^> polygons;
		System::Collections::Generic::List<line> lines;

		float left, right, top, bottom;
		float Wcx, Wcy, Wx, Wy;
		float Vcx, Vcy, Vx, Vy;
		bool drawNames;		
		bool stop;

	private: System::Windows::Forms::OpenFileDialog^  openFileDialog;
	private: System::Windows::Forms::Button^  btnOpen;


	private:
		/// <summary>
		/// ��������� ���������� ������������.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// ������������ ����� ��� ��������� ������������ - �� ���������
		/// ���������� ������� ������ ��� ������ ��������� ����.
		/// </summary>
		void InitializeComponent(void)
		{
			this->openFileDialog = (gcnew System::Windows::Forms::OpenFileDialog());
			this->btnOpen = (gcnew System::Windows::Forms::Button());
			this->SuspendLayout();
			// 
			// openFileDialog
			// 
			this->openFileDialog->DefaultExt = L"txt";
			this->openFileDialog->FileName = L"openFileDialog1";
			this->openFileDialog->Filter = L"��������� ����� (*.txt)|*.txt|��� ����� (*.*)|*.*";
			this->openFileDialog->Title = L"������� ����";
			// 
			// btnOpen
			// 
			this->btnOpen->Location = System::Drawing::Point(12, 12);
			this->btnOpen->Name = L"btnOpen";
			this->btnOpen->Size = System::Drawing::Size(75, 23);
			this->btnOpen->TabIndex = 0;
			this->btnOpen->Text = L"�������";
			this->btnOpen->UseVisualStyleBackColor = true;
			this->btnOpen->Click += gcnew System::EventHandler(this, &Form1::btnOpen_Click);
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(600, 480);
			this->Controls->Add(this->btnOpen);
			this->DoubleBuffered = true;
			this->KeyPreview = true;
			this->MinimumSize = System::Drawing::Size(600, 480);
			this->Name = L"Form1";
			this->Text = L"Four";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &Form1::Form1_Paint);
			this->Resize += gcnew System::EventHandler(this, &Form1::Form1_Resize);
			this->KeyDown += gcnew System::Windows::Forms::KeyEventHandler(this, &Form1::Form1_KeyDown);
			this->ResumeLayout(false);
		}
#pragma endregion
	private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
				 lines.Clear(); // � ������ ������ ���������� ������� ������ �������� (����� ������ ������)
				 unit (T); // �������������� ������� T ��� ������� ����������
				 unit(T1);
				 Rectangle rect = Form::ClientRectangle;
				 top = 70;
				 left = 50;
				 right = 50;
				 bottom = 50;

				 Wcx = left;
				 Wcy = Form::ClientRectangle.Height - bottom;
				 Wx = Form::ClientRectangle.Width - left - right;
				 Wy = Form::ClientRectangle.Height - top - bottom;
				 drawNames = false;
				 stop = false;
			 }
	private: System::Void Form1_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) {
				 Graphics^ g = e->Graphics;

				 Pen^ rectPen = gcnew Pen(Color::Snow); 
				 rectPen->Width = 4;
				 Pen^ normPen = gcnew Pen(Color::Red); 
				 normPen->Width = 2;
				 Pen^ greenPen = gcnew Pen(Color::Green); 
				 greenPen->Width = 2;

				 Pen^ blackPen = gcnew Pen(Color::Black);
				 blackPen->Width = 4;

				 Rectangle rect = Form::ClientRectangle;
				 point Pmin, Pmax;
				 Pmax.x = Form::ClientRectangle.Width  - right;
				 Pmax.y = Form::ClientRectangle.Height - bottom;
				 Pmin.x = left;
				 Pmin.y = top;
				 polygon^ P1 = gcnew polygon(0);

				 for (int i = 0; i < polygons.Count; i++) 
				 {
					 polygon^ p = polygons[i];
					 point a, b;
					 vec A, B;
					 for (int j = 0; j < p->Count; j++) {
						 point2vec(p[j], A);
						 timesMatVec(T1, A, B);
						 vec2point(B, a);
						 P1->Add(a);
					 }
					 if (P1->Count != 0) {
						 a = P1[P1->Count - 1];
						 for (int j = 0; j < P1->Count; j++) {
							 b = P1[j];
							 g->DrawLine(rectPen, a.x, a.y, b.x, b.y);
							 a = b;
						 }
					 }
				 }
				 for (int i = 0; i < lines.Count; i++) {
					 // ������ ����� ����� ������� ��������� � ������ ���������� ���������
					 vec A, B;	 
					 point2vec(lines[i].start, A);
					 point2vec(lines[i].end, B);
					 vec A1, B1;
					 // �������� � ��� �������������� T
					 // ������� ����� � ���������� ����������� A1 � B1
					 timesMatVec(T,A,A1); 
					 timesMatVec(T,B,B1);
					 // ��������� ���������� ���������� ������� � ��������� �������
					 point a, b;
					 vec2point(A1, a);
					 vec2point(B1, b);
					 // ��������� ������� � ���������� �����������
					 if (skalclip(a, b, P1))
					 {
						 g->DrawLine(blackPen, a.x, a.y, b.x, b.y);
					 }
				 }
				 /*newclip1(P1);
				 for (int i = 0; i < S1.Count; i++) {
					 point a, b;
					 a = S1[i].start;
					 b = S1[i].end;
					 g->DrawLine(blackPen, a.x, a.y, b.x, b.y);
				 }*/
			 }
	private: System::Void btnOpen_Click(System::Object^  sender, System::EventArgs^  e) {
				 if ( this->openFileDialog->ShowDialog() ==  // ���������� ������ �������� �����
					 System::Windows::Forms::DialogResult::OK){ // � ���������, �������� �� �� ���� ������ 
						 //� ���������� ������� ������ OK
						 wchar_t fileName[1024]; // ���� ��, �� ���������� ������ �� ���������� �����
						 for (int i = 0; i < openFileDialog->FileName->Length; i++)
							 fileName[i] = openFileDialog->FileName[i];
						 fileName[openFileDialog->FileName->Length] = '\0';
						 // ������ ������� ���� � ��������� ��� �������� ��������
						 std::ifstream in;
						 in.open(fileName);
						 if ( in.is_open() ) { // ���� ���� ������ �������, �� ������� ������ lines, 
							 // ����� ���� ������ � ������������ ������ ������ �����
							 lines.Clear();
							 unit(T);
							 unit(T1);
							 std::string str;	
							 getline (in, str);
							 while (in) {
								 // ��� ������ ����������� ������ ������� �������� �������� � �� �������� ��
								 // ��� ������ ������� ��� ������� � �������������
								 if ((str.find_first_not_of(" \t\r\n") != std::string::npos)
									 && (str[0] != '#')) {
										 std::stringstream s(str);
										 std::string cmd;
										 s >> cmd;
										 if ( cmd == "frame" ) {
											 int cx, cy, x, y;
											 s >> cx >> cy >> x >> y;
											 Vx = x;
											 Vy = y;
											 Vcx = cx;
											 Vcy = cy;
											 frame (Vx, Vy, Vcx, Vcy, Wx, Wy, Wcx, Wcy, T);
										 } 
										 else if ( cmd == "line" ) {
											 line l;
											 s >> l.start.x >> l.start.y >> l.end.x >> l.end.y;
											 std::string linename;
											 s >> linename;
											 l.name = gcnew String(linename.c_str()); 
											 lines.Add(l); 
										 } 
										 else if ( cmd == "clip" ) 
										 {
											 int numpoint;
											 s >> numpoint;
											 polygon^ P = gcnew polygon(0);
											 for (int i = 0; i < numpoint; i++) {
												 point p;
												 s >> p.x >> p.y;
												 P->Add(p);
											 }
											 polygons.Add(P);
											 stop = true;
											 frame (Vx, Vy, Vcx, Vcy, Wx, Wy, Wcx, Wcy, T1);
										 }
								 }
								 getline (in, str); // �� ��������� ���������� ����� ������� �����
							 }
						 }
						 drawNames = false;
						 this->Refresh(); // ������� ����������� �� �����
				 }
			 }
	private: System::Void Form1_KeyDown(System::Object^  sender, System::Windows::Forms::KeyEventArgs^  e) {
				 Rectangle rect = Form::ClientRectangle;
				 mat R, T1; // ������ ������� �������������� � ��������������� ������� ��� ������ ����������
				 //������������ ������
				 switch(e->KeyCode){
					 // �������� ����������� �����
					 case Keys::W : 
						 move(0, -1, R);
						 break;

						 // �������� ����������� ����
					 case Keys::S : 
						 move(0, 1, R);
						 break;

						 // �������� ����������� �����
					 case Keys::A : 
						 move(-1, 0, R);
						 break;

						 // �������� ����������� ������
					 case Keys::D : 
						 move(1, 0, R);
						 break;

						 // ������� �� ������� �������
					 case Keys::E :
						 rotate(0, 0, 0.05, R);
						 break;

						 // ���������� ����������� � 1.1 ���� ������������ ������ ���������
					 case Keys::X : 
						 scale(1.1, R);
						 break;

						 // ������� ������ ������� �������
					 case Keys::Q : 
						 rotate(0, 0, -0.05, R);
						 break;

						 // ���������� ����������� � 1.1 ���� ������������ ������ ���������
					 case Keys::Z : 
						 scale(1/1.1, R);
						 break;

						 // ������� �������� ����������� �����
					 case Keys::T : 
						 move(0, -30, R);
						 break;

						 // ������� �������� ����������� ����
					 case Keys::G : 
						 move(0, 30, R);
						 break;

						 // ������� �������� ����������� �����
					 case Keys::F :
						 move(-30, 0, R); 
						 break;

						 // ������� �������� ����������� ������
					 case Keys::H :
						 move(30, 0, R); 
						 break;

						 // �������������� ��������������� �����������
					 case Keys::Escape : 
						 unit(T);
						 unit(R);
						 frame (Vx, Vy, Vcx, Vcy, Wx, Wy, Wcx, Wcy, T);
						 drawNames = false;
						 break;

						 // ������� ������ ������� ������� ������������ ������
					 case Keys::R :  
						 rotate(rect.Width/2,rect.Height/2,-0.05, R);
						 break;

						 //	������� �� ������� ������� ������������ ������
					 case Keys::Y :  
						 rotate(rect.Width/2,rect.Height/2,0.05, R);
						 break;

						 // ���������� ����������� ������������ ������������ ���
					 case Keys::J : 
						 mirror( 1, rect.Height, R);
						 break;

						 // ���������� ����������� ������������ �������������� ���
					 case Keys::U : 
						 mirror( -1, rect.Width, R);
						 break;

						 // ���������� ����������� ������������ ������ (1)
					 case Keys::V : 
						 scale(1.1, R);
						 increase(rect.Width/2, rect.Height/2, 1, R);
						 break;

						 // ���������� ����������� ������������ ������ (-1)
					 case Keys::C :
						 scale(1/1.1, R); 
						 increase(rect.Width/2, rect.Height/2, -1, R);
						 break;

						 // ���������� ����������� ������������ �������������� ��� (-2)
					 case Keys::I :
						 scale(1/1.1, R); 
						 increase(1, rect.Height/2, 2, R);
						 break;

						 // ���������� ����������� ������������  �������������� ��� (2)
					 case Keys::O :
						 scale(1.1, R); 
						 increase(1, rect.Height/2, -2, R);
						 break;

						 // ���������� ����������� ������������ ������������ ��� (-3)
					 case Keys::K :
						 scale(1/1.1, R); 
						 increase(1, rect.Width/2, -3, R);
						 break;

						 // ���������� ����������� ������������ ������������ ��� (3)
					 case Keys::L :
						 scale(1.1, R); 
						 increase(1, rect.Width/2, 3, R);
						 break;

						 // �������� ��������
					 case Keys::P :
						 unit(R);
						 drawNames = !drawNames;
						 break;
					 default :
						 unit(R);
				 }
				 times(R,T,T1);
				 set(T1, T);
				 this->Refresh();
			 }
	private: System::Void Form1_Resize(System::Object^  sender, System::EventArgs^  e) {
				 float oldWx = Wx, oldWy = Wy;
				 mat R, T1;
				 Wcx = left;
				 Wcy = Form::ClientRectangle.Height - bottom;
				 Wx = Form::ClientRectangle.Width - left - right;
				 Wy = Form::ClientRectangle.Height - top - bottom;
				 move(-Wcx, -top, R);
				 times(R, T, T1);
				 set(T1, T);
				 scalef(Wx/oldWx,Wy/oldWy, R);
				 times(R,T,T1);
				 set(T1, T);
				 move(Wcx, top, R);
				 times(R, T, T1);
				 set(T1, T);
				 this->Refresh();
			 }
	};
}
