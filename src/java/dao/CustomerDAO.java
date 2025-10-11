package dao;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO extends DAO {

    // Tìm kiếm khách hàng theo tên (dùng LIKE)
    public List<Customer> searchCustomer(String name) {
        List<Customer> list = new ArrayList<>();

        // Nếu không nhập tên -> không tìm gì cả
        if (name == null || name.trim().isEmpty()) {
            return list; // trả về list rỗng
        }
        String sql = "SELECT * FROM tblcustomer WHERE name LIKE ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer c = new Customer(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("address")
                    );
                    list.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
