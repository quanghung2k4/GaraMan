package servlet;

import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SearchCustomerServlet", urlPatterns = {"/SearchCustomerServlet"})
public class SearchCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String customer_name = request.getParameter("customer_name");
        
        if(customer_name != null){
            CustomerDAO customerDAO = new CustomerDAO();
            List<Customer> list = customerDAO.searchCustomer(customer_name);
            request.setAttribute("customerList", list);
            request.getRequestDispatcher("salestaff/SearchCustomerView.jsp").forward(request, response);
        }
    }
}
