<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập - Gara Ô Tô ABC</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            .header {
                padding: 12px 20px;
                font-weight: bold;
            }

            .login-container {
                width: 300px;
                margin: 80px auto;
                background-color: #fff;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 6px;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
                font-size: 20px;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            button {
                width: 100%;
                padding: 8px;
                background-color: #0000FF;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .back{
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            Gara Ô Tô ABC / Đăng nhập
        </div>

        <div class="login-container">
            <h2>Đăng nhập</h2>
            <form action="<%= request.getContextPath()%>/LoginServlet" method="post">
                <label for="username">*Tài khoản</label>
                <input type="text" id="username" name="username" placeholder="Nhập tài khoản" required>

                <label for="password">*Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
                <c:if test="${not empty errorMessage}">
                    <div class="error">${errorMessage}</div>
                </c:if>    
                <button type="submit">Đăng nhập</button>
            </form>
        </div>
        <div class="back">
            <a href="/PTTK" class="back-btn">← Quay lại</a>
        </div>
    </body>
</html>
