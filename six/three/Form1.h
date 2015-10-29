#pragma once


namespace three {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

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
		System::Collections::Generic::List<line> lines; /* ����� �� ������� ������ lines, ������ ������� 
														�������� � ������� ���� line. � ���������� ����� ������������, ��� � ���� ������ ��������� ����� 
														�������� ��� ����������� */
		float left, right, top, bottom;
		float Wcx, Wcy, Wx, Wy;
		float Vcx, Vcy, Vx, Vy;
		bool drawNames;
		float clientRectangleHeight, clientRectangleWidth;

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
			this->Text = L"Six";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &Form1::Form1_Paint);
			this->Resize += gcnew System::EventHandler(this, &Form1::Form1_Resize);
			this->KeyDown += gcnew System::Windows::Forms::KeyEventHandler(this, &Form1::Form1_KeyDown);
			this->ResumeLayout(false);

		}
#pragma endregion
		private: void DrawFigure(Graphics^ g, Pen^ pen) {
					 g->DrawRectangle(pen, -30, -20 , 60 ,40);
					 int mas[28][4] = {
						 {60, 60, 60, 300}, 
						 {60, 60, 360, 60},
						 {60, 300, 360, 300},
						 {360, 300, 360, 60},
						 {60, 300, 210, 450}, 
						 {210, 450, 360, 300}, 
						 {120, 360, 120, 420},
						 {120, 420, 150, 420}, 
						 {150, 420, 150, 390}, 
						 {120, 240, 180, 240}, 
						 {120, 210, 180, 210}, 
						 {120, 150, 180, 150}, 
						 {120, 150, 120, 240},
						 {150, 150, 150, 240},
						 {180, 150, 180, 240},
						 {240, 240, 300, 240},
						 {240, 210, 300, 210},
						 {240, 150, 300, 150},
						 {240, 150, 240, 240},
						 {270, 150, 270, 240},
						 {300, 150, 300, 240},
						 {360, 60, 480, 60},
						 {480, 60, 480, 75},
						 {480, 75, 450, 75},
						 {450, 75, 450, 90},
						 {450, 90, 420,90},
						 {420, 90, 420, 210},
						 {420, 210, 360, 240}};
				
				for (int i = 0; i < 28; i++) {
					g->DrawLine(pen, 
						(float)((mas[i][0] - 270) * 0.102564102564102564), 
						(float)((mas[i][1] - 255) * 0.102564102564102564), 
						(float)((mas[i][2] - 270) * 0.102564102564102564), 
						(float)((mas[i][3] - 255) * 0.102564102564102564));
				}
		}

	private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
				 lines.Clear(); // � ������ ������ ���������� ������� ������ �������� (����� ������ ������)
				 unit (T); // �������������� ������� T ��� ������� ����������
				 Rectangle rect = Form::ClientRectangle;
				 top = 70;
				 left = 50;
				 right = 50;
				 bottom = 50;

				 clientRectangleHeight = Form::ClientRectangle.Height;
			     clientRectangleWidth  = Form::ClientRectangle.Width;

				 Wcx = left;
				 Wcy = Form::ClientRectangle.Height - bottom;
				 Wx = Form::ClientRectangle.Width - left - right;
				 Wy = Form::ClientRectangle.Height - top - bottom;
				 drawNames = false;

			 }
	private: System::Void Form1_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) {
				 Graphics^ g = e->Graphics;
				 Pen^ rectPen = gcnew Pen(Color::Crimson); 
				 rectPen->Width = 4;

				 Rectangle rect = System::Drawing::Rectangle(Wcx, top, Wx, Wy);
				 g->DrawRectangle(rectPen, rect);
				 g->Clip = gcnew System::Drawing::Region(rect);

				 Pen^ blackPen = gcnew Pen(Color::Black);
				 blackPen->Width = 0.1;

				 for (int i = 0; i < matrices.size(); i++) {
					 g->Transform = gcnew System::Drawing::Drawing2D::Matrix(
						 T[0][0], T[1][0],
						 T[0][1], T[1][1],
						 T[0][2], T[1][2]);
					 mat �;
					 times(T, matrices[i], �);
					 g->Transform = gcnew System::Drawing::Drawing2D::Matrix(
						 �[0][0], �[1][0],
						 �[0][1], �[1][1],
						 �[0][2], �[1][2]);
					 DrawFigure(g, blackPen);
					/* float namex = (lines[i].start.x + lines[i].end.x) / 2, namey = (lines[i].start.y + lines[i].end.y) / 2;
					 if (drawNames) {
					 System::Drawing::Font^ drawFont = gcnew System::Drawing::Font( "Arial", 9);
					 SolidBrush^ drawBrush = gcnew SolidBrush(Color::Red);
					 g->DrawString(lines[i].name, drawFont, drawBrush, namex, namey);
					 }*/
				 }
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
							 matrices.clear();
							 std::stack<mat> matStack;			 
							 mat K;
							 unit(K);
							 unit(T);
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
										 else if ( cmd == "figure" ) {
											 matrices.push_back(K);
										 } 
										 else if ( cmd == "pushTransform" ) {
											 matStack.push(K);
										 } 
										 else if ( cmd == "popTransform" ) {
											 K = matStack.top();
											 matStack.pop();
										 } 
										 else if ( cmd == "translate" ) {
											 int x, y;
											 s >> x >> y;
											 mat C, C1;
											 move(x, y, C);
											 times(K, C, C1);
											 K = C1;
										 } 
										 else if ( cmd == "scale" ) {
											 float xx;
											 s >> xx;
											 mat C, C1;
											 scale(xx, C);
											 times(K, C, C1);
											 K = C1;
										 } 
										 else if ( cmd == "rotate" ) {
											 float Phi;
											 s >> Phi;
											 float pi = 3.1415926535;
											 float PhiR = Phi * (pi / 180);
											 mat C, C1;
											 rotate(0,0, PhiR, C);
											 times(K, C, C1);
											 K = C1;
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
				 clientRectangleHeight = Form::ClientRectangle.Height;
			     clientRectangleWidth  = Form::ClientRectangle.Width;
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
