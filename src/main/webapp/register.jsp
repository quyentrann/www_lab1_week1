<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="login.css"/>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 1000px;
            text-align: center;
            box-sizing: border-box;
        }

        .header {
            color: #333;
            margin-bottom: 30px;
        }

        .form-content {
            margin-bottom: 20px;
            text-align: left;
        }

        .label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .input {
            width: calc(100% - 24px); /* Đã điều chỉnh chiều rộng */
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .submit {
            background-color: #008CBA;
            color: #fff;
            padding: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: calc(100% - 24px); /* Đã điều chỉnh chiều rộng */
        }

        .error-message {
            color: #FF0000;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="header">ĐĂNG KÝ</h1>
    <form action="register" method="post" class="form">
        <div class="form-content">
            <label class="label" for="fullName">Họ và tên</label>
            <input type="text" name="fullName" id="fullName" class="input" required/>
        </div>
        <div class="form-content">
            <label class="label" for="email">Email</label>
            <input type="email" name="email" id="email" class="input" required/>
        </div>
        <div class="form-content">
            <label class="label" for="password">Mật khẩu</label>
            <input type="password" name="password" id="password" class="input" required/>
        </div>
        <div class="form-content">
            <label class="label" for="phone">Số điện thoại</label>
            <input type="tel" name="phone" id="phone" class="input" required/>
        </div>
        <div class="ac">
            <input type="submit" name="btnRegister" value="Đăng ký" class="submit"/>
        </div>
        <% if (request.getParameter("duplicate") != null && request.getParameter("duplicate").equals("true")) { %>
        <div class="error-message">Email hoặc số điện thoại đã được đăng ký.</div>
        <% } %>
    </form>
</div>
</body>
</html>
