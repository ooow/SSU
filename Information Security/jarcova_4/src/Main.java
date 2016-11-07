import java.io.*;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Scanner;

/**
 * Created by goga on 07.11.16.
 */
public class Main {
    private String fileName = "text.txt";
    private String fileNameTwo = "text2.txt";

    public static void main(String[] args) throws IOException {
        Main main = new Main();
        main.code();
        main.decode();

    }

    // записать файл в текс
    public void code() throws IOException {
        File file = new File("apple.jpg");
        byte[] data = Files.readAllBytes(file.toPath());
        System.out.println("Вес файла в байтах: " + data.length);
        System.out.println("Вес файла в битах: " + data.length * 8);
        int lineCount = lineCount();
        System.out.println("Количество строк в тексте: " + lineCount);

        if (lineCount < data.length * 8) {
            System.out.println("Контейнер слишком маленький, чтобы закодировать данный файл");
            return;
        }

        ArrayList<Character> bits = bytesToBits(data);
        saveFile(bits);
    }

    // выгрузить файл из текста
    public void decode() throws IOException {
        ArrayList<Character> bits = readBits();
        byte[] data = bitsToBytes(bits);

        OutputStream outputStream = new DataOutputStream(new FileOutputStream(new File("page.jpg")));
        outputStream.write(data);
        outputStream.flush();
        outputStream.close();
    }

    // считываение байтов их текста
    public ArrayList<Character> readBits() throws IOException {
        ArrayList<Character> bits = new ArrayList<>();
        Scanner sc = new Scanner(new FileReader(fileNameTwo));
        while (true) {
            try {
                String str = sc.nextLine();
                char c = str.charAt(str.length() - 1);
                if (c == ' ')
                    bits.add('0');
                else bits.add('1');
            } catch (NoSuchElementException e) {
                break;
            }
        }
        return bits;
    }

    // сохранение файа в тексте
    public void saveFile(ArrayList<Character> bits) throws IOException {
        Scanner sc = new Scanner(new FileReader(fileName));
        PrintWriter pw = new PrintWriter(fileNameTwo);
        Iterator<Character> bit = bits.iterator(); //iterator берет по 1 экзем с массива битов
        while (true) {
            try {
                if (bit.hasNext()) { //если еще есть биты
                    if (bit.next().compareTo('0') == 0)
                        pw.write(sc.nextLine() + " \n");
                    else
                        pw.write(sc.nextLine() + "\n");
                } else
                    pw.write(sc.nextLine() + "\n");
            } catch (NoSuchElementException e) {
                break;
            }
        }
        pw.flush();
        pw.close();
    }

    // подсчет количества строк в тексте
    public int lineCount() throws FileNotFoundException { //считает количество пробелов в файле
        Scanner sc = new Scanner(new FileReader(fileName));
        int lineCount = 0;
        while (true) {
            try {
                sc.nextLine();
                lineCount++;
            } catch (NoSuchElementException e) {
                break;
            }
        }
        return lineCount;
    }

    // перевод байтов в биты
    public ArrayList<Character> bytesToBits(byte[] bytes) { //перевод массив байт в биты
        ArrayList<Character> bits = new ArrayList<>();
        for (byte b : bytes) {
            String bitString = String.format("%8s", Integer.toBinaryString(b & 0xFF)).replace(' ', '0'); //переводим байт в биты
            for (int i = 0; i < bitString.length(); i++) {
                bits.add(bitString.charAt(i));
            }
        }
        return bits;
    }

    // перевод битов в байты
    private static byte[] bitsToBytes(ArrayList<Character> bits) {
        byte[] bytes = new byte[bits.size() / 8];

        StringBuilder str = new StringBuilder();
        int k = 0;
        for (int i = 0; i < bits.size(); i++) {
            str.append(bits.get(i));
            if (str.length() == 8) {
                bytes[k] = (byte) Integer.parseInt(str.toString(), 2);
                k++;
                str = new StringBuilder();
            }
        }
        return bytes;
    }
}
