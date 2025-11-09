/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Employee;
import model.Service;

/**
 *
 * @author ADMIN
 */
public class EmployeeDAO extends DAO{

    public EmployeeDAO() {
        
    }
    public Employee getEmployee(){
        Employee s = null;
        String sql = "SELECT * FROM tblemployee WHERE id = ?";

        try (PreparedStatement ps = super.conn.prepareStatement(sql)) {
            ps.setInt(1, 2);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    s = new Employee();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setPhone(rs.getString("phone"));
                    s.setEmail(rs.getString("email"));
                    s.setRole(rs.getString("role"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return s;
    }
    public Employee checkLogin(Employee e) throws SQLException{
        String sql="select * from tblemployee where username=? and password=?";
        try(PreparedStatement ps =conn.prepareStatement(sql)){
            ps.setString(1, e.getUsername());
            ps.setString(2, e.getPassword());
            try(ResultSet rs = ps.executeQuery()){
                if (rs.next()) {
                Employee emp = new Employee();
                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setPhone(rs.getString("phone"));
                emp.setEmail(rs.getString("email"));
                emp.setUsername(rs.getString("username"));
                emp.setRole(rs.getString("role"));
                emp.setDob(rs.getDate("dob"));
                return emp;
            } else {
                return null;
            }            }
        }
    }
    
}
