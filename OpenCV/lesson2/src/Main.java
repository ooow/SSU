import org.opencv.core.*;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import static org.opencv.imgproc.Imgproc.*;

public class Main {
    public static void main(String[] args) throws FileNotFoundException {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        Mat rgb = Imgcodecs.imread("phone.png");
        Mat his = new Mat();

        List<Mat> matList = new LinkedList<Mat>();
        matList.add(rgb);

        MatOfFloat ranges = new MatOfFloat(0, 256);
        MatOfInt histSize = new MatOfInt(255);

        calcHist(matList, new MatOfInt(0), new Mat(), his, histSize, ranges);

        Mat histImage = Mat.zeros(100, (int) histSize.get(0, 0)[0], CvType.CV_8UC1);


        Core.normalize(his, his, 1, histImage.rows(), Core.NORM_MINMAX, -1, new Mat());

        Imgcodecs.imwrite("phone2.png", histImage);
        PrintWriter pw = new PrintWriter(new FileOutputStream("output.txt"));
        for (int i = 0; i < (int) histSize.get(0, 0)[0]; i++) {
            String x = String.valueOf(new org.opencv.core.Point(i, histImage.rows()));
            String y = String.valueOf(new org.opencv.core.Point(i, histImage.rows() - Math.round(his.get(i, 0)[0])));
            String sx = x.substring(1, x.indexOf(","));
            String ex = x.substring(x.indexOf(",") + 2, x.length() - 1);
            String sy = y.substring(1, y.indexOf(","));
            String ey = y.substring(y.indexOf(",") + 2, y.length() - 1);

            //pw.println("(" + sx +"; " + ex +")");
            pw.println("(" + sy + "; " + ey + ")");
           /* Core.line(histImage, new org.opencv.core.Point(i, histImage.rows()),
                    new org.opencv.core.Point(i, histImage.rows() - Math.round(his.get(i, 0)[0])),
                    new Scalar(255, 255, 255),
                    1, 8, 0);*/
        }
        pw.close();
    }
}

