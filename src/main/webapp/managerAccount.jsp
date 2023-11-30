<%@ page import="vn.edu.iuh.fit.models.Account" %>
<%@ page import="vn.edu.iuh.fit.models.Role" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manager Account</title>
    <link rel="stylesheet" href="manager.css"/>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            height: 100%;
            width: 100%;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            height: 100%;
            text-align: center;
            box-sizing: border-box;
            padding: 20px;
        }

        h2, h3 {
            color: #333;
            margin-bottom: 20px;
        }

        .form-crud {
            width: 70%;
            height: 38%;
            display: flex;
            flex-direction: column;
            justify-content: normal;
        }

        .form-info {
            display: flex;
            justify-content: space-between;
        }

        .form-content {
            margin-bottom: 15px;
        }

        .label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .input, .select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btnSubmit {
            background-color: #008CBA;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 110px;
            height: 30px;
            font-size: 16px;
        }

        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        .thead, .tr, .th, .tbody, .td {

            padding: 8px;
            text-align: left;
        }

        .btnAccountID {
            background: none;
            border: none;
            color: #008CBA;
            cursor: pointer;
        }

        .btnAccountID:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    String btnSubmit = request.getAttribute("btnSubmit").toString();
    Account accountChosen = (Account) request.getAttribute("account");
    List<Account> accounts = (List<Account>) request.getAttribute("accounts");
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<div class="container">
    <h2>Quản Lý Nhân Viên</h2>
    <form class="form-crud" action="account" method="post">
        <div class="form-info">
            <div class="form-content">
                <input type="hidden" name="accountID" value="<%= accountChosen.getId()%>" class="input"/>
                <label for="fullName" class="label">FullName</label>
                <input type="text" name="fullName" id="fullName" value="<%= accountChosen.getFullName()%>" class="input"/>
            </div>
            <div class="form-content">
                <label for="email" class="label">Email</label>
                <input type="email" name="email" id="email" value="<%= accountChosen.getEmail()%>" class="input"/>
            </div>
            <div class="form-content">
                <label for="password" class="label">Password</label>
                <input type="password" name="password" id="password" value="<%= accountChosen.getPassword()%>" class="input"/>
            </div>
            <div class="form-content">
                <label for="phone" class="label">Phone</label>
                <input type="tel" name="phone" id="phone" value="<%= accountChosen.getPhone()%>" class="input"/>
            </div>
            <div class="form-content">
                <label for="status" class="label">Status</label>
                <select name="status" id="status" class="select">
                    <option value="1" <%= accountChosen.getStatus()==1 ? "selected" : "" %>>ACTIVE</option>
                    <option value="0" <%= accountChosen.getStatus()==0 ? "selected" : "" %>>DEACTIVE</option>
                </select>
            </div>
        </div>
        <% if(btnSubmit.equalsIgnoreCase("Thêm")) {%>
        <input type="submit" name="btnSubmitFeature" value="<%= btnSubmit%>" class="btnSubmit"/>
        <% } else { %>
        <input type="submit" name="btnSubmitFeature" value="<%= btnSubmit%>" class="btnSubmit"/>
        <% } %>
    </form>
    <h2>DANH SÁCH TÀI KHOẢN</h2>
    <table class="table">
        <thead class="thead">
        <tr class="tr">
            <th class="th">ID</th>
            <th class="th">FULLNAME</th>
            <th class="th">PHONE</th>
            <th class="th">EMAIL</th>
            <th class="th">PASSWORD</th>
            <th class="th">STATUS</th>
        </tr>
        </thead>
        <tbody class="tbody">
        <% for(Account account : accounts){ %>
        <tr class="tr">
            <td class="td">
                <form action="account" method="post" class="form-id">
                    <input type="submit" name="btnSubmitFeature" value="<%= account.getId()%>" class="btnAccountID"/>
                </form>
            </td>
            <td class="td"><%= account.getFullName()%></td>
            <td class="td"><%= account.getPhone()%></td>
            <td class="td"><%= account.getEmail()%></td>
            <td class="td"><%= account.getPassword()%></td>
            <td class="td"><%= account.getStatus()%></td>
        </tr>
        <% } %>
        </tbody>
    </table>

</div>
</body>
</html>
