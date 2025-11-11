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
                padding: 5px;
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
            h3{
                padding:2px;
                margin:3px;
            }

            table {
                width: 100%;
                table-layout: fixed; /* cố định độ rộng cột */
                border-collapse: collapse;
                margin-top: 8px;
                background: #fff;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
                font-size: 13px; /* chữ nhỏ hơn để hiển thị nhiều hơn */
            }

            th, td {
                border: 1px solid #ddd;
                padding: 6px; /* giảm padding */
                text-align: left;
                word-wrap: break-word; /* xuống dòng nếu dài */
            }

            th {
                background: #3498db;
                color: white;
                text-align: center;
            }

            tr:nth-child(even) {
                background: #f9f9f9;
            }

            /* Đặt độ rộng cho từng cột */
            th:nth-child(1), td:nth-child(1) {
                width: 8%;
                text-align: center;
            }   /* Mã */
            th:nth-child(2), td:nth-child(2) {
                width: 40%;
            }                      /* Tên */
            th:nth-child(3), td:nth-child(3) {
                width: 5%;
                text-align: center;
            }  /* Số lượng / Số lần / SĐT */
            th:nth-child(4), td:nth-child(4) {
                width: 19%;

            }  /* Đơn giá */
            th:nth-child(5), td:nth-child(5) {
                width: 19%;

            }                      /* Thành tiền / Địa chỉ */

            .delete-button{
                border-radius: 50%;
                border:none;
                background:#fff;
                cursor: pointer;
            }

            input[type="submit"].button{
                background: #2ecc71;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                cursor: pointer;
                margin-right: 10px;
                transition: background 0.2s ease;
            }

            input[type="submit"].button:hover {
                background: #27ae60;
            }
            input[type="number"]{
                width:25px;
            }
            a.button {
                background: #e74c3c;
                color: white;
                font-size: 14px;
                text-decoration: none;
                padding: 5px 15px;
                border-radius: 6px;
                transition: background 0.2s ease;
            }

            a.button:hover {
                background: #c0392b;
            }

            .info-box {
                box-sizing: border-box;
                background: #fff;
                padding: 15px;
                width: 100%;
                border-radius: 8px;
                font-size: 13px;
            }

            .footer-buttons {
                display: flex;
                justify-content: center;
                text-align: center;
                margin-top: 10px;
            }
            .info-box .row {
                display: flex;
                gap: 10px;
                font-size:15px;
            }
            .row p{
                margin:1px;
                padding:1px;
            }
            .button-add{
                border-radius: 5px;
                border:none;
                color:white;
                padding:4px;
                background: #27ae60;
            }
            .select{
                border-radius: 5px;
                border:none;
                color:white;
                padding:4px;
                background: #27ae60;
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


        <h3>Gara Ô Tô ABC / Nhân viên bán hàng / Thanh toán / Hóa đơn khách hàng</h3>

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
        <h3>Danh sách phụ tùng</h3>
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
                <td style="text-align: right"><%= String.format("%,.0f", isp.getSparePart().getUnitPrice())%></td>
                <td style="text-align: right"><%= String.format("%,.0f", isp.getSubTotal())%></td>

            </tr>
            <% }
                }%>
            <form action="<%= request.getContextPath()%>/InvoiceServlet" method="post">
                <input type="hidden" name="action" value="addSparePart">
                <tr>
                    <td></td>
                    <td colspan="1">
                        <select class="select" name="sparePartId">
                            <option value="">Chọn phụ tùng</option>
                            <% for (SparePart sp : listSparePart) {%>
                            <option value="<%= sp.getId()%>"><%= sp.getName()%></option>
                            <% } %>
                        </select>
                    </td>
                    <td><input type="number" name="quantity" value="1" min="1" style></td>
                    <td colspan="1"></td>
                    <td colspan="1"></td>
                    <td><input class="button-add" type="submit" value="Thêm"></td>
                </tr>
            </form>
        </table>

        <!-- DANH SÁCH DỊCH VỤ -->
        <h3>Danh sách dịch vụ</h3>
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
                <td style="text-align: right"><%= String.format("%,.0f", is.getService().getPrice())%></td>
                <td style="text-align: right"><%= String.format("%,.0f", is.getSubTotal())%></td>
            </tr>
            <% }
                }%>
            <tr>
            <form action="<%= request.getContextPath()%>/InvoiceServlet" method="post">
                <input type="hidden" name="action" value="addService">
                <tr>
                    <td></td>
                    <td colspan="1">
                        <select class="select" name="serviceId">
                            <option value="">Chọn dịch vụ</option>
                            <% for (Service s : listService) {%>
                            <option value="<%= s.getId()%>"><%= s.getName()%></option>
                            <% }%>
                        </select>
                    </td>
                    <td><input type="number" name="time" value="1" min="1"></td>
                    <td colspan="1"></td>
                    <td colspan="1"></td>
                    <td><input class="button-add"type="submit" value="Thêm"></td>
                </tr>
            </form>
        </table>


        <div style="text-align:right; margin-right: 60px">
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
