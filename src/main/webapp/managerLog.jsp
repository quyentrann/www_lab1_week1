<%@ page import="vn.edu.iuh.fit.models.Log" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manager Log</title>
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
            height: 100vh;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 70%;
            text-align: center;
            box-sizing: border-box;
            padding: 20px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .thead, .tr, .th, .tbody, .td {
            padding: 8px;
            text-align: left;
        }

        .btn-submit-log {
            background: none;
            border: none;
            color: #008CBA;
            cursor: pointer;
        }

        .btn-submit-log:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    List<Log> grantAccessList = (List<Log>) request.getAttribute("grantAccessList");
%>
<div class="container">
    <h2>Manager Log</h2>
    <table class="table">
        <thead class="thead">
        <tr class="tr">
            <th class="th">ID</th>
            <th class="th">Timestamp</th>
            <th class="th">Message</th>
            <!-- Add more columns if needed -->
        </tr>
        </thead>
        <tbody class="tbody">
        <% Log[] logs = new Log[0];
            for(Log log : logs){ %>
        <tr class="tr">
            <td class="td"><%= log.getId()%></td>
            <td class="td"><%= log.getLogIn()%></td>
            <td class="td"><%= log.getNote()%></td>
            <td class="td"><%= log.getLogOut()%></td>
            <td class="td"><%= log.getAccount()%></td>
            <!-- Add more cells for additional columns -->
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
