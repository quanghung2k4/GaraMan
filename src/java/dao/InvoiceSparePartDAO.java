/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import model.InvoiceSparePart;
import model.SparePart;

/**
 *
 * @author ADMIN
 */
public class InvoiceSparePartDAO extends DAO {

    public InvoiceSparePartDAO() {
    }

    public List<InvoiceSparePart> getInvoiceSparePart(int idInvoice) {
        List<InvoiceSparePart> list = new ArrayList<>();

        String sql = " SELECT isp.id, isp.quantity,(isp.quantity*sp.unitPrice) as subTotal, sp.id as sparepartId,sp.unitPrice as price,sp.name, sp.quantity as quantity_sp"
                + " FROM tblinvoicesparepart isp "
                + " LEFT JOIN  tblsparepart sp ON isp.tblsparepartid = sp.id "
                + " WHERE isp.tblinvoiceid = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInvoice);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InvoiceSparePart invoiceSparePart = new InvoiceSparePart();
                    SparePart sparePart = new SparePart();
                    Invoice invoice = new Invoice();

                    invoiceSparePart.setId(rs.getInt("id"));
                    invoiceSparePart.setQuantity(rs.getInt("quantity"));
                    invoiceSparePart.setSubTotal(rs.getFloat("subTotal"));

                    sparePart.setId(rs.getInt("sparepartId"));
                    sparePart.setUnitPrice(rs.getFloat("price"));
                    sparePart.setName(rs.getString("name"));
                    sparePart.setQuanity(rs.getInt("quantity_sp"));
                    
                    invoice.setId(idInvoice);
                    invoiceSparePart.setInvoice(invoice);
                    invoiceSparePart.setSparePart(sparePart);
                    list.add(invoiceSparePart);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;

    }

     public boolean addInvoiceSparePart(InvoiceSparePart invoiceSP) {
        String sql = "INSERT INTO tblinvoicesparepart ( quantity, tblinvoiceid,tblsparepartid) "
                   + "VALUES (?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, invoiceSP.getQuantity());
            ps.setInt(2, invoiceSP.getInvoice().getId());
            ps.setInt(3, invoiceSP.getSparePart().getId());

            int rows = ps.executeUpdate();
            return rows > 0; // trả về true nếu thêm thành công

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean updateInvoiceSparePart(InvoiceSparePart invoiceSP) {
        String sql = "UPDATE tblinvoicesparepart SET quantity = ? WHERE id = ?";
                   

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, invoiceSP.getQuantity());
            ps.setInt(2, invoiceSP.getId());
            

            int rows = ps.executeUpdate();
            return rows > 0; // trả về true nếu thêm thành công

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    } 

}
