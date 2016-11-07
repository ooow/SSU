import java.awt.TextArea;
import java.io.EOFException;
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * Created by Гога on 26.09.2016.
 */
public class Main {
    private static int k = 0;
    private static String status;

    public static void main(String args[]) throws IOException {
        FrameWindow frame;
        frame = new FrameWindow("File Open Menu Jarcova 2");
    }

    public static void manage(int shift, int len, File f, File dir, TextArea textArea) throws IOException {
        String sign = "";
        status = "";
        RandomAccessFile in = new RandomAccessFile(f, "r");//инициируем объект произвольного доступа к файлу
        in.seek(shift);//ставим указатель на смещение
        try {
            for (int i = 0; i < len; i++) {
                sign += in.readChar();//считываем сигнатуру заданной длины
            }
        } catch (EOFException e) {
        }
        search(sign, shift, len, dir, textArea);//запускаем поиск
        if (k == 0)
            textArea.setText("File not found!");
    }

    public static void search(String sign, int shift, int len, File dir, TextArea textArea) throws IOException {
        String files[] = dir.list();//получаем то, что находится в папке
        for (int i = 0; i < files.length; i++) {//
            File f = new File(dir + "\\" + files[i]);//последовательно считываем файлы из папки
            if (!f.isDirectory()) {//если это не папка
                String str = "";
                RandomAccessFile in = new RandomAccessFile(f, "r");//инициируем объект произвольного доступа
                in.seek(shift);//ставим указатель на смещение
                try {
                    for (int j = 0; j < len; j++) {
                        str += in.readChar();//считываем сигнатуру заданной длины
                    }
                } catch (EOFException e) {
                }
                if (str.equals(sign)) {//сравниваем сигнатуру с эталонной
                    status += f + "\n";//если они равны, выводим путь
                    textArea.setText(status);
                    k++;
                }
            } else
                search(sign, shift, len, f, textArea);//если это папка, рекурсивно переходим к поиску файла в ней
        }
    }
}