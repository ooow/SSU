#pragma once

namespace five {

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
		/// <summary>
		/// Требуется переменная конструктора.
		/// </summary>
		System::ComponentModel::Container ^components;

		float left, right, top, bottom;
		float Wcx, Wcy, Wx, Wy;
		float Vcx, Vcy, Vx, Vy;
		float VcxO, VcyO, VxO, VyO;
		int K, L;
		float old;

		point Pmax, Pmin;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Обязательный метод для поддержки конструктора - не изменяйте
		/// содержимое данного метода при помощи редактора кода.
		/// </summary>
		void InitializeComponent(void)
		{
			this->SuspendLayout();
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(734, 361);
			this->DoubleBuffered = true;
			this->MinimumSize = System::Drawing::Size(750, 400);
			this->Name = L"Form1";
			this->Text = L"Five";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &Form1::Form1_Paint);
			this->Resize += gcnew System::EventHandler(this, &Form1::Form1_Resize);
			this->KeyDown += gcnew System::Windows::Forms::KeyEventHandler(this, &Form1::Form1_KeyDown);
			this->ResumeLayout(false);

		}
#pragma endregion
	private: System::Void Form1_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) {
				 Graphics^ g = e->Graphics;
				 g->Clear(Color::White);
				 Rectangle rect = Form::ClientRectangle;

				 Pen^ blackPen = gcnew Pen(Color::Black);   
				 blackPen->Width = 2;

				 Pen^ rectPen = gcnew Pen(Color::Green);         
				 rectPen->Width = 4;

				 Pen^ cPen = gcnew Pen(Color::Gray);     
				 cPen->Width = 1;

				 System::Drawing::Font^ drawF = gcnew System::Drawing::Font("Arial", 8); 
				 SolidBrush^ Brush = gcnew SolidBrush(Color::Gray);

				 g->DrawRectangle(rectPen, Wcx, top, Wx, Wy);

				 bool visible1 = false, visible2 = false;
				 float x, x1, y=0, y1=0, y2=0;
				 //расстояние между линиями
				 float Ks = (rect.Height -  bottom - top) / (K + 1), 
					   Ls = (rect.Width - right - left) / (L + 1);
				 //горизонтальные линии сетки
				 for (float i = 0; i <= K + 1; i++){ 
					 float y1 = top + i * Ks;
					 if (i != 0 && i != K + 1)
						 g->DrawLine(cPen, left, y1, rect.Width - left, y1);
					 g->DrawString(System::Convert::ToString(Vcy - ((y1 - Wcy) / Wy) * Vy), drawF,
						 Brush,8, y1 - 8 );
				 }
				 //вертикальные линии сетки
				 for (float i = 0; i <= L + 1; i++){ 
					 float x1 = left + i * Ls;
					 StringFormat^ drawFormat = gcnew StringFormat;
					 drawFormat->FormatFlags = StringFormatFlags::DirectionVertical;
					 if (i != 0 && i != L + 1)
						 g->DrawLine(cPen, x1, top, x1, rect.Height - bottom);
					 g->DrawString(System::Convert::ToString(((x1 - Wcx) / Wx) * Vx + Vcx), 
						            drawF, Brush, x1 - 8, rect.Height - bottom - Wy - top + 10, drawFormat);
				 }
				 x1 = Wcx, x = Vcx;
				 if (fexists(x)){
					 visible1 = true;
					 y = f(x);
					 y1 = Wcy - (y - Vcy) * Wy /Vy;
				 }
				 else visible1 = false;

				 while (x1 < Wcx + Wx) {
					 x = (x1 + 1 - Wcx) * Vx / Wx + Vcx;

					 if (fexists(x)){
						 visible2 = true;
						 y = f(x);
						 y2 = Wcy - (y - Vcy) * Wy / Vy;
					 }
					 else visible2 = false;

					 if (visible1 && visible2) {
						 point a, b;
						 a.x = x1;	  
						 a.y = y1;
						 b.x = x1 + 1;
						 b.y = y2;

						 if (clip ( a, b, Pmin, Pmax)) { 
							 g->DrawLine(blackPen, a.x, a.y, b.x, b.y);	
						 }
					 }
					 x1 = x1 + 1;	
					 y1 = y2;
					 visible1 = visible2; 
				 }
			 }
	private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
				 left = right = top = bottom = 70;
				 K = L = 7;
				 Rectangle rect = Form::ClientRectangle;

				 Vx = VxO = 9; 
				 Vy = VyO = 3;
				 Vcx = VcxO = -Vx / 2;
				 Vcy = VcyO = -Vy / 2;

				 Wcx = left;
				 Wcy = rect.Height - bottom;
				 Wx  = rect.Width - left - right;
				 Wy  = rect.Height - top - bottom;

				 Pmax.x = rect.Width  - right - 4 / 2;
				 Pmax.y = rect.Height - bottom - 4 / 2;		

				 Pmin.x = left + 4 / 2;
				 Pmin.y = top  + 4 / 2;
			 }
	private: System::Void Form1_Resize(System::Object^  sender, System::EventArgs^  e) {
				 Rectangle rect = Form::ClientRectangle;

				 Wcx = left;
				 Wcy = rect.Height - bottom;
				 Wx  = rect.Width - left - right;
				 Wy  = rect.Height - top - bottom;

				 Pmax.x = rect.Width  - right - 4 / 2;
				 Pmax.y = rect.Height - bottom - 4 / 2;	

				 this->Refresh();
			 }
	private: System::Void Form1_KeyDown(System::Object^  sender, System::Windows::Forms::KeyEventArgs^  e) {
				 switch (e->KeyCode) {
				case Keys::W :
					Vcy += -(Vy / Wy);
					break;
				case Keys::S :
					Vcy += (Vy / Wy);
					break;
				case Keys::D :
					Vcx += -(Vx / Wx);
					break;
				case Keys::A :
					Vcx += (Vx / Wx);
					break;
				case Keys::T :
					Vcy += -10 * (Vy / Wy);
					break;
				case Keys::G :
					Vcy += 10 * (Vy / Wy);
					break;
				case Keys::F :
					Vcx += 10 * (Vx / Wx);
					break;
				case Keys::H :
					Vcx += -10 * (Vx / Wx);
					break;
				case Keys::E :
					K++;
					break;
				case Keys::Q :
					if (K > 1) 
						K--;
					break;
				case Keys::C :
					L++;
					break;
				case Keys::Z :
					if (L > 1) 
						L--;
					break;
				case Keys::I :
					old = Vy;
					Vy *= 1.1;
					Vcy += (old - Vy) / 2;
					break;
				case Keys::O :
					old = Vy;
					Vy *= 1 / 1.1;
					Vcy += (old - Vy) / 2;
					break;
				case Keys::K :
					old = Vx;
					Vx *= 1.1;
					Vcx += (old - Vx) / 2;
					break;
				case Keys::L :
					old = Vx;
					Vx *= 1 / 1.1;
					Vcx += (old - Vx) / 2;
					break;
				case Keys::Escape :
					Vx = VxO;
					Vy = VyO;
					Vcx = VcxO;
					Vcy = VcyO;
					break;
				 }

				 this->Refresh();
			 }
	};
}

