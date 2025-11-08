package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.SparePart;

/**
 *
 * @author ADMIN
 */
public class SparePartDAO extends DAO {
    
    public List<SparePart> getAllSparePart() {
        List<SparePart> list = new ArrayList<>();

        String sql = "SELECT sp.id, sp.name, sp.quantity, sp.unitPrice, sp.description, "
                + "       COALESCE(SUM(idt.quantity), 0) AS soldNum "
                + "FROM tblsparepart sp "
                + "LEFT JOIN tblinvoicesparepart idt "
                + "       ON sp.id = idt.tblsparepartid "
                + "GROUP BY sp.id, sp.name, sp.quantity, sp.unitPrice, sp.description "
                + "ORDER BY sp.id;";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SparePart sp = new SparePart(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("quantity"),
                            rs.getInt("soldNum"),
                            rs.getFloat("unitPrice"),
                            rs.getString("description")
                    );
                    list.add(sp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    // 🔍 Tìm kiếm linh kiện, có cả số lượng đã bán (soldNum)

    public List<SparePart> searchSparePart(String name) {
        List<SparePart> list = new ArrayList<>();

        String sql = "SELECT sp.id, sp.name, sp.quantity, sp.unitPrice, sp.description, "
                + "       COALESCE(SUM(idt.quantity), 0) AS soldNum "
                + "FROM tblsparepart sp "
                + "LEFT JOIN tblinvoicesparepart idt "
                + "       ON sp.id = idt.tblsparepartid "
                + "WHERE sp.name LIKE ? OR sp.description LIKE ? "
                + "GROUP BY sp.id, sp.name, sp.quantity, sp.unitPrice, sp.description "
                + "ORDER BY sp.id;";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ps.setString(2, "%" + name + "%");

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SparePart sp = new SparePart(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("quantity"),
                            rs.getInt("soldNum"),
                            rs.getFloat("unitPrice"),
                            rs.getString("description")
                    );
                    list.add(sp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public SparePart getSparePartByID(int idSparePart) {
        SparePart sparePart = null;

        String sql = "SELECT sp.id, sp.name, sp.quantity, sp.unitPrice, sp.description, "
                + "       COALESCE(SUM(idt.quantity), 0) AS soldNum "
                + "FROM tblsparepart sp "
                + "LEFT JOIN tblinvoicesparepart idt "
                + "       ON sp.id = idt.tblsparepartid "
                + "WHERE sp.id = ? "
                + "GROUP BY sp.id, sp.name, sp.quantity, sp.unitPrice, sp.description;";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSparePart);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    sparePart = new SparePart(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("quantity"),
                            rs.getInt("soldNum"),
                            rs.getFloat("unitPrice"),
                            rs.getString("description")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getSparePartByID: " + e.getMessage());
        }

        return sparePart;
    }

    public boolean updateSparePart(SparePart sp) throws SQLException {
        String sql = "UPDATE tblsparepart SET quantity = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, sp.getQuanity());
            ps.setInt(2, sp.getId());
            
            int row = ps.executeUpdate();
            return row > 0;
        }
    }

}
