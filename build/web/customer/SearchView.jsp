<%@ page import="java.util.*, model.Service,model.SparePart" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tìm kiếm dịch vụ</title>
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
                text-align: left;
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

            .back{
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 10px;
            }

            .title{
                text-align: left;
                color: #000000;
                margin-top:0px;
                font-size: 16px;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <p class="title">Gara ô tô ABC / Tìm kiếm thông tin dịch vụ,phu tùng</p>
        </div>


        <form action="${pageContext.request.contextPath}/SearchServlet" method="get">
            <input type="text" name="keyword" placeholder="Nhập tên dịch vụ hoặc phụ tùng..."
                   value="<%= request.getParameter("keyword") == null ? "" : request.getParameter("keyword")%>" />
            <button type="submit">Tìm kiếm</button>
        </form>

        <%
            List<Service> listService = (List<Service>) request.getAttribute("services");
            List<SparePart> listSparePart = (List<SparePart>) request.getAttribute("spareParts");

            if (listService != null || listService != null) {
        %>

        <h2>Dịch vụ</h2>
        <%
            if (listService == null || listService.isEmpty()) {
        %>
        <p>Không tìm thấy dịch vụ phù hợp.</p>
        <%
        } else {
        %>
        <table>
            <tr><th>ID</th><th>Tên</th><th>Mô tả</th><th>Giá (VNÐ)</th></tr>
                    <% for (Service s : listService) {%>
            <tr>
                <td><%= s.getId()%></td>
                <td>
                    <a href="${pageContext.request.contextPath}/SearchServlet?serviceId=<%= s.getId()%>">
                        <%%>
                        <%= s.getName()%>
                    </a>
                </td>
                <td><%= s.getDescription()%></td>
                <td><%= String.format("%,.0f", s.getPrice())%></td>
            </tr>
            <% } %>
        </table>
        <% } %>

        <h2>Phụ tùng</h2>
        <%
            if (listSparePart == null || listSparePart.isEmpty()) {
        %>
        <p>Không tìm thấy phụ tùng phù hợp.</p>
        <%
        } else {
        %>
        <table>
            <tr><th>ID</th><th>Tên</th><th>Mô tả</th><th>Giá (VNÐ)</th></tr>
                    <% for (SparePart p : listSparePart) {%>
            <tr>
                <td><%= p.getId()%></td>
                <td>
                    <a href="${pageContext.request.contextPath}/SearchServlet?sparePartId=<%= p.getId()%>">
                        <%= p.getName()%>
                    </a>
                </td>
                <td><%= p.getDescription()%></td>
                <td><%= String.format("%,.0f", p.getUnitPrice())%></td>
            </tr>
            <% } %>
        </table>
        <% } %>

        <%
            } // end if any results
        %>

        <div class="back">
            <a href="/PTTK" class="back-btn">← Quay lại</a>
        </div>

    </body>
</html>
