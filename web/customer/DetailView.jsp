<%@page import="model.Service,model.SparePart"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết dịch vụ</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background-color: #f5f7fa;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 700px;
                margin: 50px auto;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                padding: 30px 40px;
            }
            h1 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            tr {
                border-bottom: 1px solid #eee;
            }
            th {
                text-align: left;
                width: 35%;
                color: #555;
                padding: 10px 0;
            }
            td {
                color: #333;
                padding: 10px 0;
            }
            .back-btn {
                display: inline-block;
                margin-top: 25px;
                background-color: #3498db;
                color: #fff;
                text-decoration: none;
                display: flex;
                justify-self: center;
                padding: 10px 18px;
                border-radius: 6px;
                transition: background-color 0.2s ease-in-out;
            }
            .back-btn:hover {
                background-color: #217dbb;
            }
            .title{
                text-align: left;
                color: #000000;
                margin:15px;
                font-size: 16px;
                font-weight: 500;
            }
        </style>
    </head>

    <%
        Service service = (Service) request.getAttribute("service");
        SparePart sparePart = (SparePart) request.getAttribute("sparepart");
    %>
    <body>
        <div class="header">
            <p class="title">Gara ô tô ABC / Tìm kiếm thông tin dịch vụ / Chi tiết</p>
        </div>
        <% if(service != null) {%>
        <div class="container">
            <h1>Chi tiết dịch vụ</h1>
            <table>
                <tr><th>Mã dịch vụ</th><td><%= service.getId()%></td></tr>
                <tr><th>Tên dịch vụ</th><td><%= service.getName()%></td></tr>

                <tr><th>Giá</th><td><%= String.format("%,.0f VNĐ", service.getPrice())%></td></tr>
                <tr><th>Thời gian thực hiện</th><td><%= service.getDuration() + " giờ"%></td></tr>
                <tr><th>Số nhân viên thực hiện</th><td><%= service.getNumOfStaff()%></td></tr>
                <tr><th>Mô tả</th><td><%= service.getDescription()%></td></tr>
            </table>

            <a href="javascript:history.back()" class="back-btn">← Quay lại</a>


        </div>
        <%}%>
        
        <% if(sparePart != null) {%>
        <div class="container">
            <h1>Chi tiết phụ tùng</h1>


            <table>
                <tr><td>Mã phụ tùng</td><td><%= sparePart.getId()%></td></tr>
                <tr><td>Tên phụ tùng</td><td><%= sparePart.getName()%></td></tr>
                <tr><td>Số lượng tồn kho</td><td><%= sparePart.getQuanity()%></td></tr>
                <tr><td>Số lượng đã bán</td><td><%= sparePart.getSoldNum()%></td></tr>
                <tr><td>Đơn giá</td><td><%= String.format("%,.0f VNĐ", sparePart.getUnitPrice())%></td></tr>
                <tr><td>Mô tả</td><td><%= sparePart.getDescription()%></td></tr>
            </table>


            <a href="javascript:history.back()" class="back-btn">← Quay lại</a>
        </div>
            
        <%}%>
    </body>
</html>
