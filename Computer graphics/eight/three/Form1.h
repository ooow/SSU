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
	private:
		System::Collections::Generic::List<polygon^> polygons;
		System::Collections::Generic::List<Color> pcolor;
		System::Collections::Generic::List<rebro> spisok;

		float left, right, top, bottom;
		float Wcx, Wcy, Wx, Wy;
		float Vcx, Vcy, Vx, Vy;

	private: System::Windows::Forms::OpenFileDialog^  openFileDialog;
	private: System::Windows::Forms::Button^  btnOpen;



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
			this->btnOpen->Location = System::Drawing::Point(12, 12);
			this->btnOpen->Name = L"btnOpen";
			this->btnOpen->Size = System::Drawing::Size(75, 23);
			this->btnOpen->TabIndex = 0;
			this->btnOpen->Text = L"Открыть";
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
			this->Text = L"Eight";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &Form1::Form1_Paint);
			this->Resize += gcnew System::EventHandler(this, &Form1::Form1_Resize);
			this->KeyDown += gcnew System::Windows::Forms::KeyEventHandler(this, &Form1::Form1_KeyDown);
			this->ResumeLayout(false);

		}
#pragma endregion
	private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
				 polygons.Clear();
				 unit (T); // инициализируем матрицу T при запуске приложения
				 Rectangle rect = Form::ClientRectangle;

				 top = 70;
				 left = 50;
				 right = 50;
				 bottom = 50;

				 Wcx = left;
				 Wcy = Form::ClientRectangle.Height - bottom;
				 Wx = Form::ClientRectangle.Width - left - right;
				 Wy = Form::ClientRectangle.Height - top - bottom;
			 }
	private: System::Void Form1_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) {
				 Bitmap^ image1 = gcnew Bitmap( this->ClientRectangle.Width, this->ClientRectangle.Height);
				 Graphics^ g = Graphics::FromImage(image1);

				 Pen^ rectPen = gcnew Pen(Color::Snow); 
				 rectPen->Width = 4;
				

				 Rectangle rect = Form::ClientRectangle;
				 Pen^ blackPen = gcnew Pen(Color::Black);
				 blackPen->Width = 4;

				 point Pmin, Pmax;
				 Pmax.x = Form::ClientRectangle.Width  - right;
				 Pmax.y = Form::ClientRectangle.Height - bottom;
				 Pmin.x = left;
				 Pmin.y = top;
				 g->DrawRectangle(rectPen, Wcx, top, Wx, Wy);

				 for (int i = 0; i < polygons.Count; i++) {
					 polygon^ p = polygons[i];
					 polygon^ P1 = gcnew polygon(0);
					 point a, b;
					 vec A, B;
					 for (int j = 0; j < p->Count; j++) {
						 point2vec(p[j], A);
						 timesMatVec(T, A, B);
						 vec2point(B, a);
						 P1->Add(a);
					 }
					 P1 = PClip(P1, Pmin, Pmax);
					 Pfill (P1, image1, pcolor[i]);
					/* Goga (P1, image1, pcolor[i]);*/
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
						 Rectangle rect = Form::ClientRectangle;
						 in.open(fileName);
						 if ( in.is_open() ) {
							 unit(T);
							 std::string str;	
							 getline (in, str);
							 while (in) {
								 if ((str.find_first_not_of(" \t\r\n") != std::string::npos)
									 && (str[0] != '#')) {
										 std::stringstream s(str);
										 std::string cmd;
										 s >> cmd;
										 if ( cmd == "frame" ) {
											 float cx, cy, x, y;
											 s >> cx >> cy >> x >> y;
											 Vx = x;
											 Vy = y;
											 Vcx = cx;
											 Vcy = cy;
											 frame (Vx, Vy, Vcx, Vcy, Wx, Wy, Wcx, Wcy, T);
										 }
										 else if ( cmd == "polygon" ) {
											 int numpoint;
											 s >> numpoint;

											 polygon^ P = gcnew polygon(0);
											 for (int i = 0; i < numpoint; i++) {
												 point p;
												 s >> p.x >> p.y;
												 P->Add(p);
											 }
											 polygons.Add(P);
											 
										 }
										  else if (cmd == "color") {
											 Color Fill;
											 int R, G, B;
											 s >> R >> G >> B;
											 Fill = Color::FromArgb(R, G, B);
											 pcolor.Add(Fill);
										 }
								 }
								 getline (in, str); // по окончании считывания файла закроем поток
							 }
						 }
						 this->Refresh(); // обновим изображение на форме
				 }
			 }
	private: System::Void Form1_KeyDown(System::Object^  sender, System::Windows::Forms::KeyEventArgs^  e) {
				 Rectangle rect = Form::ClientRectangle;
				 mat R, T1; // Опишем матрицу преобразования и вспомогательную матрицу для записи результата
				 //перемножения матриц
				 switch(e->KeyCode){
					 // смещение изображения вверх
					 case Keys::W : 
						 move(0, -1, R);
						 break;

						 // смещение изображения вниз
					 case Keys::S : 
						 move(0, 1, R);
						 break;

						 // смещение изображения влево
					 case Keys::A : 
						 move(-1, 0, R);
						 break;

						 // смещение изображения вправо
					 case Keys::D : 
						 move(1, 0, R);
						 break;

						 // поворот по часовой стрелки
					 case Keys::E :
						 rotate(0, 0, 0.05, R);
						 break;

						 // увеличение изображения в 1.1 раза относительно начала координат
					 case Keys::X : 
						 scale(1.1, R);
						 break;

						 // поворот против часовой стрелки
					 case Keys::Q : 
						 rotate(0, 0, -0.05, R);
						 break;

						 // уменьшение изображения в 1.1 раза относительно начала координат
					 case Keys::Z : 
						 scale(1/1.1, R);
						 break;

						 // быстрое смещение изображения вверх
					 case Keys::T : 
						 move(0, -30, R);
						 break;

						 // быстрое смещение изображения вниз
					 case Keys::G : 
						 move(0, 30, R);
						 break;

						 // быстрое смещение изображения влево
					 case Keys::F :
						 move(-30, 0, R); 
						 break;

						 // быстрое смещение изображения вправо
					 case Keys::H :
						 move(30, 0, R); 
						 break;

						 // восстановление первоначального изображения
					 case Keys::Escape : 
						 unit(T);
						 unit(R);
						 frame (Vx, Vy, Vcx, Vcy, Wx, Wy, Wcx, Wcy, T);
						 break;

						 // поворот против часовой стрелки относительно центра
					 case Keys::R :  
						 rotate(rect.Width/2,rect.Height/2,-0.05, R);
						 break;

						 //	поворот по часовой стрелки относительно центра
					 case Keys::Y :  
						 rotate(rect.Width/2,rect.Height/2,0.05, R);
						 break;

						 // зеркальное отображение относительно вертикальной оси
					 case Keys::J : 
						 mirror( 1, rect.Height, R);
						 break;

						 // зеркальное отображение относительно горизонтальной оси
					 case Keys::U : 
						 mirror( -1, rect.Width, R);
						 break;

						 // уменьшение изображения относительно центра (1)
					 case Keys::V : 
						 scale(1.1, R);
						 increase(rect.Width/2, rect.Height/2, 1, R);
						 break;

						 // увеличение изображения относительно центра (-1)
					 case Keys::C :
						 scale(1/1.1, R); 
						 increase(rect.Width/2, rect.Height/2, -1, R);
						 break;

						 // уменьшение изображения относительно горизонтальной оси (-2)
					 case Keys::I :
						 scale(1/1.1, R); 
						 increase(1, rect.Height/2, 2, R);
						 break;

						 // увеличение изображения относительно  горизонтальной оси (2)
					 case Keys::O :
						 scale(1.1, R); 
						 increase(1, rect.Height/2, -2, R);
						 break;

						 // уменьшение изображения относительно вертикальной оси (-3)
					 case Keys::K :
						 scale(1/1.1, R); 
						 increase(1, rect.Width/2, -3, R);
						 break;

						 // увеличение изображения относительно вертикальной оси (3)
					 case Keys::L :
						 scale(1.1, R); 
						 increase(1, rect.Width/2, 3, R);
						 break;

						 // название отрезков
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
