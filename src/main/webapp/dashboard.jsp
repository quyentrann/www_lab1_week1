<%@ page import="vn.edu.iuh.fit.models.Account" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="dashboard.css"/>
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
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
            box-sizing: border-box;
            padding: 20px;
        }

        h3 {
            color: #333;
            margin-bottom: 20px;
        }

        .form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }

        .btn-submit {
            background-color: #008CBA;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 10px;
            width: 100%;
            font-size: 16px;
            text-align: center;
        }

        .form-logout {
            margin-top: 20px;
            margin-left: 500px;
        }
    </style>
</head>
<body>
<%
    Account account = (Account) request.getAttribute("account");
%>
<div class="container">
    <h3>Quản Lý Nhân Viên</h3>
    <form class="form" action="dashboard" method="post">
        <input type="submit" name="btnSubmit" value="ACCOUNT" class="btn-submit"/>
        <input type="submit" name="btnSubmit" value="ROLE" class="btn-submit"/>
        <input type="submit" name="btnSubmit" value="GRANT-ACCESS" class="btn-submit"/>
        <input type="submit" name="btnSubmit" value="LOG" class="btn-submit"/>
        <form action="dashboard" method="post" class="form-logout">
            <input type="hidden" name="accountID" value="<%= account.getId()%>"/>
            <input type="submit" name="btnSubmit" value="Thoát" class="btn-submit"/>
        </form>
    </form>

</div>
</body>
</html>
