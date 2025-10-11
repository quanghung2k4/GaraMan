package dao;

import java.sql.*;
import model.*;
import java.util.*;

public class InvoiceDAO extends DAO {

    // Lấy hóa đơn theo id khách hàng
    public Invoice getInvoiceByCustomer(int idCustomer) {
        Invoice invoice = null;
        String sql = "SELECT * FROM Invoice WHERE tblcustomerid = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idCustomer);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer(); 
                customer.setId(idCustomer);
                invoice = new Invoice();
                invoice.setId(rs.getInt("id"));
                invoice.setDate(rs.getDate("createAt"));
                invoice.setTotalAmount(rs.getFloat("totalAmount"));
                invoice.setStatus(rs.getString("status"));
                invoice.setCustomer(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return invoice;
    }

    // Cập nhật thông tin hóa đơn
    public boolean updateInvoice(Invoice invoice) {
        String sql = "UPDATE Invoice SET date=?, totalAmount=?, status=?, salesStaff_id=?, customer_id=? WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(invoice.getDate().getTime()));
            ps.setFloat(2, invoice.getTotalAmount());
            ps.setString(3, invoice.getStatus());
            ps.setInt(4, invoice.getSalesStaff().getId());
            ps.setInt(5, invoice.getCustomer().getId());
            ps.setInt(6, invoice.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
