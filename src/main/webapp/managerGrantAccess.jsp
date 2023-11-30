<%@ page import="vn.edu.iuh.fit.models.GrantAccess" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Grant Access</title>
    <link rel="stylesheet" href="manager.css"/>
    <style>
        /* Thêm CSS nếu cần thiết */
    </style>
</head>
<body>
<%
    String btnSubmit = request.getAttribute("btnSubmit").toString();
    GrantAccess grantAccessChosen = (GrantAccess) request.getAttribute("grantAccess");
    List<GrantAccess> grantAccessList = (List<GrantAccess>) request.getAttribute("grantAccessList");
%>
<div class="container">
    <h2>Quản Lý Grant Access</h2>
    <form class="form-crud" action="grantAccess" method="post">
        <div class="form-info">
            <div class="form-content">
                <input type="hidden" name="grantAccessID" value="<%= grantAccessChosen.getIsGrant()%>" class="input"/>
                <!-- Thêm các trường dữ liệu của Grant Access -->
            </div>
        </div>
        <% if(btnSubmit.equalsIgnoreCase("Thêm")) {%>
        <input type="submit" name="btnSubmitFeature" value="<%= btnSubmit%>" class="btnSubmit"/>
        <% } else { %>
        <input type="submit" name="btnSubmitFeature" value="<%= btnSubmit%>" class="btnSubmit"/>
        <% } %>
    </form>
    <h2>DANH SÁCH GRANT ACCESS</h2>
    <table class="table">
        <thead class="thead">
        <tr class="tr">
            <th class="th">ID</th>

        </tr>
        </thead>
        <tbody class="tbody">
        <% for(GrantAccess grantAccess : grantAccessList){ %>
        <tr class="tr">
            <td class="td">
                <form action="grantAccess" method="post" class="form-id">
                    <input type="submit" name="btnSubmitFeature" value="<%= grantAccess.getIsGrant()%>" class="btnGrantAccessID"/>
                </form>
            </td>
            <!-- Thêm các cột cho thông tin Grant Access -->
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
