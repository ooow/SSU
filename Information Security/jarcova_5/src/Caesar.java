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
        sc = new Scanner(System.in);
        System.out.println("Введите n  и  k");
        int n = sc.nextInt();
        int k = sc.nextInt();
        System.out.println("Выполнить шифрование(1) или дешифрование(2) ?");
        if (sc.nextInt() == 1) {
            text = caesar.encrypt(text, n, k);
            System.out.println(text);
        } else {
            text = caesar.decrypt(text, n, k);
            System.out.println(text);
        }
    }

    Caesar() {
        char[] pun = {'.', ',', ';', ':', '!', '?', '-', ' '};

        for (char c = 'а'; c <= 'я'; c++) {
            alphabet.add(c);
        }
        for (char c = '0'; c <= '9'; c++) {
            alphabet.add(c);
        }
        for (char c : pun) {
            alphabet.add(c);
        }
        System.out.println("Размер алфавита:" + alphabet.size());
    }

    String encrypt(String text, int n, int k) {
        int m = alphabet.size();
        n = n % m;
        k = k % m;
        if (nod(m, n) != 1) {//проверка простоты m относительно n
            System.out.println("Проверка простоты провалена");
            return null;
        }
        StringBuilder cryptogram = new StringBuilder();
        //блок шифрования данных
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            int index = alphabet.indexOf(c);
            if (index != -1) {
                index = (index * n + k) % m;
                cryptogram.append(alphabet.get(index));
            } else {
                return "В исходном тексте найден недопустимый символ";
            }
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
