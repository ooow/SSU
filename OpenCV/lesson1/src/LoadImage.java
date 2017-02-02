import javax.swing.*;
import java.awt.*;

public class LoadImage extends JFrame {
    public LoadImage() {
        super("OpenCV");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 600);
        centerFrame(this);
        setResizable(false);
        JPanel panel = new JPanel(new GridLayout(2, 2));
        panel.setBackground(Color.gray);

        Font font = new Font("Verdana", Font.PLAIN, 20);

        JLabel label1 = new JLabel("before", JLabel.CENTER);
        JLabel label2 = new JLabel("after", JLabel.CENTER);

        label1.setForeground(Color.white);
        label2.setForeground(Color.white);
        label1.setFont(font);
        label2.setFont(font);

        panel.add(label1);
        panel.add(label2);

        JLabel img = new JLabel(new ImageIcon("phone.png"));
        JLabel img1 = new JLabel(new ImageIcon("phone2.png"));

        panel.add(img);
        panel.add(img1);

        setContentPane(panel);
    }


    // функция перемещающая окно в цент экрана
    public static void centerFrame(Window frame) {
        Dimension screenSize = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
        int x = (int) ((screenSize.getWidth() - frame.getWidth()) / 2);
        if (x < 0) {
            x = 0;
        }
        int y = (int) ((screenSize.getHeight() - frame.getHeight()) / 2);
        if (y < 0) {
            y = 0;
        }
        frame.setBounds(x, y, frame.getWidth(), frame.getHeight());
    }
}
