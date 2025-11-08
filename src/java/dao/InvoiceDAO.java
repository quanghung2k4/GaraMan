package dao;

import java.sql.*;
import model.*;
import java.util.*;

public class InvoiceDAO extends DAO {

    // Lấy hóa đơn theo id khách hàng
    public Invoice getInvoiceByCustomer(int idCustomer) {
        Invoice invoice = null;
        String sql = "SELECT i.id as idInvoice, i.createAt, i.totalAmount, i.tblsalesstaffid, c.name as nameCustomer, "
                + "c.phone as phoneCustomer, c.address as addressCustomer "
                + "FROM tblinvoice i "
                + "LEFT JOIN tblcustomer c ON i.tblcustomerid = c.id "
                + "WHERE i.tblcustomerid = ? AND i.status <> ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idCustomer);
            ps.setString(2, "Da thanh toan");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                SaleStaff saleStaff = new SaleStaff();
                invoice = new Invoice();
                
                
                
                invoice.setId(rs.getInt("idInvoice"));
                invoice.setCreateAt(rs.getDate("createAt"));
                invoice.setTotalAmount(rs.getFloat("totalAmount"));
                
                saleStaff.setId(rs.getInt("tblsalesstaffid"));
                
                
                
                customer.setId(idCustomer);
                customer.setName(rs.getString("nameCustomer"));
                customer.setPhone(rs.getString("phoneCustomer"));
                customer.setAddress(rs.getString("addressCustomer"));
                
                invoice.setSalesStaff(saleStaff);
                invoice.setCustomer(customer);  
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return invoice;
    }

    // Cập nhật thông tin hóa đơn
    public boolean updateInvoice(Invoice invoice) {
        String sql = "UPDATE tblinvoice SET createAt=?, totalAmount=?, status=?, tblsalesstaffid=?, tblcustomerid=? WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(invoice.getCreateAt().getTime()));
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
