<%@ page import="vn.edu.iuh.fit.models.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.models.Role" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông Tin Nhân Viên</title>
    <link rel="stylesheet" href="account.css"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            width: 600px;
            text-align: center;
            box-sizing: border-box;
        }

        .header {
            color: #333;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .thongtin-section {
            margin-bottom: 20px;
        }

        .thongtin-title {
            color: #008CBA;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .thongtin-item {
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            font-size: 16px;
            font-weight: bold;
        }

        .form-logout {
            margin-top: 20px;
        }

        .submit {
            background-color: #008CBA;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>
<body class="body">
<%
    Account account = (Account) request.getAttribute("account");
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<div class="container">
    <div class="header">
        <h2>THÔNG TIN NHÂN VIÊN</h2>
    </div>

    <div class="thongtin-section">
        <div class="thongtin-title">Thông Tin Cơ Bản</div>
        <div class="thongtin-item">
            <div>ID:</div>
            <div><%= account.getId() %></div>
        </div>
        <div class="thongtin-item">
            <div>FullName:</div>
            <div><%= account.getFullName() %></div>
        </div>
        <div class="thongtin-item">
            <div>Phone:</div>
            <div><%= account.getPhone() %></div>
        </div>
        <div class="thongtin-item">
            <div>Email:</div>
            <div><%= account.getEmail() %></div>
        </div>
        <div class="thongtin-item">
            <div>Password:</div>
            <div><%= account.getPassword() %></div>
        </div>
        <div class="thongtin-item">
            <div>Status:</div>
            <div><%= account.getStatus() %></div>
        </div>
    </div>

    <div class="thongtin-section">
        <div class="thongtin-title">Chi Tiết Nhân Viên</div>
        <% for(Role r1 : roles){ %>
        <div class="thongtin-item">
            <div>ID:</div>
            <div><%= r1.getId() %></div>
        </div>
        <div class="thongtin-item">
            <div>Name:</div>
            <div><%= r1.getName() %></div>
        </div>
        <div class="thongtin-item">
            <div>Decription:</div>
            <div><%= r1.getDescription() %></div>
        </div>
        <div class="thongtin-item">
            <div>Status:</div>
            <div><%= r1.getStatus() %></div>
        </div>
        <% } %>
    </div>

    <div class="form-logout">
        <form action="dashboard" method="post">
            <input type="hidden" name="accountID" value="<%= account.getId()%>"/>
            <input type="submit" name="btnSubmit" value="Đăng Xuất" class="submit"/>
        </form>
    </div>
</div>
</body>
</html>
