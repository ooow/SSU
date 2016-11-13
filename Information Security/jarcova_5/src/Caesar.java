import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Scanner;

/**
 * Created by goga on 13.11.16.
 */
public class Caesar {
    List<Character> alphabet = new ArrayList<>();

    public static void main(String[] args) throws FileNotFoundException {
        Scanner sc = new Scanner(new FileReader("text.txt"));
        String text = "";
        while (true) {
            try {
                text += sc.nextLine();
            } catch (NoSuchElementException e) {
                break;
            }
        }
        Caesar caesar = new Caesar();
        text = caesar.encrypt(text, 1, 7);
        System.out.println(text);
        text = caesar.decrypt(text, 1, 7);
        System.out.println(text);
    }

    Caesar() {
        char[] pun = {'.', ',', ';', ':', '!', '?', '-'};

        for (char c = 'а'; c <= 'я'; c++) {
            alphabet.add(c);
        }
        for (char c = '0'; c <= '9'; c++) {
            alphabet.add(c);
        }
        for (char c : pun) {
            alphabet.add(c);
        }
    }

    String encrypt(String text, int n, int k) {
        int m = alphabet.size();
        n = n % m;
        k = k % m;
        if (nod(m, n) != 1) {//проверка простоты m относительно n
            return null;
        }
        StringBuilder cryptogram = new StringBuilder();
        //блок шифрования данных
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            int index = alphabet.indexOf(c);
            index = (index * n + k) % m;
            cryptogram.append(alphabet.get(index));
        }
        return cryptogram.toString();
    }

    public String decrypt(String text, int n, int k) {
        int m = alphabet.size();
        n = n % m;
        k = k % m;
        int reversedM = -1;//обратное к n
        //ищем обратное к n
        for (int i = 0; i < m; i++) {
            if ((i * n) % m == 1) {
                reversedM = i;
                break;
            }
        }
        StringBuilder newText = new StringBuilder();
        //блок дешифрования данных
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            int index = alphabet.indexOf(c);
            index = (((index - k) * reversedM) % m + m) % m;
            newText.append(alphabet.get(index));
        }
        return newText.toString();

    }

    //алгоритм поиска наибольшего общего делителя
    private static int nod(int a, int b) {
        while (a > 0 && b > 0) {
            if (a > b) {
                a %= b;
            } else {
                b %= a;
            }
        }
        return a + b;
    }
}
