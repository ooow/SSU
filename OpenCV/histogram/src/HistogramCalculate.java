import org.opencv.core.*;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;

import java.util.ArrayList;

import static org.opencv.core.Core.split;
import static org.opencv.core.CvType.CV_8UC1;
import static org.opencv.imgproc.Imgproc.COLOR_RGB2Lab;
import static org.opencv.imgproc.Imgproc.calcHist;

public class HistogramCalculate {
    private String imageURL = "phone.png";

    {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
    }

    public HistogramCalculate(String imageURL) {
        this.imageURL = imageURL;
    }

    public ArrayList<Point[]> getRGBhist() {
        Mat image = Imgcodecs.imread(imageURL);
        ArrayList<Mat> rgb = new ArrayList<>();
        split(image, rgb);
        MatOfInt histSize = new MatOfInt(255); // кол-во бункеров
        MatOfFloat ranges = new MatOfFloat(0, 256); // диапазон

        ArrayList<Mat> blue = new ArrayList<>();
        blue.add(rgb.get(0));
        ArrayList<Mat> green = new ArrayList<>();
        green.add(rgb.get(1));
        ArrayList<Mat> red = new ArrayList<>();
        red.add(rgb.get(2));

        Mat bluem = new Mat();
        Mat greenm = new Mat();
        Mat reedm = new Mat();

        calcHist(blue, new MatOfInt(0), new Mat(), bluem, histSize, ranges);
        calcHist(green, new MatOfInt(0), new Mat(), greenm, histSize, ranges);
        calcHist(red, new MatOfInt(0), new Mat(), reedm, histSize, ranges);

        ArrayList<Point[]> diagram = new ArrayList<>();
        diagram.add(MatToPoints(reedm));
        diagram.add(MatToPoints(greenm));
        diagram.add(MatToPoints(bluem));
        return diagram;
    }

    public ArrayList<Point[]> getLABhist() {
        Mat rgbImg = Imgcodecs.imread(imageURL);
        Mat labImg = new Mat();
        Imgproc.cvtColor(rgbImg, labImg, COLOR_RGB2Lab);

        ArrayList<Mat> lab = new ArrayList<>();
        split(labImg, lab);

        MatOfInt histSize = new MatOfInt(255); // кол-во бункеров
        MatOfFloat ranges = new MatOfFloat(0, 256); // диапазон

        ArrayList<Mat> l = new ArrayList<>();
        l.add(lab.get(0));
        ArrayList<Mat> a = new ArrayList<>();
        a.add(lab.get(1));
        ArrayList<Mat> b = new ArrayList<>();
        b.add(lab.get(2));

        Mat lm = new Mat();
        Mat am = new Mat();
        Mat bm = new Mat();

        calcHist(l, new MatOfInt(0), new Mat(), lm, histSize, ranges);
        calcHist(a, new MatOfInt(0), new Mat(), am, histSize, ranges);
        calcHist(b, new MatOfInt(0), new Mat(), bm, histSize, ranges);

        ArrayList<Point[]> diagram = new ArrayList<>();
        diagram.add(MatToPoints(lm));
        diagram.add(MatToPoints(am));
        diagram.add(MatToPoints(bm));
        return diagram;
    }

    public ArrayList<Point[]> getCMYKhist() {
        Mat rgbImg = Imgcodecs.imread(imageURL);
        ArrayList<Mat> rgb = new ArrayList<>();
        split(rgbImg, rgb);

        Mat blue = rgb.get(0);
        Mat green = rgb.get(1);
        Mat red = rgb.get(2);

        int rows = rgbImg.rows();
        int cols = rgbImg.cols();

        Mat c = new Mat(rows, cols, CV_8UC1);
        Mat m = new Mat(rows, cols, CV_8UC1);
        Mat y = new Mat(rows, cols, CV_8UC1);
        Mat k = new Mat(rows, cols, CV_8UC1);

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                double[] r = red.get(i, j);
                double[] g = green.get(i, j);
                double[] b = blue.get(i, j);
                float[] cmykRe = getCMYK(Double.valueOf(r[0]).intValue(), Double.valueOf(g[0]).intValue(),
                        Double.valueOf(b[0]).intValue());
                c.put(i, j, cmykRe[0]);
                m.put(i, j, cmykRe[1]);
                y.put(i, j, cmykRe[2]);
                k.put(i, j, cmykRe[3]);
            }
        }

        ArrayList<Mat> cc = new ArrayList<>();
        cc.add(c);
        ArrayList<Mat> mm = new ArrayList<>();
        mm.add(m);
        ArrayList<Mat> yy = new ArrayList<>();
        yy.add(y);
        ArrayList<Mat> kk = new ArrayList<>();
        kk.add(k);

        MatOfInt histSize = new MatOfInt(255); // кол-во бункеров
        MatOfFloat ranges = new MatOfFloat(0, 256); // диапазон

        Mat cm = new Mat();
        Mat mmm = new Mat();
        Mat ym = new Mat();
        Mat km = new Mat();

        calcHist(cc, new MatOfInt(0), new Mat(), cm, histSize, ranges);
        calcHist(mm, new MatOfInt(0), new Mat(), mmm, histSize, ranges);
        calcHist(yy, new MatOfInt(0), new Mat(), ym, histSize, ranges);
        calcHist(kk, new MatOfInt(0), new Mat(), km, histSize, ranges);

        ArrayList<Point[]> diagram = new ArrayList<>();
        diagram.add(MatToPoints(cm));
        diagram.add(MatToPoints(mmm));
        diagram.add(MatToPoints(ym));
        diagram.add(MatToPoints(km));
        return diagram;
    }


    public Point[] MatToPoints(Mat mat) {
        Point[] points = new Point[256];
        int rows = mat.rows();
        int cols = mat.cols();
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                double[] data = mat.get(i, j);
                points[i] = new Point(i, data[0]);
            }
        }
        return points;
    }

    public static float[] getCMYK(int red, int green, int blue) {
        float[] list = new float[4];
        float r;
        float g;
        float b;
        float highestValue;
        r = red / 255f;
        g = green / 255f;
        b = blue / 255f;
        highestValue = Math.max(r, g);
        highestValue = Math.max(highestValue, b);
        list[0] = (1 - r - list[3]) / (1 - list[3]);
        list[1] = (1 - g - list[3]) / (1 - list[3]);
        list[2] = (1 - b - list[3]) / (1 - list[3]);
        list[3] = (float) 1 - highestValue;
        return list;
    }
}