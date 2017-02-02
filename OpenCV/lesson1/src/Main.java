import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;

import static org.opencv.imgproc.Imgproc.COLOR_Lab2RGB;
import static org.opencv.imgproc.Imgproc.COLOR_RGB2Lab;

public class Main {
    public static void main(String[] args) {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        Mat rgbImg = Imgcodecs.imread("phone.png");
        Mat labImg = new Mat();

        Imgproc.cvtColor(rgbImg, labImg, COLOR_RGB2Lab);
        int rows = labImg.rows();
        int cols = labImg.cols();
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                double[] data = labImg.get(i, j);
                data[2] = (data[2] - 128) * 1.5 + 128;
                data[1] = (data[1] - 128) * 1.5 + 128;
                labImg.put(i, j, data);
            }
        }

        Mat rgbImgOut = new Mat();
        Imgproc.cvtColor(labImg, rgbImgOut, COLOR_Lab2RGB);
        Imgcodecs.imwrite("phone2.png", rgbImgOut);

        LoadImage lg = new LoadImage();
        lg.setVisible(true);
    }
}
