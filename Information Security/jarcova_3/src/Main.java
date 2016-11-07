import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import java.util.HashSet;

/**
 * Created by Гога on 15.10.2016.
 */

class Main extends JFrame {
    private JLabel loginText = new JLabel("Введите логин:  ");
    private JTextField loginField = new JTextField();
    private JLabel passwordText = new JLabel("Введите пароль:");
    private JTextField passwordField = new JTextField();
    private JLabel regLoginText = new JLabel("Введите логин:");
    private JTextField regLoginField = new JTextField();
    private JLabel regPasswordText = new JLabel("Введите пароль:");
    private JTextField regPasswordField = new JTextField();
    private JLabel regPasswordText2 = new JLabel("Повторите пароль:");
    private JTextField regPasswordField2 = new JTextField();
    private JButton enterButton = new JButton("Войти в систему");
    private JButton exitButton = new JButton("Выйти из системы");
    private JButton regButton = new JButton("Зарегистрироваться");


    private boolean isOpen = false;
    private boolean dataStatus = false;
    private String login;
    private String directory = "C:\\Users\\Гога\\IdeaProjects\\jarcova_3\\users\\";


    public static void main(String[] args) throws Exception {
        Main app = new Main();
        app.setVisible(true);
    }

    public Main() {
        super("Личный кабинет");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 600);
        setLocation(300, 100);
        setVisible(true);
        JPanel panel = new JPanel(new GridLayout(4, 1));
        add(panel);
        panel.setBackground(Color.GRAY);
        Dimension fieldSize = new Dimension(300, 40);

        // Форма входа
        JPanel flowLog = new JPanel(new FlowLayout(FlowLayout.CENTER));
        flowLog.setBackground(Color.lightGray);
        JPanel gridLog = new JPanel(new GridLayout(1, 2));
        gridLog.setBackground(Color.lightGray);
        gridLog.add(loginText);
        gridLog.add(loginField);
        flowLog.add(gridLog);

        gridLog = new JPanel(new GridLayout(1, 2));
        gridLog.setBackground(Color.lightGray);
        gridLog.add(passwordText);
        gridLog.add(passwordField);
        flowLog.add(gridLog);

        loginField.setPreferredSize(fieldSize);
        passwordField.setPreferredSize(fieldSize);
        panel.add(flowLog);


        JPanel flow = new JPanel(new FlowLayout(FlowLayout.CENTER));
        flow.setBackground(Color.lightGray);
        flow.add(enterButton);
        flow.add(exitButton);
        panel.add(flow);

        // Форма регистрации
        flowLog = new JPanel(new FlowLayout(FlowLayout.CENTER));
        gridLog = new JPanel(new GridLayout(1, 2));
        gridLog.add(regLoginText);
        gridLog.add(regLoginField);
        flowLog.add(gridLog);

        gridLog = new JPanel(new GridLayout(1, 2));
        gridLog.add(regPasswordText);
        gridLog.add(regPasswordField);
        flowLog.add(gridLog);

        gridLog = new JPanel(new GridLayout(1, 2));
        gridLog.add(regPasswordText2);
        gridLog.add(regPasswordField2);
        flowLog.add(gridLog);

        regLoginField.setPreferredSize(fieldSize);
        regPasswordField.setPreferredSize(fieldSize);
        regPasswordField2.setPreferredSize(fieldSize);
        panel.add(flowLog);

        flow = new JPanel(new FlowLayout(FlowLayout.CENTER));
        flow.add(regButton);
        panel.add(flow);


        // Настрока цвета
        enterButton.setBackground(Color.WHITE);
        exitButton.setBackground(Color.WHITE);
        regButton.setBackground(Color.WHITE);


