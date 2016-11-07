import java.util.zip.CRC32;
import java.util.zip.Checksum;

/**
 * Created by Гога on 20.10.2016.
 */
public class Support {
    //метод перевода строки в код crc32
    public static String crc32(String str) throws Exception {
        Checksum checksum = new CRC32();
        byte[] bytes = str.getBytes();
        checksum.update(bytes, 0, str.length());
        long checksumValue = checksum.getValue();
        return String.valueOf(checksumValue);
    }

    public static int[] breakData(int[] mas, int n) {
        for (int i = 0; i < n; i++) {
            mas[i] += 5;
        }
        return mas;
    }

    public static int[] buildData(int[] mas, int n) {
        for (int i = 0; i < n; i++) {
            mas[i] -= 5;
        }
        return mas;
    }
}
