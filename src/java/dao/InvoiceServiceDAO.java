package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import model.InvoiceService;
import model.InvoiceSparePart;
import model.Service;
import model.SparePart;

/**
 *
 * @author ADMIN
 */
public class InvoiceServiceDAO extends DAO {

    public InvoiceServiceDAO() {
    }

    public List<InvoiceService> getInvoiceService(int idInvoice) {
        List<InvoiceService> list = new ArrayList<>();

        String sql = "SELECT ise.id, ise.numOfTime,(ise.numOfTime*s.price) as subTotal, s.id as serviceId,s.price,s.name "
                + "FROM tblinvoiceservice ise "
                + "LEFT JOIN  tblservice s ON ise.tblserviceid = s.id "
                + "WHERE ise.tblinvoiceid = ?;";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInvoice);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InvoiceService invoiceService = new InvoiceService();
                    Service service = new Service();
                    Invoice invoice = new Invoice();
                    
                    invoice.setId(idInvoice);
                    
                    invoiceService.setId(rs.getInt("id"));
                    invoiceService.setNumOfTime(rs.getInt("numOfTime"));
                    invoiceService.setSubTotal(rs.getInt("subTotal"));
                    
                    service.setId(rs.getInt("serviceId"));
                    service.setPrice(rs.getFloat("price"));
                    service.setName(rs.getString("name"));
                    
                    invoiceService.setInvoice(invoice);
                    invoiceService.setService(service);
                           
                    
                    list.add(invoiceService);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;

    }
    public boolean addInvoiceService(InvoiceService invoiceS) {
        String sql = "INSERT INTO tblinvoiceservice ( tblinvoiceid,numOfTime,tblserviceid) "
                   + "VALUES (?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, invoiceS.getInvoice().getId());
            ps.setInt(2, invoiceS.getNumOfTime());
            ps.setInt(3, invoiceS.getService().getId());

            int rows = ps.executeUpdate();
            return rows > 0; // trả về true nếu thêm thành công

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean updateInvoiceService(InvoiceService invoiceS) {
        String sql = "UPDATE tblinvoiceservice SET numOfTime = ? WHERE id = ?";
                   
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, invoiceS.getNumOfTime());
            ps.setInt(2, invoiceS.getId());
            

            int rows = ps.executeUpdate();
            return rows > 0; // trả về true nếu thêm thành công

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    } 
}
