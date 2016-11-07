import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.File;
import java.io.IOException;

/**
 * Created by Гога on 25.09.2016.
 */
public class FrameWindow extends Frame implements ActionListener, WindowListener {
    private TextArea textArea;
    private MenuBar menuBar;
    private File f;
    private File dir;

    private Menu menu;
    private MenuItem menuItemOpen;
    private MenuItem menuItemSearch;
    private MenuItem menuItemExit;
    private FileDialog fileDialog;

    public FrameWindow(String szTitle) {
        super(szTitle);
        setSize(400, 300);
        this.setLocation(450, 250);
        this.setVisible(true);
        menuBar = new MenuBar();
        menu = new Menu("File");

        menuItemOpen = new MenuItem("Open File...");
        menu.add(menuItemOpen);

        menuItemSearch = new MenuItem("Search File...");
        menu.add(menuItemSearch);

        menu.add("-");

        menuItemExit = new MenuItem("Exit");
        menu.add(menuItemExit);

        menuBar.add(menu);

        menuItemOpen.addActionListener(this);
        menuItemSearch.addActionListener(this);
        menuItemExit.addActionListener(this);

        setMenuBar(menuBar);

        this.addWindowListener(this);

        textArea = new TextArea(10, 30);
        setLayout(new BorderLayout());
        add("Center", textArea);
    }

    // Обработка нажатий
    public void actionPerformed(ActionEvent e) {
        if (e.getSource().equals(menuItemOpen)) {
            fileDialog = new FileDialog(this, "Open File", FileDialog.LOAD);
            fileDialog.show();
            f = new File(fileDialog.getDirectory() + fileDialog.getFile());
            if (fileDialog.getFile() != null)
                textArea.setText("File add...\nPlease enter directory");
        } else if (e.getSource().equals(menuItemSearch)) {
            try {
                dir = new File(textArea.getText()); //папка, в которой мы будем искать файл
                Main.manage(256, 32, f, dir, textArea);//вызов функции, которая выделяет сигнатуру, начиная со смещения 512 длиной 32
            } catch (IOException | NullPointerException e1) {
                textArea.setText("Incorrect directory");
            }
        } else if (e.getSource().equals(menuItemExit)) {
            setVisible(false);
            System.exit(0);
        }
    }

    public void windowClosing(WindowEvent e) {
        setVisible(false);
        System.exit(0);
    }

    public void windowOpened(WindowEvent e) {
    }

    public void windowClosed(WindowEvent e) {
    }

    public void windowIconified(WindowEvent e) {
    }

    public void windowDeiconified(WindowEvent e) {
    }

    public void windowActivated(WindowEvent e) {
    }

    public void windowDeactivated(WindowEvent e) {
    }
}