        this.enterButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    enter();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
            }
        });

        this.exitButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    exit();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }

            }
        });

        this.regButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    registration();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
            }
        });

    }

    //регистрация пользователя
    public void registration() throws Exception {
        String login = regLoginField.getText();
        String password = regPasswordField.getText();
        String password2 = regPasswordField2.getText();
        if (login.equals("")) {
            regLoginField.replaceSelection("Введите логин!");
        }
        if (password.equals("")) {
            regPasswordField.replaceSelection("Введите пароль!");
        }
        if (password.equals("")) {
            regPasswordField2.replaceSelection("Повторите пароль!");
        }

        if (!password.equals(password2)) {
            regPasswordField2.setText("Введите одинаковые пароли!");
        } else {
            if (!password.equals("") && !login.equals("")) {
                BufferedWriter out = new BufferedWriter(new FileWriter("security.txt", true));
                BufferedReader securityBase = new BufferedReader(new FileReader("security.txt"));
                HashSet users = new HashSet();
                String str;
                while ((str = securityBase.readLine()) != null) {
                    str = str.substring(0, str.indexOf(' '));
                    users.add(str);
                }
                String user = login;
                login = Support.crc32(login);
                password = Support.crc32(password);

                if (!users.contains(login)) {
                    File myPath = new File(directory + user);
                    myPath.mkdirs();
                    out.append(login + "   " + password + "\r\n");
                    regLoginField.setText("");
                    regLoginField.replaceSelection("Вы успешно зарегистрированы!");
                    regPasswordField.setText("");
                    regPasswordField2.setText("");
                } else {
                    regLoginField.setText("");
                    regLoginField.replaceSelection("Пользователь с таким именем уже существует!");
                    regPasswordField.setText("");
                    regPasswordField2.setText("");
                }
                securityBase.close();
                out.close();
            }
        }
    }

    //выход из системы
    public void exit() throws Exception {
        if (!dataStatus) {
            closeAccess();
            loginField.setText("");
            passwordField.setText("");
            loginField.replaceSelection("Вы успешно покинули систему!");
        }
    }

    //вход в систему
    public void enter() throws Exception {
        if (!isOpen) {
            BufferedReader securityBase = null;
            boolean fl = false;
            try {
                securityBase = new BufferedReader(new FileReader("security.txt"));
                fl = true;
            } catch (FileNotFoundException e) {
                loginField.setText("Не верно введен логин или пароль!");
                passwordField.setText("");
                fl = false;
            }
            if (fl) {
                HashSet users = new HashSet();
                String str;
                String login = loginField.getText();
                String password = passwordField.getText();
                while ((str = securityBase.readLine()) != null) {
                    users.add(str);
                }
                this.login = login;
                login = Support.crc32(login);
                password = Support.crc32(password);

                if (users.contains(login + "   " + password)) {
                    loginField.setText("");
                    loginField.replaceSelection("Вы успешно авторизованы!");
                    passwordField.setText("");
                    openAccess();
                } else {
                    loginField.setText("");
                    loginField.replaceSelection("Не верно введен логин или пароль!");
                    passwordField.setText("");
                }
                securityBase.close();
            }
        }
    }

    // завершение сеанса пользователя, кодировка всех фалов
    public void closeAccess() throws IOException {
        File dir = new File(directory + login);
        String s[] = dir.list();

        int i = -1;
        String dire = directory + login + "\\";

        while (true) {
            i = justDoIt(dire, s);

            if (i == -1) {
                break;
            }
            dire = directory + login + "\\" + s[i] + "\\";
            dir = new File(dire);
            s = dir.list();
            if (s.length < 1)
                break;
        }
        dataStatus = true;
        isOpen = false;
    }

    public int justDoIt(String dire, String[] s) throws IOException {
        for (int i = 0; i < s.length; i++) {
            FileInputStream inputStream = null;
            try {
                inputStream = new FileInputStream(dire + s[i]);
            } catch (FileNotFoundException e) {
                return i;
            }
            //количество байтов, доступных для чтения в настоящий момент;
            int count = inputStream.available();
            InputStream in = new BufferedInputStream(new FileInputStream(dire + s[i]), count);
            int item = in.read();
            OutputStream out = new BufferedOutputStream(new FileOutputStream(dire + s[i]));
            int j = 0;
            int mas[] = new int[count];
            mas[j] = item;
            while ((item = in.read()) != -1) {
                j++;
                mas[j] = item;
            }
            mas = Support.breakData(mas, count);
            while (j >= 0) {
                out.write(mas[j]);
                j--;
            }
            inputStream.close();
            in.close();
            out.close();
        }
        return -1;
    }

    // открытие сенса пользователя, расшифровка всех файлов
    public void openAccess() throws IOException {
        File dir = new File(directory + login);
        String s[] = dir.list();

        int i = -1;
        String dire = directory + login + "\\";

        while (true) {
            i = justDoItTwo(dire, s);

            if (i == -1) {
                break;
            }
            dire = directory + login + "\\" + s[i] + "\\";
            dir = new File(dire);
            s = dir.list();
            if (s.length < 1)
                break;
        }

        isOpen = true;
        dataStatus = false;
        dir = new File(directory + login);
        Desktop.getDesktop().open(dir);
    }

    public int justDoItTwo(String dire, String[] s) throws IOException {
        for (int i = 0; i < s.length; i++) {
            FileInputStream inputStream = null;
            try {
                inputStream = new FileInputStream(dire + s[i]);
            } catch (FileNotFoundException e) {
                return i;
            }
            int count = inputStream.available();
            InputStream in = new BufferedInputStream(new FileInputStream(dire + s[i]), count);
            int item = in.read();
            OutputStream out = new BufferedOutputStream(new FileOutputStream(dire + s[i]));
            int j = 0, mas[] = new int[count];
            mas[j] = item;
            while ((item = in.read()) != -1) {
                j++;
                mas[j] = item;
            }
            mas = Support.buildData(mas, count);
            while (j >= 0) {
                out.write(mas[j]);
                j--;
            }
            inputStream.close();
            in.close();
            out.close();
        }
        return -1;
    }
}