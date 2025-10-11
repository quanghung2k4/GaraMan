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
public class InvoiceSparePartDAO extends DAO{

    public InvoiceSparePartDAO() {
    }
    public List<InvoiceSparePart> getInvoiceSparePart(int idInvoice){
        List<InvoiceSparePart> list = new ArrayList<>();
        
         String sql = "SELECT * FROM tblinvoicesparepart WHERE tblinvoiceid=?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInvoice);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InvoiceSparePart invoiceSparePart = new InvoiceSparePart();
                    SparePart sparePare = new SparePart();
                    Invoice invoice = new Invoice();
                    
                    invoiceSparePart.setId(rs.getInt("id"));
                    invoiceSparePart.setQuantity(rs.getInt("quantity"));
                    sparePare.setId(rs.getInt("tblsparepartid"));
                    invoice.setId(rs.getInt("tblinvoiceid"));
                    
                    invoiceSparePart.setInvoice(invoice);
                    invoiceSparePart.setSparePart(sparePare);
                    list.add(invoiceSparePart);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;

    }
}
