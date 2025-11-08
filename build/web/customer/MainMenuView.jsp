<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ gara ô tô ABC</title>
        <style>
            body {
                margin: 0;
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f7f9fb;
            }

            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #0d6efd;
                color: white;
                padding: 0 40px;
                height: 60px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            header h2 {
                margin: 0;
                font-size: 22px;
                font-weight: 600;
            }

            nav {
                display: flex;
                gap: 20px;
            }

            nav a {
                text-decoration: none;
                color: white;
                font-weight: 500;
                padding: 8px 16px;
                border-radius: 6px;
                transition: background-color 0.3s, transform 0.2s;
            }

            nav a:hover {
                background-color: rgba(255, 255, 255, 0.2);
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <header>
            <h2>Gara Ô Tô ABC</h2>
            <nav>
                <a href="./customer/SearchView.jsp" target="_self">Tìm kiếm dịch vụ / phụ tùng</a>
                <a href="<%= request.getContextPath()%>/employee/Login.jsp" target="_self">Đăng nhập</a>
            </nav>
        </header>
    </body>
</html>
