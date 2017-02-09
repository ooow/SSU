#pragma once


namespace oop_last {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	using namespace std;

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
	private: System::Windows::Forms::Button^  Наличие;
	protected: 

	private: System::Windows::Forms::DataGridView^  dataGridView1;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  num;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  knig;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  avto;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  god;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  kat;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  kol;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  cena;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  rcena;
	private: System::Windows::Forms::OpenFileDialog^  openFileDialog;
	private: System::Windows::Forms::Button^  button1;
	private: System::Windows::Forms::DataGridView^  dataGridView2;
			 int N, N11, cash, procent, vigoda, cash1, post;
	private: System::Windows::Forms::Button^  button2;
	private: System::Windows::Forms::RichTextBox^  rich;

	private: System::Windows::Forms::Label^  label1;






	private: System::Windows::Forms::Label^  label2;
	private: System::Windows::Forms::Label^  label3;
	private: System::Windows::Forms::Label^  label4;
	private: System::Windows::Forms::Label^  label100;
	private: System::Windows::Forms::Label^  label5;
	private: System::Windows::Forms::Label^  label6;
	private: System::Windows::Forms::Label^  label7;
	private: System::Windows::Forms::Label^  label8;
	private: System::Windows::Forms::Label^  label9;
	private: System::Windows::Forms::Label^  label10;
	private: System::Windows::Forms::Label^  label11;
	private: System::Windows::Forms::Label^  label12;
	private: System::Windows::Forms::Label^  label13;
	private: System::Windows::Forms::Label^  label14;
	private: System::Windows::Forms::Label^  label15;
	private: System::Windows::Forms::Label^  label16;
	private: System::Windows::Forms::Label^  label17;
	private: System::Windows::Forms::ProgressBar^  progressBar1;
	private: System::Windows::Forms::Label^  label18;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  dataGridViewTextBoxColumn1;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  dataGridViewTextBoxColumn2;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  dataGridViewTextBoxColumn3;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  dataGridViewTextBoxColumn4;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  dataGridViewTextBoxColumn7;
	private: System::Windows::Forms::DataGridViewTextBoxColumn^  dataGridViewTextBoxColumn8;

