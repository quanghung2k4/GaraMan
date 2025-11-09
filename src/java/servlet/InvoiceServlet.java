package servlet;

import dao.InvoiceDAO;
import dao.InvoiceServiceDAO;
import dao.InvoiceSparePartDAO;
import dao.ServiceDAO;
import dao.SparePartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Employee;
import model.Invoice;
import model.InvoiceService;
import model.InvoiceSparePart;
import model.SaleStaff;
import model.Service;
import model.SparePart;

@WebServlet(name = "InvoiceServlet", urlPatterns = {"/InvoiceServlet"})
public class InvoiceServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String customer_id = request.getParameter("customer_id");
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        Invoice invoice = invoiceDAO.getInvoiceByCustomer(Integer.parseInt(customer_id));
        
        request.setAttribute("invoice", invoice);
        if (invoice != null) {
            InvoiceSparePartDAO ispDAO = new InvoiceSparePartDAO();
            List<InvoiceSparePart> ispList = ispDAO.getInvoiceSparePart(invoice.getId());
            
            InvoiceServiceDAO isDAO = new InvoiceServiceDAO();
            List<InvoiceService> isList = isDAO.getInvoiceService(invoice.getId());
            
            request.setAttribute("listSparePart", ispList);
            request.setAttribute("listService", isList);
        }
        
        request.getRequestDispatcher("salestaff/CustomerInvoiceView.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        Invoice invoice = (Invoice) request.getSession().getAttribute("invoice");
        if (action.equals("confirmInvoice")) {
            List<InvoiceSparePart> ispList = (List<InvoiceSparePart>) request.getSession().getAttribute("listSparePartInvoice");
            
            boolean check = true;
            
            for (InvoiceSparePart isp : ispList) {
                System.out.println("confirm:"+isp.getId());
                int num_sp = isp.getSparePart().getQuanity();
                System.out.println("num_sp"+num_sp);
                int num_c = isp.getQuantity();
                if (num_sp - num_c < 0) {
                    check = false;
                    break;
                }
            }
            
            if (check) {
                SparePartDAO spD = new SparePartDAO();
                for (InvoiceSparePart isp : ispList) {
                    try {
                        SparePart sp = isp.getSparePart();
                        int num_sp = sp.getQuanity();
                        int num_c = isp.getQuantity();
                        sp.setQuanity(num_sp - num_c);
                        spD.updateSparePart(sp);
                    } catch (SQLException ex) {
                        Logger.getLogger(InvoiceServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                
                SaleStaff saleStaff = (SaleStaff) request.getSession().getAttribute("saleStaff");
                invoice.setStatus("Da thanh toan");
                invoice.getSalesStaff().setId(saleStaff.getId());
                (new InvoiceDAO()).updateInvoice(invoice);
            } else {
                
            }
            
            request.getRequestDispatcher("salestaff/PrintInvoiceView.jsp").forward(request, response);
        } else if (action.equals("addSparePart")) {
            int spId = Integer.parseInt(request.getParameter("sparePartId"));
            int qty = Integer.parseInt(request.getParameter("quantity"));
            List<InvoiceSparePart> ispList = (List<InvoiceSparePart>) request.getSession().getAttribute("listSparePartInvoice");
            
            InvoiceSparePartDAO ispDAO2 = new InvoiceSparePartDAO();
            
            boolean check = false;
            for (InvoiceSparePart isp : ispList) {
                if (isp.getSparePart().getId() == spId) {
                    isp.setQuantity(qty);
                    isp.setSubTotal(qty * isp.getSparePart().getUnitPrice());
                    boolean update = ispDAO2.updateInvoiceSparePart(isp);
                    check = true;
                    break;
                }
            }
            if (!check) {
                // Tạo đối tượng InvoiceSparePart để thêm
                SparePartDAO spDAO = new SparePartDAO();
                SparePart sp = spDAO.getSparePartByID(spId);
                
                InvoiceSparePart newIsp = new InvoiceSparePart();
                newIsp.setInvoice(invoice);
                newIsp.setSparePart(sp);
                newIsp.setQuantity(qty);
                newIsp.setSubTotal(sp.getUnitPrice() * qty);
                
                boolean added = ispDAO2.addInvoiceSparePart(newIsp);
            }

            // Sau khi thêm xong, redirect lại trang để cập nhật danh sách
            response.sendRedirect("InvoiceServlet?customer_id=" + invoice.getCustomer().getId());
        } else if (action.equals("addService")) {
            int sId = Integer.parseInt(request.getParameter("serviceId"));
            int time = Integer.parseInt(request.getParameter("time"));
            
            List<InvoiceService> isList = (List<InvoiceService>) request.getSession().getAttribute("listServiceInvoice");
            InvoiceServiceDAO isDAO = new InvoiceServiceDAO();
            
            boolean check = false;
            for (InvoiceService is : isList) {
                if (is.getService().getId() == sId) {
                    is.setNumOfTime(time);
                    is.setSubTotal(time * is.getService().getPrice());
                    boolean update = isDAO.updateInvoiceService(is);
                    check = true;
                    break;
                }
            }
            if (!check) {
                // Tạo đối tượng InvoiceSparePart để thêm
                ServiceDAO sDAO = new ServiceDAO();
                Service s = sDAO.getServiceByID(sId);
                
                InvoiceService newIs = new InvoiceService();
                newIs.setInvoice(invoice);
                newIs.setService(s);
                newIs.setNumOfTime(time);
                newIs.setSubTotal(time * s.getPrice());
                
                boolean add = isDAO.addInvoiceService(newIs);
            }

            // Sau khi thêm xong, redirect lại trang để cập nhật danh sách
            response.sendRedirect("InvoiceServlet?customer_id=" + invoice.getCustomer().getId());
        }
    }
    
}
