
package servlet;

import dao.ServiceDAO;
import dao.SparePartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Service;
import model.SparePart;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String serviceId = request.getParameter("serviceId");
        String sparePartId = request.getParameter("sparePartId");
        if(keyword != null){
            if (!keyword.trim().isEmpty()) {
            ServiceDAO dao = new ServiceDAO();
            SparePartDAO dao2 = new SparePartDAO();
            
            List<Service> results = dao.searchService(keyword);
            List<SparePart> res2 = dao2.searchSparePart(keyword);
            request.setAttribute("services", results);
            request.setAttribute("spareParts", res2);
            }

            // Forward về lại cùng trang tìm kiếm
            RequestDispatcher rd = request.getRequestDispatcher("SearchView.jsp");
            rd.forward(request, response);
        }
        if(serviceId != null){
            ServiceDAO dao = new ServiceDAO();
            Service service = dao.getServiceByID(Integer.parseInt(serviceId));
            request.setAttribute("service", service);
            request.getRequestDispatcher("DetailView.jsp").forward(request, response);
            
        }
        
        if(sparePartId != null){
            SparePartDAO dao = new SparePartDAO();
            SparePart sparepart = dao.getSparePartByID(Integer.parseInt(sparePartId));
            request.setAttribute("sparepart", sparepart);
            request.getRequestDispatcher("DetailView.jsp").forward(request, response);
        }
        
    }
    
}