	protected: 

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
			this->Наличие = (gcnew System::Windows::Forms::Button());
			this->dataGridView1 = (gcnew System::Windows::Forms::DataGridView());
			this->num = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->knig = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->avto = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->god = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->kat = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->kol = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->cena = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->rcena = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->openFileDialog = (gcnew System::Windows::Forms::OpenFileDialog());
			this->button1 = (gcnew System::Windows::Forms::Button());
			this->dataGridView2 = (gcnew System::Windows::Forms::DataGridView());
			this->button2 = (gcnew System::Windows::Forms::Button());
			this->rich = (gcnew System::Windows::Forms::RichTextBox());
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->label2 = (gcnew System::Windows::Forms::Label());
			this->label3 = (gcnew System::Windows::Forms::Label());
			this->label4 = (gcnew System::Windows::Forms::Label());
			this->label100 = (gcnew System::Windows::Forms::Label());
			this->label5 = (gcnew System::Windows::Forms::Label());
			this->label6 = (gcnew System::Windows::Forms::Label());
			this->label7 = (gcnew System::Windows::Forms::Label());
			this->label8 = (gcnew System::Windows::Forms::Label());
			this->label9 = (gcnew System::Windows::Forms::Label());
			this->label10 = (gcnew System::Windows::Forms::Label());
			this->label11 = (gcnew System::Windows::Forms::Label());
			this->label12 = (gcnew System::Windows::Forms::Label());
			this->label13 = (gcnew System::Windows::Forms::Label());
			this->label14 = (gcnew System::Windows::Forms::Label());
			this->label15 = (gcnew System::Windows::Forms::Label());
			this->label16 = (gcnew System::Windows::Forms::Label());
			this->label17 = (gcnew System::Windows::Forms::Label());
			this->progressBar1 = (gcnew System::Windows::Forms::ProgressBar());
			this->label18 = (gcnew System::Windows::Forms::Label());
			this->dataGridViewTextBoxColumn1 = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->dataGridViewTextBoxColumn2 = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->dataGridViewTextBoxColumn3 = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->dataGridViewTextBoxColumn4 = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->dataGridViewTextBoxColumn7 = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			this->dataGridViewTextBoxColumn8 = (gcnew System::Windows::Forms::DataGridViewTextBoxColumn());
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->dataGridView1))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->dataGridView2))->BeginInit();
			this->SuspendLayout();
			// 
			// Наличие
			// 
			this->Наличие->BackColor = System::Drawing::Color::LightGreen;
			this->Наличие->Location = System::Drawing::Point(12, 12);
			this->Наличие->Name = L"Наличие";
			this->Наличие->Size = System::Drawing::Size(75, 23);
			this->Наличие->TabIndex = 0;
			this->Наличие->Text = L"Наличие";
			this->Наличие->UseVisualStyleBackColor = false;
			this->Наличие->Click += gcnew System::EventHandler(this, &Form1::Наличие_Click);
			// 
			// dataGridView1
			// 
			this->dataGridView1->ColumnHeadersHeightSizeMode = System::Windows::Forms::DataGridViewColumnHeadersHeightSizeMode::AutoSize;
			this->dataGridView1->Columns->AddRange(gcnew cli::array< System::Windows::Forms::DataGridViewColumn^  >(8) {this->num, this->knig, 
				this->avto, this->god, this->kat, this->kol, this->cena, this->rcena});
			this->dataGridView1->Location = System::Drawing::Point(36, 41);
			this->dataGridView1->Name = L"dataGridView1";
			this->dataGridView1->Size = System::Drawing::Size(793, 161);
			this->dataGridView1->TabIndex = 1;
			// 
			// num
			// 
			this->num->HeaderText = L"№";
			this->num->Name = L"num";
			this->num->ReadOnly = true;
			this->num->Width = 50;
			// 
			// knig
			// 
			this->knig->HeaderText = L"Книга";
			this->knig->Name = L"knig";
			this->knig->ReadOnly = true;
			// 
			// avto
			// 
			this->avto->HeaderText = L"Автор";
			this->avto->Name = L"avto";
			this->avto->ReadOnly = true;
			// 
			// god
			// 
			this->god->HeaderText = L"Год издания";
			this->god->Name = L"god";
			this->god->ReadOnly = true;
			// 
			// kat
			// 
			this->kat->HeaderText = L"Категория";
			this->kat->Name = L"kat";
			this->kat->ReadOnly = true;
			// 
			// kol
			// 
			this->kol->HeaderText = L"Кол - во экземпляров";
			this->kol->Name = L"kol";
			this->kol->ReadOnly = true;
			// 
			// cena
			// 
			this->cena->HeaderText = L"Цена";
			this->cena->Name = L"cena";
			this->cena->ReadOnly = true;
			// 
			// rcena
			// 
			this->rcena->HeaderText = L"Рознечная наценка";
			this->rcena->Name = L"rcena";
			this->rcena->ReadOnly = true;
			// 
			// openFileDialog
			// 
			this->openFileDialog->FileName = L"openFileDialog";
			// 
			// button1
			// 
			this->button1->BackColor = System::Drawing::Color::LightGreen;
			this->button1->Location = System::Drawing::Point(12, 208);
			this->button1->Name = L"button1";
			this->button1->Size = System::Drawing::Size(75, 23);
			this->button1->TabIndex = 2;
			this->button1->Text = L"Заказы";
			this->button1->UseVisualStyleBackColor = false;
			this->button1->Click += gcnew System::EventHandler(this, &Form1::button1_Click);
			// 
			// dataGridView2
			// 
			this->dataGridView2->ColumnHeadersHeightSizeMode = System::Windows::Forms::DataGridViewColumnHeadersHeightSizeMode::AutoSize;
			this->dataGridView2->Columns->AddRange(gcnew cli::array< System::Windows::Forms::DataGridViewColumn^  >(6) {this->dataGridViewTextBoxColumn1, 
				this->dataGridViewTextBoxColumn2, this->dataGridViewTextBoxColumn3, this->dataGridViewTextBoxColumn4, this->dataGridViewTextBoxColumn7, 
				this->dataGridViewTextBoxColumn8});
			this->dataGridView2->GridColor = System::Drawing::SystemColors::ControlLightLight;
			this->dataGridView2->Location = System::Drawing::Point(36, 237);
			this->dataGridView2->Name = L"dataGridView2";
			this->dataGridView2->Size = System::Drawing::Size(594, 161);
			this->dataGridView2->TabIndex = 3;
			// 
			// button2
			// 
			this->button2->BackColor = System::Drawing::Color::Black;
			this->button2->ForeColor = System::Drawing::SystemColors::ButtonHighlight;
			this->button2->Location = System::Drawing::Point(377, 208);
			this->button2->Name = L"button2";
			this->button2->Size = System::Drawing::Size(102, 23);
			this->button2->TabIndex = 4;
			this->button2->Text = L"Смоделировать";
			this->button2->UseVisualStyleBackColor = false;
			this->button2->Click += gcnew System::EventHandler(this, &Form1::button2_Click);
			// 
			// rich
			// 
			this->rich->ForeColor = System::Drawing::Color::Black;
			this->rich->Location = System::Drawing::Point(36, 417);
			this->rich->Name = L"rich";
			this->rich->Size = System::Drawing::Size(594, 153);
			this->rich->TabIndex = 5;
			this->rich->Text = L"";
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Location = System::Drawing::Point(33, 401);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(51, 13);
			this->label1->TabIndex = 6;
			this->label1->Text = L"События";
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Location = System::Drawing::Point(793, 489);
			this->label2->Name = L"label2";
			this->label2->Size = System::Drawing::Size(0, 13);
			this->label2->TabIndex = 7;
			// 
			// label3
			// 
			this->label3->AutoSize = true;
			this->label3->Location = System::Drawing::Point(794, 517);
			this->label3->Name = L"label3";
			this->label3->Size = System::Drawing::Size(0, 13);
			this->label3->TabIndex = 8;
			// 
			// label4
			// 
			this->label4->AutoSize = true;
			this->label4->Location = System::Drawing::Point(793, 544);
			this->label4->Name = L"label4";
			this->label4->Size = System::Drawing::Size(0, 13);
			this->label4->TabIndex = 9;
			// 
			// label100
			// 
			this->label100->AutoSize = true;
			this->label100->Location = System::Drawing::Point(811, 573);
			this->label100->Name = L"label100";
			this->label100->Size = System::Drawing::Size(0, 13);
			this->label100->TabIndex = 10;
			// 
			// label5
			// 
			this->label5->AutoSize = true;
			this->label5->Location = System::Drawing::Point(649, 489);
			this->label5->Name = L"label5";
			this->label5->Size = System::Drawing::Size(97, 13);
			this->label5->TabIndex = 11;
			this->label5->Text = L"Всего продано на";
			// 
			// label6
			// 
			this->label6->AutoSize = true;
			this->label6->Location = System::Drawing::Point(649, 517);
			this->label6->Name = L"label6";
			this->label6->Size = System::Drawing::Size(91, 13);
			this->label6->TabIndex = 12;
			this->label6->Text = L"Чистая прибыль";
			// 
			// label7
			// 
			this->label7->AutoSize = true;
			this->label7->Location = System::Drawing::Point(649, 544);
			this->label7->Name = L"label7";
			this->label7->Size = System::Drawing::Size(100, 13);
			this->label7->TabIndex = 13;
			this->label7->Text = L"Поставленно книг";
			// 
			// label8
			// 
			this->label8->AutoSize = true;
			this->label8->Location = System::Drawing::Point(649, 237);
			this->label8->Name = L"label8";
			this->label8->Size = System::Drawing::Size(117, 13);
			this->label8->TabIndex = 14;
			this->label8->Text = L"Проданно в 1 день на";
			// 
			// label9
			// 
			this->label9->AutoSize = true;
			this->label9->Location = System::Drawing::Point(649, 265);
			this->label9->Name = L"label9";
			this->label9->Size = System::Drawing::Size(123, 13);
			this->label9->TabIndex = 15;
			this->label9->Text = L"Проданно во 2 день на";
			// 
			// label10
			// 
			this->label10->AutoSize = true;
			this->label10->Location = System::Drawing::Point(649, 294);
			this->label10->Name = L"label10";
			this->label10->Size = System::Drawing::Size(117, 13);
			this->label10->TabIndex = 16;
			this->label10->Text = L"Проданно в 3 день на";
			// 
			// label11
			// 
			this->label11->AutoSize = true;
			this->label11->Location = System::Drawing::Point(649, 322);
			this->label11->Name = L"label11";
			this->label11->Size = System::Drawing::Size(117, 13);
			this->label11->TabIndex = 17;
			this->label11->Text = L"Проданно в 4 день на";
			// 
			// label12
			// 
			this->label12->AutoSize = true;
			this->label12->Location = System::Drawing::Point(649, 350);
			this->label12->Name = L"label12";
			this->label12->Size = System::Drawing::Size(117, 13);
			this->label12->TabIndex = 18;
			this->label12->Text = L"Проданно в 5 день на";
			// 
			// label13
			// 
			this->label13->AutoSize = true;
			this->label13->Location = System::Drawing::Point(811, 237);
			this->label13->Name = L"label13";
			this->label13->Size = System::Drawing::Size(0, 13);
			this->label13->TabIndex = 19;
			// 
			// label14
			// 
			this->label14->AutoSize = true;
			this->label14->Location = System::Drawing::Point(811, 265);
			this->label14->Name = L"label14";
			this->label14->Size = System::Drawing::Size(0, 13);
			this->label14->TabIndex = 20;
			// 
			// label15
			// 
			this->label15->AutoSize = true;
			this->label15->Location = System::Drawing::Point(810, 294);
			this->label15->Name = L"label15";
			this->label15->Size = System::Drawing::Size(0, 13);
			this->label15->TabIndex = 21;
			// 
			// label16
			// 
			this->label16->AutoSize = true;
			this->label16->Location = System::Drawing::Point(810, 322);
			this->label16->Name = L"label16";
			this->label16->Size = System::Drawing::Size(0, 13);
			this->label16->TabIndex = 22;
			// 
			// label17
			// 
			this->label17->AutoSize = true;
			this->label17->Location = System::Drawing::Point(810, 350);
			this->label17->Name = L"label17";
			this->label17->Size = System::Drawing::Size(0, 13);
			this->label17->TabIndex = 23;
			// 
			// progressBar1
			// 
			this->progressBar1->Location = System::Drawing::Point(113, 12);
			this->progressBar1->MarqueeAnimationSpeed = 20;
			this->progressBar1->Name = L"progressBar1";
			this->progressBar1->Size = System::Drawing::Size(716, 23);
			this->progressBar1->Style = System::Windows::Forms::ProgressBarStyle::Marquee;
			this->progressBar1->TabIndex = 24;
			// 
			// label18
			// 
			this->label18->AutoSize = true;
			this->label18->Location = System::Drawing::Point(8, 573);
			this->label18->Name = L"label18";
			this->label18->Size = System::Drawing::Size(76, 13);
			this->label18->TabIndex = 25;
			this->label18->Text = L"©Tirkiya Goga";
			// 
			// dataGridViewTextBoxColumn1
			// 
			this->dataGridViewTextBoxColumn1->HeaderText = L"№";
			this->dataGridViewTextBoxColumn1->Name = L"dataGridViewTextBoxColumn1";
			this->dataGridViewTextBoxColumn1->ReadOnly = true;
			this->dataGridViewTextBoxColumn1->Width = 50;
			// 
			// dataGridViewTextBoxColumn2
			// 
			this->dataGridViewTextBoxColumn2->HeaderText = L"Книга";
			this->dataGridViewTextBoxColumn2->Name = L"dataGridViewTextBoxColumn2";
			this->dataGridViewTextBoxColumn2->ReadOnly = true;
			// 
			// dataGridViewTextBoxColumn3
			// 
			this->dataGridViewTextBoxColumn3->HeaderText = L"Автор";
			this->dataGridViewTextBoxColumn3->Name = L"dataGridViewTextBoxColumn3";
			this->dataGridViewTextBoxColumn3->ReadOnly = true;
			// 
			// dataGridViewTextBoxColumn4
			// 
			this->dataGridViewTextBoxColumn4->HeaderText = L"Год издания";
			this->dataGridViewTextBoxColumn4->Name = L"dataGridViewTextBoxColumn4";
			this->dataGridViewTextBoxColumn4->ReadOnly = true;
			// 
			// dataGridViewTextBoxColumn7
			// 
			this->dataGridViewTextBoxColumn7->HeaderText = L"Цена";
			this->dataGridViewTextBoxColumn7->Name = L"dataGridViewTextBoxColumn7";
			this->dataGridViewTextBoxColumn7->ReadOnly = true;
			// 
			// dataGridViewTextBoxColumn8
			// 
			this->dataGridViewTextBoxColumn8->HeaderText = L"Кол - во";
			this->dataGridViewTextBoxColumn8->Name = L"dataGridViewTextBoxColumn8";
			this->dataGridViewTextBoxColumn8->ReadOnly = true;
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(858, 595);
			this->Controls->Add(this->label18);
			this->Controls->Add(this->progressBar1);
			this->Controls->Add(this->label17);
			this->Controls->Add(this->label16);
			this->Controls->Add(this->label15);
			this->Controls->Add(this->label14);
			this->Controls->Add(this->label13);
			this->Controls->Add(this->label12);
			this->Controls->Add(this->label11);
			this->Controls->Add(this->label10);
			this->Controls->Add(this->label9);
			this->Controls->Add(this->label8);
			this->Controls->Add(this->label7);
			this->Controls->Add(this->label6);
			this->Controls->Add(this->label5);
			this->Controls->Add(this->label100);
			this->Controls->Add(this->label4);
			this->Controls->Add(this->label3);
			this->Controls->Add(this->label2);
			this->Controls->Add(this->label1);
			this->Controls->Add(this->rich);
			this->Controls->Add(this->button2);
			this->Controls->Add(this->dataGridView2);
			this->Controls->Add(this->button1);
			this->Controls->Add(this->dataGridView1);
			this->Controls->Add(this->Наличие);
			this->ForeColor = System::Drawing::Color::Black;
			this->Name = L"Form1";
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = L"Книжный Магазин";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->dataGridView1))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->dataGridView2))->EndInit();
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
	private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
				 N = 0;
				 N1.resize(N);
				 N2.resize(N);
				 N11 = 0;
				 cash = 0;
				 procent = 0;
				 cash1 = 0;
				 vigoda = 0;
			 }
	private: System::Void Наличие_Click(System::Object^  sender, System::EventArgs^  e) {
				 System::IO::Stream^ myStream;
				 if(this->openFileDialog->ShowDialog() == 
					 System::Windows::Forms::DialogResult::OK){
						 while(this->dataGridView1->RowCount>1)
							 this->dataGridView1->Rows->Remove(this->dataGridView1->Rows[0]);
						 if((myStream = openFileDialog->OpenFile()) != nullptr)
						 {
							 System::IO::StreamReader^ sr = gcnew
								 System::IO::StreamReader(myStream, System::Text::Encoding::GetEncoding(1251));
							 System::String ^str=" "; System::String ^str1=" ";
							 int i=0, k=0;
							 this->dataGridView1->Rows->Add(1);
							 while(sr->Peek()>=0){
								 str = sr->ReadLine();
								 this->dataGridView1->Rows[k]->Cells[i]->Value=(str);
								 i++;
								 if( i%8 == 0)
								 {
									 this->dataGridView1->Rows->Add(1); 
									 k++; 
									 i=0;
									 N++;
								 }
							 }
							 myStream->Close();
						 }
				 }
				 for ( int i = 0; i < N; i ++)
				 {
					 K.read_book(dataGridView1, i, K);
					 B.Add(K);
				 }
			 }
	private: System::Void button1_Click(System::Object^  sender, System::EventArgs^  e) {
				 System::IO::Stream^ myStream;
				 if(this->openFileDialog->ShowDialog() == 
					 System::Windows::Forms::DialogResult::OK){
						 while(this->dataGridView2->RowCount>1)
							 this->dataGridView2->Rows->Remove(this->dataGridView2->Rows[0]);
						 if((myStream = openFileDialog->OpenFile()) != nullptr)
						 {
							 this->dataGridView2->Rows->Clear();
							 System::IO::StreamReader^ sr = gcnew
								 System::IO::StreamReader(myStream, System::Text::Encoding::GetEncoding(1251));
							 System::String ^str=" "; System::String ^str1=" ";
							 int i=0, k=0;
							 this->dataGridView2->Rows->Add(1);
							 while(sr->Peek()>=0)
							 {
								 str = sr->ReadLine();
								 if (str != "#")
								 {
									 if( i==5 )
									 {
										 String^ str1;
										 int st;
										 st = rand() % 20 + 1;
										 string u = iTs(st);
										 str1 = sTS(u,label100);
										 this->dataGridView2->Rows[k]->Cells[i]->Value=(str1);
									 }
									 else
									 {
										 this->dataGridView2->Rows[k]->Cells[i]->Value=(str);
									 }
									 i++;
									 if( i%6 == 0)
									 {
										 this->dataGridView2->Rows->Add(1); 
										 k++; 
										 i=0;
										 N11++;
									 }
								 }
								 else
								 {
									 N1.resize(N1.size()+1);
									 N1[N1.size()-1] = N11;
									 N11 = 0;
									 N2.resize(N2.size()+1);
									 int y = dataGridView2->Rows->Count - 2;
									 N2[N2.size()-1] = y;
								 }
							 }
							 myStream->Close();
						 }
				 }
			 }
	private: System::Void button2_Click(System::Object^  sender, System::EventArgs^  e) {
				 //1 день/////////////////////////////////////
				 if (N1.size() > 0)
				 {
					 int schet = 0;
					 rich->Text += "1 День\n";
					 for ( int i = 0; i < N1[0]; i ++)
					 {
						 K1.read_zakaz(dataGridView2, i, K1);
						 B1.Add(K1);
					 }
					 for ( int i = 0; i < N; i++)
					 {
						 Kniga R;
						 Zakaz R1;
						 R = B.pop();
						 for ( int j = 0; j < N1[0]; j++)
						 {
							 R1 = B1.pop();
							 if ( ravno( R , R1) )
							 {
								 for ( int t = 0; t < sTi(R1.nn); t++)
								 {
									 cash += sTi(R.prace);
									 schet += sTi(R.prace);
									 cash1 = sTi(R.prace);
									 procent = sTi(R.stavka);
									 vigoda += (cash1 * procent) / 100;
								 }
								 String ^r = sTS(R.name, label100);
								 String ^r1 = sTS(R.avtor, label100);
								 String ^r3 = sTS(R1.nn, label100);
								 rich->Text += "Продана книга: " + r + " " + r1 + " - " + r3 + " экземпляров\n";
								 int ww = sTi(R1.nn);
								 int w = sTi(R.nn);
								 if ( w < 2 || ww > w)
								 {
									 int post1;
									 post1 = rand() % 10 + 1 + ww;
									 w += post1;
									 post += post1;
									 string qq = iTs(post1);
									 String^ r2 = sTS(qq, label100);
									 rich->Text += "\\\\Поставка_книг: " + r + " " + r1 +  " - " + r2 + " экземпляров\n";
								 }

								 w -= ww;
								 R.nn = iTs(w);
							 }
							 B1.Add(R1);
						 }
						 B.Add(R);
					 }
					 label2->Text = System::Convert::ToString(cash);
					 label3->Text = System::Convert::ToString(vigoda);
					 label4->Text = System::Convert::ToString(post);
					 for ( int i = 0; i < N; i ++)
					 {
						 K = B.pop();
						 K.print_book(dataGridView1, i, K);
						 B.Add(K);
					 }
					 string c = iTs(schet);
					 label13->Text = gcnew System::String(c.c_str());
				 }

				 //2 день//////////////////////////////////////////
				 if (N1.size() > 1)
				 {
					 int schet = 0;
					 rich->Text += "2 День\n";
					 B1.Clear();
					 for ( int i = N2[0]; i < N2[0] + N1[1]; i ++)
					 {
						 K1.read_zakaz(dataGridView2, i, K1);
						 B1.Add(K1);
					 }
					 for ( int i = 0; i < N; i++)
					 {
						 Kniga R;
						 Zakaz R1;
						 R = B.pop();
						 for ( int j = 0; j < N1[1]; j++)
						 {
							 R1 = B1.pop();
							 if ( ravno( R , R1) )
							 {
								 for ( int t = 0; t < sTi(R1.nn); t++)
								 {
									 cash += sTi(R.prace);
									 schet += sTi(R.prace);
									 cash1 = sTi(R.prace);
									 procent = sTi(R.stavka);
									 vigoda += (cash1 * procent) / 100;
								 }
								 String ^r = sTS(R.name, label100);
								 String ^r1 = sTS(R.avtor, label100);
								 String ^r3 = sTS(R1.nn, label100);
								 rich->Text += "Продана книга: " + r + " " + r1 + " - " + r3 + " экземпляров\n";
								 int ww = sTi(R1.nn);
								 int w = sTi(R.nn);
								 if ( w < 2 || ww > w)
								 {
									 int post1;
									 post1 = rand() % 10 + 1 + ww;
									 w += post1;
									 post += post1;
									 string qq = iTs(post1);
									 String^ r2 = sTS(qq, label100);
									 rich->Text += "\\\\Поставка_книг: " + r + " " + r1 +  " - " + r2 + " экземпляров\n";
								 }
								 w -= ww;
								 R.nn = iTs(w);
							 }
							 B1.Add(R1);
						 }
						 B.Add(R);
					 }
					 label2->Text = System::Convert::ToString(cash);
					 label3->Text = System::Convert::ToString(vigoda);
					 label4->Text = System::Convert::ToString(post);
					 for ( int i = 0; i < N; i ++)
					 {
						 K = B.pop();
						 K.print_book(dataGridView1, i, K);
						 B.Add(K);
					 }
					 string c = iTs(schet);
					 label14->Text = gcnew System::String(c.c_str());
				 }
				 //3 день//////////////////////////////////////////
				 if (N1.size() > 2)
				 {
					 int schet = 0;
					 rich->Text += "3 День\n";
					 B1.Clear();
					 for ( int i = N2[1]; i < N2[1] + N1[2]; i ++)
					 {
						 K1.read_zakaz(dataGridView2, i, K1);
						 B1.Add(K1);
					 }
					 for ( int i = 0; i < N; i++)
					 {
						 Kniga R;
						 Zakaz R1;
						 R = B.pop();
						 for ( int j = 0; j < N1[2]; j++)
						 {
							 R1 = B1.pop();
							 if ( ravno( R , R1) )
							 {
								 for ( int t = 0; t < sTi(R1.nn); t++)
								 {
									 cash += sTi(R.prace);
									 schet += sTi(R.prace);
									 cash1 = sTi(R.prace);
									 procent = sTi(R.stavka);
									 vigoda += (cash1 * procent) / 100;
								 }
								 String ^r = sTS(R.name, label100);
								 String ^r1 = sTS(R.avtor, label100);
								 String ^r3 = sTS(R1.nn, label100);
								 rich->Text += "Продана книга: " + r + " " + r1 + " - " + r3 + " экземпляров\n";
								 int ww = sTi(R1.nn);
								 int w = sTi(R.nn);
								 if ( w < 2 || ww > w)
								 {
									 int post1;
									 post1 = rand() % 10 + 1 + ww;
									 w += post1;
									 post += post1;
									 string qq = iTs(post1);
									 String^ r2 = sTS(qq, label100);
									 rich->Text += "\\\\Поставка_книг: " + r + " " + r1 +  " - " + r2 + " экземпляров\n";
								 }
								 w -= ww;
								 R.nn = iTs(w);
							 }
							 B1.Add(R1);
						 }
						 B.Add(R);
					 }
					 label2->Text = System::Convert::ToString(cash);
					 label3->Text = System::Convert::ToString(vigoda);
					 label4->Text = System::Convert::ToString(post);
					 for ( int i = 0; i < N; i ++)
					 {
						 K = B.pop();
						 K.print_book(dataGridView1, i, K);
						 B.Add(K);
					 }
					 string c = iTs(schet);
					 label15->Text = gcnew System::String(c.c_str());
				 }
				 //4 день//////////////////////////////////////////
				 if (N1.size() > 3)
				 {
					 int schet = 0;
					 rich->Text += "4 День\n";
					 B1.Clear();
					 for ( int i = N2[2]; i < N2[2] + N1[3]; i ++)
					 {
						 K1.read_zakaz(dataGridView2, i, K1);
						 B1.Add(K1);
					 }
					 for ( int i = 0; i < N; i++)
					 {
						 Kniga R;
						 Zakaz R1;
						 R = B.pop();
						 for ( int j = 0; j < N1[3]; j++)
						 {
							 R1 = B1.pop();
							 if ( ravno( R , R1) )
							 {
								 for ( int t = 0; t < sTi(R1.nn); t++)
								 {
									 cash += sTi(R.prace);
									 schet += sTi(R.prace);
									 cash1 = sTi(R.prace);
									 procent = sTi(R.stavka);
									 vigoda += (cash1 * procent) / 100;
								 }
								 String ^r = sTS(R.name, label100);
								 String ^r1 = sTS(R.avtor, label100);
								 String ^r3 = sTS(R1.nn, label100);
								 rich->Text += "Продана книга: " + r + " " + r1 + " - " + r3 + " экземпляров\n";
								 int ww = sTi(R1.nn);
								 int w = sTi(R.nn);
								 if ( w < 2 || ww > w)
								 {
									 int post1;
									 post1 = rand() % 10 + 1 + ww;
									 w += post1;
									 post += post1;
									 string qq = iTs(post1);
									 String^ r2 = sTS(qq, label100);
									 rich->Text += "\\\\Поставка_книг: " + r + " " + r1 +  " - " + r2 + " экземпляров\n";
								 }
								 w -= ww;
								 R.nn = iTs(w);
							 }
							 B1.Add(R1);
						 }
						 B.Add(R);
					 }
					 label2->Text = System::Convert::ToString(cash);
					 label3->Text = System::Convert::ToString(vigoda);
					 label4->Text = System::Convert::ToString(post);
					 for ( int i = 0; i < N; i ++)
					 {
						 K = B.pop();
						 K.print_book(dataGridView1, i, K);
						 B.Add(K);
					 }
					 string c = iTs(schet);
					 label16->Text = gcnew System::String(c.c_str());
				 }
				 //5 день//////////////////////////////////////////
				 if (N1.size() > 4)
				 {
					 int schet = 0;
					 rich->Text += "5 День\n";
					 B1.Clear();
					 for ( int i = N2[3]; i < N2[3] + N1[4]; i ++)
					 {
						 K1.read_zakaz(dataGridView2, i, K1);
						 B1.Add(K1);
					 }
					 for ( int i = 0; i < N; i++)
					 {
						 Kniga R;
						 Zakaz R1;
						 R = B.pop();
						 for ( int j = 0; j < N1[4]; j++)
						 {
							 R1 = B1.pop();
							 if ( ravno( R , R1) )
							 {
								 for ( int t = 0; t < sTi(R1.nn); t++)
								 {
									 cash += sTi(R.prace);
									 schet += sTi(R.prace);
									 cash1 = sTi(R.prace);
									 procent = sTi(R.stavka);
									 vigoda += (cash1 * procent) / 100;
								 }
								 String ^r = sTS(R.name, label100);
								 String ^r1 = sTS(R.avtor, label100);
								 String ^r3 = sTS(R1.nn, label100);
								 rich->Text += "Продана книга: " + r + " " + r1 + " - " + r3 + " экземпляров\n";
								 int ww = sTi(R1.nn);
								 int w = sTi(R.nn);
								 if ( w < 2 || ww > w)
								 {
									 int post1;
									 post1 = rand() % 10 + 1 + ww;
									 w += post1;
									 post += post1;
									 string qq = iTs(post1);
									 String^ r2 = sTS(qq, label100);

									 rich->Text += "\\\\Поставка_книг: " + r + " " + r1 +  " - " + r2 + " экземпляров\n";
								 }
								 w -= ww;
								 R.nn = iTs(w);
							 }
							 B1.Add(R1);
						 }
						 B.Add(R);
					 }
					 label2->Text = System::Convert::ToString(cash);
					 label3->Text = System::Convert::ToString(vigoda);
					 label4->Text = System::Convert::ToString(post);
					 for ( int i = 0; i < N; i ++)
					 {
						 K = B.pop();
						 K.print_book(dataGridView1, i, K);
						 B.Add(K);
					 }
					 string c = iTs(schet);
					 label17->Text = gcnew System::String(c.c_str());
				 }
			 }
	};
}

