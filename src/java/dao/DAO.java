package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    protected static final String URL = "jdbc:mysql://localhost:3306/gara_oto?useSSL=false&serverTimezone=UTC";
    protected static final String USER = "root";
    protected static final String PASSWORD = "";

    protected Connection conn;

    public DAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Kết nối DB thành công (DAO)");
        } catch (Exception e) {
            System.err.println("❌ Lỗi kết nối: " + e.getMessage());
        }
    }

    public void close() {
        try {
            if (conn != null && !conn.isClosed()) conn.close();
        } catch (SQLException e) {
            System.err.println("❌ Không thể đóng kết nối: " + e.getMessage());
        }
    }
}
