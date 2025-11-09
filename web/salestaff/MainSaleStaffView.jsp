<%@page import="model.SaleStaff"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang chủ nhân viên bán hàng</title>

    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Tiêu đề ở góc trái trên */
        h3 {
            position: absolute;
            top: 20px;
            left: 25px;
            color: #333;
            font-size: 1.1rem;
            font-weight: 600;
            margin: 0;
        }

        .card {
            background: #fff;
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .greeting {
            font-size: 1.3rem;
            color: #555;
            margin-bottom: 25px;
        }

        .button {
            display: inline-block;
            background-color: #1abc9c;
            color: white;
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 6px;
            transition: background-color 0.2s;
        }

        .button:hover {
            background-color: #16a085;
        }
    </style>
</head>

<%
    SaleStaff saleStaff = (SaleStaff) session.getAttribute("saleStaff");
%>

<body>
    <h3>Gara Ô Tô ABC / Trang chủ nhân viên bán hàng</h3>

    <div class="card">
        <div class="greeting">
            Xin chào, <%= (saleStaff != null ? saleStaff.getName() : "Nhân viên") %>
        </div>
        <a href="/PTTK/salestaff/SearchCustomerView.jsp" class="button">Thanh toán</a>
    </div>
</body>
</html>
