
<%@ page import="java.util.*, model.Customer, model.Employee, dao.CustomerDAO,model.SaleStaff" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán - Tìm kiếm khách hàng</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                margin: 0;
                padding: 40px;
                background: #f4f6f9;
                color: #333;
            }

            h1 {
                text-align: center;
                margin-bottom: 30px;
                color: #2c3e50;
            }

            form {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-bottom: 40px;
            }

            input[type="text"] {
                width: 300px;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                transition: 0.3s;
            }

            input[type="text"]:focus {
                border-color: #3498db;
                outline: none;
                box-shadow: 0 0 5px rgba(52, 152, 219, 0.4);
            }

            button {
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                background-color: #3498db;
                color: white;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            button:hover {
                background-color: #2980b9;
            }

            table {
                border-collapse: collapse;
                width: 100%;
                background: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            }

            th, td {
                padding: 12px 14px;
                text-align: center;
                border-bottom: 1px solid #eee;
            }

            th {
                background-color: #3498db;
                color: white;
                font-weight: 600;
            }

            tr:hover {
                background-color: #f2f9ff;
            }

            a {
                color: #3498db;
                text-decoration: none;
                font-weight: 500;
            }

            a:hover {
                text-decoration: underline;
            }

            h2 {
                text-align: start;
                margin-top: 40px;
                color: #2c3e50;
            }

            p {
                text-align: center;
                color: #888;
                margin-top: 10px;
            }

            .back-btn {
                display: inline-block;
                margin-bottom: 25px;
                background: #95a5a6;
                color: white;
                padding: 8px 16px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                transition: background-color 0.2s;
            }

            .back-btn:hover {
                background-color: #7f8c8d;
            }

            .bottom-bar{
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <%
            SaleStaff saleStaff = (SaleStaff) session.getAttribute("saleStaff");
            List<Customer> outsubListCustomer = (List<Customer>) request.getAttribute("customerList");
        %>

        <h3>Tìm kiếm khách hàng</h1>

        <form action="${pageContext.request.contextPath}/SearchCustomerServlet" method="post">
            <input type="text" name="customer_name" placeholder="Nhập tên khách hàng..."
                   value="<%= request.getParameter("customer_name") == null ? "" : request.getParameter("customer_name")%>" />
            <button type="submit">Tìm kiếm</button>
        </form>

        <% if (outsubListCustomer != null) { %>

        <% if (outsubListCustomer.isEmpty()) { %>
        <p>Không tìm thấy khách hàng.</p>   
        <% } else { %>
        <table>
            <tr>
                <th>Mã khách hàng</th>
                <th>Tên khách hàng</th>
                <th>Số điện thoại</th>
                <th>Địa chỉ</th>
            </tr>
            <% for (Customer s : outsubListCustomer) {%>
            <tr>
                <td><%= s.getId()%></td>
                <td>
                    <a href="${pageContext.request.contextPath}/InvoiceServlet?customer_id=<%= s.getId()%>">
                        <%= s.getName()%>
                    </a>
                </td>
                <td><%= s.getPhone()%></td>
                <td><%= s.getAddress()%></td>
            </tr>
            <% } %>
        </table>
        <% } %>

        <% }%> 
        <div class="bottom-bar">
            <a href="${pageContext.request.contextPath}/salestaff/MainSaleStaffView.jsp" class="back-btn">← Quay lại</a>
        </div>    
    </body>
</html>
