
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.FileInputStream;

public class Main {
    public static void main(String args[]) {
        FrameWindow frame;
        frame = new FrameWindow("File Checksum calculation");
        frame.setVisible(true);
    }
}

// =======================================
// Class FrameWindow
// =======================================
class FrameWindow extends Frame implements ActionListener, WindowListener {
    TextArea textArea;
    MenuBar menuBar;

    Menu menu;
    MenuItem menuItemOpen;
    MenuItem menuItemClean;
    MenuItem menuItemExit;

    FileDialog fileDialog;

    // ============================================
    // FrameWindow
    // ============================================
    public FrameWindow(String szTitle) {
        super(szTitle);
        setSize(400, 300);
        menuBar = new MenuBar();
        menu = new Menu("File");

        menuItemOpen = new MenuItem("Open...");
        menu.add(menuItemOpen);

        menuItemClean = new MenuItem("Clean");
        menu.add(menuItemClean);

        menu.add("-");

        menuItemExit = new MenuItem("Exit");
        menu.add(menuItemExit);

        menuBar.add(menu);

        menuItemOpen.addActionListener(this);
        menuItemClean.addActionListener(this);
        menuItemExit.addActionListener(this);

        setMenuBar(menuBar);

        this.addWindowListener(this);

        textArea = new TextArea(10, 30);

        setLayout(new BorderLayout());
        add("Center", textArea);
    }

    // ============================================
    // actionPerformed
    // ============================================
    public void actionPerformed(ActionEvent e) {
        if (e.getSource().equals(menuItemOpen)) {
            fileDialog = new FileDialog(this, "Open file", FileDialog.LOAD);
            fileDialog.show();

            String szPath = fileDialog.getDirectory() + fileDialog.getFile();

            byte[] bytes = fileDialog.getFile().getBytes();


            textArea.append("Open: " + szPath + "\n");

            textArea.append("CRC-32: " + calculate(szPath, new MyCRC32()) + "\n");

        } else if (e.getSource().equals(menuItemClean)) {
            textArea.setText("");
        } else if (e.getSource().equals(menuItemExit)) {
            setVisible(false);
            System.exit(0);
        }
    }

    // ============================================
    // calculate CS
    // ============================================
    String calculate(String szPath, MyCRC32 cs) {
        String s = "";
        byte[] buf = new byte[8000];

        try {
            FileInputStream fis = new FileInputStream(szPath);

            while (true) {
                int length = fis.read(buf);
                if (length < 0)
                    break;

                cs.update(buf, 0, length);
            }

            fis.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }

        s = new Long(cs.getValue()).toString();
        return s;
    }

    // ============================================
    // windowClosing
    // ============================================
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