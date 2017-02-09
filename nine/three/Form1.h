#pragma once


namespace three {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Сводка для Form1
	///
	/// Внимание! При изменении имени этого класса необходимо также изменить
	///          свойство имени файла ресурсов ("Resource File Name") для средства компиляции управляемого ресурса,
	///          связанного со всеми файлами с расширением .resx, от которых зависит данный класс. В противном случае,
	///          конструкторы не смогут правильно работать с локализованными
	///          ресурсами, сопоставленными данной форме.
	/// </summary>
	public ref class Form1 : public System::Windows::Forms::Form
	{
	public:
		Form1(void)
		{
			InitializeComponent();
			//
			//TODO: добавьте код конструктора
			//
		}

	protected:
		/// <summary>
		/// Освободить все используемые ресурсы.
		/// </summary>
		~Form1()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Collections::Generic::List<line> lines;
	private: //System::Collections::Generic::List<polygon^> polygons; 
		System::Collections::Generic::List<polygon3D^> polygons;
		System::Collections::Generic::List<Color> colors;

		float left, right, top, bottom;
		float Wcx, Wcy, Wx, Wy;

		point3D eye, center, up, eyeS, centerS, upS;

		bool prOrtho;

		point3D OX, OY, OZ;

		float near, fovy, far, nearS, fovyS, farS, aspect, alpha;
		float Vy;
		float Vx;
		int cc;
		
	private: System::Windows::Forms::OpenFileDialog^  openFileDialog;
	private: System::Windows::Forms::Button^  btnOpen;
	private: System::Windows::Forms::Label^  label1;



	private:
		/// <summary>
		/// Требуется переменная конструктора.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Обязательный метод для поддержки конструктора - не изменяйте
		/// содержимое данного метода при помощи редактора кода.
		/// </summary>
		void InitializeComponent(void)
		{
			this->openFileDialog = (gcnew System::Windows::Forms::OpenFileDialog());
			this->btnOpen = (gcnew System::Windows::Forms::Button());
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->SuspendLayout();
			// 
			// openFileDialog
			// 
			this->openFileDialog->DefaultExt = L"txt";
			this->openFileDialog->FileName = L"openFileDialog1";
			this->openFileDialog->Filter = L"Текстовые файлы (*.txt)|*.txt|Все файлы (*.*)|*.*";
			this->openFileDialog->Title = L"Открыть файл";
			// 
			// btnOpen
			// 
			this->btnOpen->Location = System::Drawing::Point(12, 5);
			this->btnOpen->Name = L"btnOpen";
			this->btnOpen->Size = System::Drawing::Size(75, 23);
			this->btnOpen->TabIndex = 0;
			this->btnOpen->Text = L"Открыть";
			this->btnOpen->UseVisualStyleBackColor = true;
			this->btnOpen->Click += gcnew System::EventHandler(this, &Form1::btnOpen_Click);
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 9.75F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point, 
				static_cast<System::Byte>(204)));
			this->label1->ForeColor = System::Drawing::Color::Maroon;
			this->label1->Location = System::Drawing::Point(471, 12);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(0, 16);
			this->label1->TabIndex = 1;
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(600, 480);
			this->Controls->Add(this->label1);
			this->Controls->Add(this->btnOpen);
			this->DoubleBuffered = true;
			this->KeyPreview = true;
			this->MinimumSize = System::Drawing::Size(600, 480);
			this->Name = L"Form1";
			this->Text = L"Nine";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &Form1::Form1_Paint);
			this->Resize += gcnew System::EventHandler(this, &Form1::Form1_Resize);
			this->KeyDown += gcnew System::Windows::Forms::KeyEventHandler(this, &Form1::Form1_KeyDown);
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
	private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
				 polygons.Clear();
				 colors.Clear();
				 unit (T); // инициализируем матрицу T при запуске приложения
				 unit (Z);
				 unit(F);
				 Rectangle rect = Form::ClientRectangle;

				 top = 30;
				 left = 10;
				 right = 10;
				 bottom = 10;

				 Wcx = left;
				 Wcy = Form::ClientRectangle.Height - bottom;
				 Wx = Form::ClientRectangle.Width - left - right;
				 Wy = Form::ClientRectangle.Height - top - bottom;
				 aspect = Wx/Wy;
				 prOrtho = true;
				 alpha = 5 * Math::PI / 180;

				 OX.x = 1;	OY.x = 0;	OZ.x = 0;
				 OX.y = 0;	OY.y = 1;	OZ.y = 0;
				 OX.z = 0;	OY.z = 0;	OZ.z = 1;
				 centerS.x = 0;
				 centerS.y = 0;
				 centerS.z = 0;
				 cc = 0;
			 }
	private: System::Void Form1_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) {
				 Bitmap^ image1 = gcnew Bitmap( this->ClientRectangle.Width, this->ClientRectangle.Height);
				  Graphics^ g = Graphics::FromImage(image1);

				 Pen^ rectPen = gcnew Pen(Color::Gray); 
				 rectPen->Width = 3;
				 g->DrawRectangle(rectPen, Wcx, top, Wx, Wy);

				 Rectangle rect = Form::ClientRectangle;
				 Pen^ blackPen = gcnew Pen(Color::Black);
				 blackPen->Width = 2;

				 point Pmin, Pmax;
				 Pmax.x = Form::ClientRectangle.Width  - right;
				 Pmax.y = Form::ClientRectangle.Height - bottom;
				 Pmin.x = left;
				 Pmin.y = top;

				 mat3D V, U, R, Rs;

				 LookAt(eye, centerS, upS, V);

				 if(prOrtho) 
				 {
					 Vy = 2 * near * tan(fovy / 2);
					 Vx = Vy * aspect;
					 Ortho(Vx, Vy, near, far, U);
					 label1->Text = "Ортогональная";
					
				 }
				 else
				 {
					 Perspective(fovy, aspect, near, far, U);
					 label1->Text = "Перспективная";
				 }
				 times(U, V, Rs);
				 times(Rs, Z, R);
				 
				 frame(2, 2, -1, -1, Wx, Wy, Wcx, Wcy, F);


				 for (int i = 0; i < polygons.Count; i++) 
				 { 
					 polygon3D^ p = polygons[i];
					 polygon^ P1 = gcnew polygon(0);
					 point3D A;
					 point a1, a2, c;
					 vec b1, b2;
					 vec3D B1, B2;
					
					 for (int j = 0; j < p->Count; j++){
						 point2vec(p[j], B1);
						 timesMatVec(R, B1, B2);
						 vec2point(B2, A);
						 set(A, a1);

						 point2vec(a1, b1);
						 timesMatVec(F, b1, b2);
						 vec2point(b2, a2);
						 P1->Add(a2);
					 }
					 P1 = PClip(P1, Pmin, Pmax); 
					/*Pfill (P1, image1, colors[i]);*/
					 if(P1->Count)
					 { 
						 c = P1[P1->Count - 1];
						 for(int j=0; j < P1->Count; j++)
						 {
							 g ->DrawLine(gcnew Pen(colors[i], 2), c.x, c.y, P1[j].x, P1[j].y);
							 c = P1[j];
						 }
					 }
				 }
				 g = e->Graphics;
				 g->DrawImage(image1,0,0);
				 delete image1;
			 }
	private: System::Void btnOpen_Click(System::Object^  sender, System::EventArgs^  e) {
				 if ( this->openFileDialog->ShowDialog() ==  // показываем диалог открытия файла
					 System::Windows::Forms::DialogResult::OK){ // и проверяем, завершит ли он свою работу 
						 //в результате нажатия кнопки OK
						 wchar_t fileName[1024]; // Если да, то организуем чтение из выбранного файла
						 for (int i = 0; i < openFileDialog->FileName->Length; i++)
							 fileName[i] = openFileDialog->FileName[i];
						 fileName[openFileDialog->FileName->Length] = '\0';
						 // теперь откроем файл и проверяем его успешное открытие
						 std::ifstream in;
						 in.open(fileName);
						 if ( in.is_open() ) {
							 unit(T);
							 polygons.Clear();
							 colors.Clear();
							 Color RGB;
							 std::string str;	
							 getline (in, str);
							 while (in) {
								 if ((str.find_first_not_of(" \t\r\n") != std::string::npos)
									 && (str[0] != '#')) {
										 std::stringstream s(str);
										 std::string cmd;
										 s >> cmd;
										 if ( cmd == "triangle" ) { //методичка
											 polygon3D^ P = gcnew polygon3D(0);
											 for (int i = 0; i < 3; i++) {
												 point3D p;
												 s >> p.x >> p.y >> p.z;
												 P->Add(p);
											 }
											 polygons.Add(P);
											 cc++;
											 colors.Add(RGB);
										 }
										 if (cmd == "color") {	 
											 int R, G, B;
											 s >> R >> G >> B;
											 RGB = Color::FromArgb(R, G, B);
										 }
										 if (cmd == "lookat") {
											 int eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz;
											 s >> eyex >> eyey >> eyez >> centerx >> centery >> centerz >> upx >> upy >> upz;
											 eye.x = eyex;
											 eye.y = eyey;
											 eye.z = eyez;
											 center.x = centerx;
											 center.y = centery;
											 center.z = centerz;
											 up.x = upx;
											 up.y = upy;
											 up.z = upz;

											 eyeS = eye;
											 upS = up;
										 }
										 if (cmd == "screen") 
										 { 
											 int fovys, nears, fars;
											 s >> fovys >> nears >> fars;
											 fovy = fovys * Math::PI / 180;
											 near = nears;
											 far = fars;
											 fovyS = fovy;
											 nearS = near;
										 }
								 }
								 getline (in, str); // по окончании считывания файла закроем поток
							 }
						 }
						 LookAt(center, eye, upS, Z);
						 vec3D b;
						 point2vec(eye, b);
						 timesMatVec(Z, b, b);
						 eye.x = b[0];
						 eye.y = b[1];
						 eye.z = b[2];
						 this->Refresh(); // обновим изображение на форме
				 }
			 }
	private: System::Void Form1_KeyDown(System::Object^  sender, System::Windows::Forms::KeyEventArgs^  e) {
				 mat3D R; 
				 unit (R);
				 switch(e->KeyCode){

					 case Keys::P :
						 prOrtho = !prOrtho;
						 break;
					 case Keys::W :
						 rotate(OX, alpha, R);
						 times(R, Z, Z);
						 break;
					 case Keys::S :
						 rotate(OX, -alpha, R);
						 times(R, Z, Z);
						 break;

					 case Keys::A :
						 rotate(OY, alpha, R);
						 times(R, Z, Z);
						 break;

					 case Keys::D :
						 rotate(OY, -alpha, R);
						 times(R, Z, Z);
						 break;

					 case Keys::Q :
						 rotate(OZ, alpha, R);
						 times(R, Z, Z);
						 break;

					 case Keys::E :
						 rotate(OZ, -alpha, R);
						 times(R, Z, Z);
						 break;

					 case Keys::C :
						 fovy -= Math::PI / 180;
						 break;

					 case Keys::V :
						 fovy += Math::PI / 180;
						 break;

						 case Keys::X :
						 if (near > 1) 
							 near -= 1;
						 break;

					 case Keys::Z :
						 near++;
						 break;

					 case Keys::O :
						 alpha *= 1.1;
						 break;

					 case Keys::L :
						 alpha /= 1.1;
						 break;

					 case Keys::Escape :
						 LookAt(center, eyeS, upS, Z);
						 vec3D b;
						 point2vec(eyeS, b);
						 timesMatVec(Z, b, b);
						 eye.x = b[0];
						 eye.y = b[1];
						 eye.z = b[2];

						 up = upS;
						 near = nearS;
						 fovy = fovyS;
						 break;

					 case Keys::N :
						 int Rr,G,B;
						 Color RGB;
						 Rr = rand() % 255;
						 G = rand() % 255;
						 B = rand() % 255;
						 colors.Clear();
						 RGB = Color::FromArgb(Rr, G, B);
						 for ( int e = 0; e < cc; e++)
							colors.Add(RGB);
						 break;
					 default :
						 unit(R);
				 }
				 this->Refresh();
			 }
	private: System::Void Form1_Resize(System::Object^  sender, System::EventArgs^  e) {
				 Wcx = left;
				 Wcy = Form::ClientRectangle.Height - bottom;
				 Wx = Form::ClientRectangle.Width - left - right;
				 Wy = Form::ClientRectangle.Height - top - bottom;
				 aspect = Wx / Wy;
				 this->Refresh();
			 }
	};
}
