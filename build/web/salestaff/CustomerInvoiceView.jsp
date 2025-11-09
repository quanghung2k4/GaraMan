<%@page import="dao.SparePartDAO"%>
<%@page import="dao.ServiceDAO"%>
<%@page import="model.Service"%>
<%@page import="model.SparePart"%>
<%@page import="model.InvoiceService"%>
<%@ page import="java.util.*, model.Invoice,model.InvoiceSparePart, dao.InvoiceDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hóa đơn khách hàng</title>

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                margin: 0;
                padding: 10px;
                background: #f4f6f9;
                color: #333;
            }

            h1{
                text-align: center;
                color: #2c3e50;
            }
            h2 {
                text-align: left;
                color: #2c3e50;
            }


            table {
                width: 100%;
                table-layout: auto;
                border-collapse: collapse;
                margin-top: 15px;
                background: #fff;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
            }

            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
                width: auto;
            }

            th {
                background: #3498db;
                color: white;
            }

            tr:nth-child(even) {
                background: #f9f9f9;
            }
            .delete-button{
                border-radius: 50%;
                border:none;
                background:#fff;
                cursor: pointer;
            }

            /* Style chung cho nút input */
            input[type="submit"].button{
                background: #2ecc71;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                margin-right: 10px;
                transition: background 0.2s ease;
            }

            input[type="submit"].button:hover {
                background: #27ae60;
            }

            /* Style riêng cho thẻ <a> */
            a.button {
                background: #e74c3c;
                color: white;
                font-size: 16px;
                text-decoration: none;
                padding: 5px 20px;
                border-radius: 8px;
                transition: background 0.2s ease;
            }

            a.button:hover {
                background: #c0392b;
            }

            .info-box {
                box-sizing: border-box;
                background: #fff;
                padding: 20px;
                width: 100%;
                border-radius: 8px;
            }

            .footer-buttons {
                display: flex;
                justify-content: center;
                text-align: center;
                margin-top: 30px;
            }
            .info-box .row {
                display: flex;
                gap: 20px; /* khoảng cách giữa các mục */
            }
        </style>
    </head>

    <body>

        <%
            Invoice outInvoice = (Invoice) request.getAttribute("invoice"); %>

        <% if (outInvoice != null) {%>    
        <% List<InvoiceSparePart> outListSparePart = (List<InvoiceSparePart>) request.getAttribute("listSparePart");
            List<InvoiceService> outListService = (List<InvoiceService>) request.getAttribute("listService");

            session.setAttribute("invoice", outInvoice);
            session.setAttribute("customer", outInvoice.getCustomer());
            session.setAttribute("listSparePartInvoice", outListSparePart);
            session.setAttribute("listServiceInvoice", outListService);

            // Format ngày theo kiểu Việt Nam
            String formattedDate = "";
            if (outInvoice != null && outInvoice.getCreateAt() != null) {
                java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("'Ngày' d 'tháng' M 'năm' yyyy");
                formattedDate = fmt.format(outInvoice.getCreateAt());
            }
            float total = 0;

            List<Service> listService = (new ServiceDAO()).getAllService();
            List<SparePart> listSparePart = (new SparePartDAO()).getAllSparePart();
        %>


        <h3> Gara Ô Tô ABC / Nhân viên bán hàng / Thanh toán / Hóa đơn khách hàng</h3>

        <div class="info-box">
            <div class="row">
                <p><b>Mã hóa đơn:</b> <%= outInvoice.getId()%></p>
                <p><b>Ngày tạo:</b> <%= formattedDate%></p>
            </div>
            <div class="row">
                <p><b>Tên khách hàng:</b> <%= outInvoice.getCustomer().getName()%></p>
                <p><b>Số điện thoại:</b> <%= outInvoice.getCustomer().getPhone()%></p>
                <p><b>Địa chỉ:</b> <%= outInvoice.getCustomer().getAddress()%></p>
            </div>
            
        </div>


        <!-- DANH SÁCH PHỤ TÙNG -->
        <h2>Danh sách phụ tùng</h2>
        <table>
            <tr>
                <th>Mã phụ tùng</th>
                <th>Tên phụ tùng</th>
                <th>Số lượng</th>
                <th>Đơn giá</th>
                <th>Thành tiền</th>
            </tr>
            <%
                if (outListSparePart != null) {
                    for (InvoiceSparePart isp : outListSparePart) {
                        total += isp.getSubTotal();
            %>
            <tr>
                <td><%= isp.getSparePart().getId()%></td>
                <td><%= isp.getSparePart().getName()%></td>
                <td><%= isp.getQuantity()%></td>
                <td><%= String.format("%,.0f", isp.getSparePart().getUnitPrice())%></td>
                <td><%= String.format("%,.0f", isp.getSubTotal())%></td>

            </tr>
            <% }
                }%>
            <form action="<%= request.getContextPath()%>/InvoiceServlet" method="post">
                <input type="hidden" name="action" value="addSparePart">
                <tr>
                    <td></td>
                    <td colspan="1">
                        <select name="sparePartId">
                            <option value="">Chọn phụ tùng</option>
                            <% for (SparePart sp : listSparePart) {%>
                            <option value="<%= sp.getId()%>"><%= sp.getName()%></option>
                            <% } %>
                        </select>
                    </td>
                    <td><input type="number" name="quantity" value="1" min="1"></td>
                    <td colspan="1"></td>
                    <td colspan="1"></td>
                    <td><input type="submit" value="Thêm"></td>
                </tr>
            </form>
        </table>

        <!-- DANH SÁCH DỊCH VỤ -->
        <h2>Danh sách dịch vụ</h2>
        <table>
            <tr>
                <th>Mã dịch vụ</th>
                <th>Tên dịch vụ</th>
                <th>Số lần dùng</th>
                <th>Đơn giá</th>
                <th>Thành tiền</th>
            </tr>
            <%
                if (outListService != null) {
                    for (InvoiceService is : outListService) {
                        total += is.getSubTotal();
            %>
            <tr>
                <td><%= is.getService().getId()%></td>
                <td><%= is.getService().getName()%></td>
                <td><%= is.getNumOfTime()%></td>
                <td><%= String.format("%,.0f", is.getService().getPrice())%></td>
                <td><%= String.format("%,.0f", is.getSubTotal())%></td>
            </tr>
            <% }
                }%>
            <tr>
            <form action="<%= request.getContextPath()%>/InvoiceServlet" method="post">
                <input type="hidden" name="action" value="addService">
                <tr>
                    <td></td>
                    <td colspan="1">
                        <select name="serviceId">
                            <option value="">Chọn dich vu</option>
                            <% for (Service s : listService) {%>
                            <option value="<%= s.getId()%>"><%= s.getName()%></option>
                            <% }%>
                        </select>
                    </td>
                    <td><input type="number" name="time" value="1" min="1"></td>
                    <td colspan="1"></td>
                    <td colspan="1"></td>
                    <td><input type="submit" value="Thêm"></td>
                </tr>
            </form>
        </table>


        <div style="text-align:right">
            <h3 >Tổng tiền: <%= String.format("%,.0f VNĐ", total)%></h3>
        </div>    
        <div class="footer-buttons">
            <form action="<%= request.getContextPath()%>/InvoiceServlet" method="post">
                <input type="hidden" name="action" value="confirmInvoice">
                <input type="submit" value="Xác nhận hóa đơn" class="button">
            </form>
            <a class="button" style="background:#e74c3c;" href="salestaff/SearchCustomerView.jsp">Trở lại</a>
        </div>
        <%
            outInvoice.setTotalAmount(total);
        %>
        <% } else { %>
        <h2 style="text-align:center; color:red;">Khách hàng đã thanh toán</h2>
        <div class="footer-buttons">
            <a class="button" href="salestaff/SearchCustomerView.jsp">Trở lại</a>
        </div>
        <% }%>

    </body>
</html>
