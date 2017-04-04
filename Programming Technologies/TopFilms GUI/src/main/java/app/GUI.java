package app;

import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.URL;

/**
 * Created by tirkiyaa@gmail.com on 04.04.17.
 */
public class GUI extends Application {
    private int startYear = 1990;
    private int endYear = 2017;

    public static void main(String[] args) throws IOException {
        launch(args);
    }

    public void start(Stage stage) throws Exception {
        stage.setTitle("Top Films");
        stage.setWidth(1000);
        stage.setHeight(520);
        Pane root = new Pane();
        Scene scene = new Scene(root);

        TextField from = new TextField("1990");
        from.setLayoutX(320);
        from.setLayoutY(5);
        from.setPrefSize(100, 20);

        TextField to = new TextField("2017");
        to.setLayoutX(560);
        to.setLayoutY(5);
        to.setPrefSize(100, 20);

        Button btn = new Button("Show");
        btn.setLayoutX(440);
        btn.setLayoutY(5);
        btn.setPrefSize(100, 20);

        root.getChildren().add(from);
        root.getChildren().add(to);
        root.getChildren().add(btn);


        btn.setOnAction(e -> {
            try {
                startYear = Integer.parseInt(from.getText()) - 1;
                endYear = Integer.parseInt(to.getText());
            } catch (NumberFormatException e1) {
                startYear = 2000;
                endYear = 2017;
            }
            if (startYear > endYear) {
                startYear = startYear + endYear;
                endYear = startYear - endYear + 1;
                startYear = startYear - endYear;
            }
            root.getChildren().clear();
            root.getChildren().add(from);
            root.getChildren().add(to);
            root.getChildren().add(btn);
            root.getChildren().add(makeChart());
        });

        stage.setScene(scene);
        stage.show();
    }

    public LineChart makeChart() {
        XYChart.Series series = new XYChart.Series();
        series.setName("year");

        ObservableList<XYChart.Data> films = getFilms();
        series.setData(films);
        int count = (endYear - startYear) / 10 + 1;
        LineChart lineChart = new LineChart<Number, Number>(new NumberAxis(startYear, endYear, count), new NumberAxis());
        lineChart.setCreateSymbols(false);
        lineChart.setTitle("Progress of Films By Years");
        lineChart.getData().add(series);

        lineChart.setTranslateX(20);
        lineChart.setTranslateY(40);
        lineChart.setPrefSize(960, 460);
        return lineChart;
    }

    public ObservableList<XYChart.Data> getFilms() {
        ObservableList<XYChart.Data> films = FXCollections.observableArrayList();
        for (int i = startYear; i <= endYear; i++) {
            String data = "";
            try {
                data = IOUtils.toString(new InputStreamReader(
                        new URL("http://localhost:8080/get-by-year?year=" + i)
                                .openConnection().getInputStream(), "UTF-8"));
            } catch (ConnectException e) {
                System.out.println("Connection error");
                break;
            } catch (IOException e) {
                e.printStackTrace();
            }

            int index = data.indexOf("year");
            int count = 1;
            while (index != -1) {
                index = data.indexOf("year", index + 4);
                count++;
            }
            films.add(new XYChart.Data(i, count));
        }
        return films;
    }
}