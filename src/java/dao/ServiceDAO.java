
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Service;

/**
 *
 * @author ADMIN
 */
public class ServiceDAO extends DAO{

    public ServiceDAO() {
        super();
    }
    
    // 🔍 Tìm kiếm dịch vụ theo từ khóa
    public List<Service> searchService(String name) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM tblservice WHERE name LIKE ? OR description LIKE ?";

        try (PreparedStatement ps = super.conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ps.setString(2, "%" + name + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service s = new Service();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setPrice(rs.getFloat("price"));
                    s.setNumOfStaff(rs.getInt("numOfStaff"));
                    s.setDuration(rs.getFloat("duration"));
                    s.setDescription(rs.getString("description"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔎 Lấy dịch vụ theo ID
    public Service getServiceByID(int idService) {
        Service s = null;
        String sql = "SELECT * FROM tblservice WHERE id = ?";

        try (PreparedStatement ps = super.conn.prepareStatement(sql)) {
            ps.setInt(1, idService);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    s = new Service();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setPrice(rs.getFloat("price"));
                    s.setNumOfStaff(rs.getInt("numOfStaff"));
                    s.setDuration(rs.getFloat("duration"));
                    s.setDescription(rs.getString("description"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return s;
    }
    
}
