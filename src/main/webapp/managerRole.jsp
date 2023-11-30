<%@ page import="vn.edu.iuh.fit.models.Account" %>
<%@ page import="vn.edu.iuh.fit.models.Role" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Role</title>
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

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .form-crud {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .form-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .form-content {
            margin-bottom: 15px;
        }

        .label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            text-align: left;
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
            border-collapse: collapse;
        }

        .thead, .tr, .th, .tbody, .td {
            padding: 8px;
            text-align: left;
        }

        .btn-submit-grant {
            background: none;
            border: none;
            color: #008CBA;
            cursor: pointer;
        }

        .btn-submit-grant:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    String btnSubmit = request.getAttribute("btnSubmit").toString();
    Role roleChosen = (Role) request.getAttribute("role");
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<div class="container">
    <h2>QUẢN LÝ ROLE</h2>
    <form class="form-crud" action="role" method="post">
        <div class="form-info">
            <div class="form-content">
                <label for="roleName" class="label">Role Name</label>
                <input type="text" name="roleName" id="roleName" class="input" value="<%= roleChosen.getName()%>"/>
            </div>
            <div class="form-content">
                <label for="description" class="label">Description</label>
                <input type="text" name="description" id="description" class="input" value="<%= roleChosen.getDescription()%>"/>
            </div>
            <div class="form-content">
                <label for="status" class="label">IsGrant</label>
                <select name="selectStatus" id="status" class="input" value="<%= roleChosen.getStatus()%>">
                    <option value="1">ACTIVE</option>
                    <option value="0">DEACTIVE</option>
                    <option value="-1">DELETE</option>
                </select>
            </div>
        </div>
        <% if(btnSubmit.equalsIgnoreCase("Thêm")) {%>
        <input type="submit" name="btnSubmitFeature" value="<%= btnSubmit%>" class="btnSubmit"/>
        <% } else { %>
        <input type="submit" name="btnSubmitFeature" value="<%= btnSubmit%>" class="btnSubmit"/>
        <% } %>
    </form>
    <h2>DANH SÁCH CÁC ROLE</h2>
    <table class="table">
        <thead class="thead">
        <tr class="tr">
            <th class="th">ID</th>
            <th class="th">ROLE NAME</th>
            <th class="th">DESCRIPTION</th>
            <th class="th">STATUS</th>
        </tr>
        </thead>
        <tbody class="tbody">
        <% for(Role rl : roles){ %>
        <form action="role" method="post">
            <input type="hidden" name="roleID" value="<%= rl.getId()%>"/>
            <tr class="tr">
                <td class="td">
                    <%= rl.getId()%>
                    <input type="submit" name="btnSubmitFeature" value="selectRow" class="btn-submit-grant"/>
                </td>
                <td class="td"><%= rl.getName()%></td>
                <td class="td"><%= rl.getDescription()%></td>
                <td class="td"><%= rl.getStatus()%></td>
            </tr>
        </form>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
