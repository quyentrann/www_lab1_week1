<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login and Register</title>
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
            width: 400px;
            text-align: center;
        }

        .header {
            color: #333;
            margin-bottom: 30px;
        }

        .form-content {
            margin-bottom: 20px;
        }

        .label {
            display: block;
            margin-bottom: 10px;
            color: #333;
        }

        .input {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .submit {
            background-color: #4caf50;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        .register-link {
            display: block;
            margin-top: 10px;
            color: #008CBA;
            text-decoration: none;
        }

        .register-link:hover {
            text-decoration: underline;
        }
        .ac{
            flex-direction: row;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="header">ĐĂNG NHẬP</h1>
    <form action="login" method="post" class="form">
        <div class="form-content">
            <label class="label" for="email">Email</label>
            <input type="email" name="email" id="email" class="input" required/>
        </div>
        <div class="form-content">
            <label class="label" for="password">Password</label>
            <input type="password" name="password" id="password" class="input" required/>
        </div>
        <div class="ac">
            <input type="submit" name="btnLogin" value="Đăng nhập" class="submit"/>
            <a href="register.jsp" class="register-link">Đăng ký</a>
        </div>
    </form>
</div>
</body>
</html>
