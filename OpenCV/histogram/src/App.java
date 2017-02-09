import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Button;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import org.opencv.core.Point;

import java.io.File;
import java.util.ArrayList;

public class App extends Application {
    private LineChart<Number, Number> lineChart;
    private LineChart<Number, Number> lineChart2;
    private LineChart<Number, Number> lineChart3;
    private ImageView imageView;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage app) throws Exception {
        app.setTitle("Histogram Controller");
        app.setWidth(1024);
        app.setHeight(680);
        Pane root = new Pane();

        Button btn = new Button("Load Image");
        btn.setLayoutX(462);
        btn.setLayoutY(2);
        btn.setPrefSize(100, 20);
        Scene scene = new Scene(root);

        btn.setOnAction(event -> {
            FileChooser fileChooser = new FileChooser();
            fileChooser.setTitle("Load image");
            FileChooser.ExtensionFilter extFilter = new FileChooser.ExtensionFilter("PNG or JPG files (*.png)", "*.png", "*.jpg");
            fileChooser.getExtensionFilters().add(extFilter);
            File file = fileChooser.showOpenDialog(scene.getWindow());
            if (file != null) {
                root.getChildren().remove(imageView);
                imageView = new ImageView(file.toURI().toString());
                imageView.setLayoutX(30);
                imageView.setLayoutY(30);
                imageView.setFitWidth(400);
                imageView.setFitHeight(310);
                imageView.setPreserveRatio(true);
                imageView.setSmooth(true);
                imageView.setCache(true);
                root.getChildren().add(imageView);

                root.getChildren().remove(lineChart);
                root.getChildren().remove(lineChart2);
                root.getChildren().remove(lineChart3);
                calculateNewImageHist(root, file.toString());
            }
        });


        root.getChildren().add(btn);


        scene.getStylesheets().add((new File("style.css")).toURI().toURL().toExternalForm());
        app.setScene(scene);
        app.show();
    }

    public void calculateNewImageHist(Pane root, String file) {
        HistogramCalculate main = new HistogramCalculate(file);

        ArrayList<Point[]> rgb = main.getRGBhist();
        lineChart = new LineChart<>(new NumberAxis(0, 255, 15), new NumberAxis());
        lineChart.setCreateSymbols(false);
        lineChart.setTitle("RGB Image");

        Point[] red = rgb.get(0);
        Point[] green = rgb.get(1);
        Point[] blue = rgb.get(2);

        ObservableList<XYChart.Data> redData = FXCollections.observableArrayList();
        ObservableList<XYChart.Data> greenData = FXCollections.observableArrayList();
        ObservableList<XYChart.Data> blueData = FXCollections.observableArrayList();
        loadData(redData, red);
        loadData(greenData, green);
        loadData(blueData, blue);

        XYChart.Series seriesR = new XYChart.Series();
        seriesR.setName("red");

        seriesR.setData(redData);
        lineChart.getData().add(seriesR);

        XYChart.Series seriesG = new XYChart.Series();
        seriesG.setName("green");
        seriesG.setData(greenData);
        lineChart.getData().add(seriesG);

        XYChart.Series seriesB = new XYChart.Series();
        seriesB.setName("blue");
        seriesB.setData(blueData);
        lineChart.getData().add(seriesB);

////////////////

        ArrayList<Point[]> lab = main.getLABhist();
        lineChart2 = new LineChart<>(new NumberAxis(0, 255, 15), new NumberAxis());
        lineChart2.setCreateSymbols(false);
        lineChart2.setTitle("LAB Image");

        Point[] l = lab.get(0);
        Point[] a = lab.get(1);
        Point[] b = lab.get(2);

        ObservableList<XYChart.Data> lData = FXCollections.observableArrayList();
        ObservableList<XYChart.Data> aData = FXCollections.observableArrayList();
        ObservableList<XYChart.Data> bData = FXCollections.observableArrayList();
        loadData(lData, l);
        loadData(aData, a);
        loadData(bData, b);

        XYChart.Series seriesL = new XYChart.Series();
        seriesL.setName("l");

        seriesL.setData(lData);
        lineChart2.getData().add(seriesL);

        XYChart.Series seriesA = new XYChart.Series();
        seriesA.setName("a");
        seriesA.setData(aData);
        lineChart2.getData().add(seriesA);

        XYChart.Series seriesBb = new XYChart.Series();
        seriesBb.setName("b");
        seriesBb.setData(bData);
        lineChart2.getData().add(seriesBb);

////////////////

        ArrayList<Point[]> cmyk = main.getCMYKhist();
        lineChart3 = new LineChart<>(new NumberAxis(0, 15, 1), new NumberAxis());
        lineChart3.setCreateSymbols(false);
        lineChart3.setTitle("CMYK Image");

        Point[] c = cmyk.get(0);
        Point[] m = cmyk.get(1);
        Point[] y = cmyk.get(2);
        Point[] k = cmyk.get(3);

        ObservableList<XYChart.Data> cData = FXCollections.observableArrayList();
        ObservableList<XYChart.Data> mData = FXCollections.observableArrayList();
        ObservableList<XYChart.Data> yData = FXCollections.observableArrayList();
        ObservableList<XYChart.Data> kData = FXCollections.observableArrayList();
        loadData(cData, c);
        loadData(mData, m);
        loadData(yData, y);
        loadData(kData, k);

        XYChart.Series seriesC = new XYChart.Series();
        seriesC.setName("c");
        seriesC.setData(cData);
        lineChart3.getData().add(seriesC);

        XYChart.Series seriesM = new XYChart.Series();
        seriesM.setName("m");
        seriesM.setData(mData);
        lineChart3.getData().add(seriesM);

        XYChart.Series seriesY = new XYChart.Series();
        seriesY.setName("y");
        seriesY.setData(yData);
        lineChart3.getData().add(seriesY);

        XYChart.Series seriesK = new XYChart.Series();
        seriesK.setName("k");
        seriesK.setData(kData);
        lineChart3.getData().add(seriesK);

////////////////

        lineChart.setTranslateX(512);
        lineChart.setTranslateY(20);
        lineChart.setPrefSize(512, 320);

        lineChart2.setTranslateX(0);
        lineChart2.setTranslateY(340);
        lineChart2.setPrefSize(512, 320);

        lineChart3.setTranslateX(512);
        lineChart3.setTranslateY(340);
        lineChart3.setPrefSize(512, 320);

        root.getChildren().add(lineChart);
        root.getChildren().add(lineChart2);
        root.getChildren().add(lineChart3);
    }

    public void loadData(ObservableList<XYChart.Data> data, Point[] points) {
        for (int i = 0; i < points.length - 1; i++) {
            data.add(new XYChart.Data(points[i].x, points[i].y));
        }
    }
}