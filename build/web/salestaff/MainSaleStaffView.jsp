<%@page import="model.SaleStaff"%>
<%@page import="model.Employee, dao.EmployeeDAO"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
     <style>
        body {
            background-color: #f5f6fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            background-color: #ffffff;
            padding: 50px 60px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .card h1 {
            color: #333333;
            margin-bottom: 20px;
        }

        .greeting {
            font-size: 1.5rem;
            color: #555555;
            margin-bottom: 35px;
        }

        .button {
            display: inline-block;
            background-color: #1abc9c;
            color: #ffffff;
            text-decoration: none;
            padding: 14px 30px;
            border-radius: 8px;
            font-size: 1.1rem;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #16a085;
        }
    </style>

    <%
        Employee e  = (Employee)(new EmployeeDAO()).getEmployee();
        session.setAttribute("saleStaff", e);
    %>
    <body>
        <div class="card">
        <h1>Trang chủ nhân viên bán hàng</h1>
        <div class="greeting">
            Xin chào, <%= (e != null ? e.getName() : "Nhân viên") %>
        </div>
        <a href="/PTTK/salestaff/SearchCustomerView.jsp" class="button">Thanh toán</a>
    </div>
    </body>
</html>
