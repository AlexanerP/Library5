<%--
  Created by IntelliJ IDEA.
  User: Александр
  Date: 28.12.2021
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="/WEB-INF/pages/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="/WEB-INF/pages/common/header.jsp"></jsp:include>
<div align="center"><h1><fmt:message key="title_work_with_admin"></fmt:message></h1></div>
<form action="Controller" method="get">
    <input type="hidden" name="command" value="ManagerCatalog">
    <table>
        <tr>
            <td><fmt:message key="enter_admin_id"></fmt:message></td>
            <td><input type="number" name="userIdFind" min="1" placeholder="<fmt:message key="enter_admin_id"></fmt:message>"></td>
            <td><input type="submit" value="<fmt:message key="button_find"></fmt:message>"></td>
        </tr>
    </table>
</form>
<form action="Controller" method="get">
    <input type="hidden" name="command" value="ManagerCatalog">
    <table>
        <tr>
            <td><fmt:message key="enter_admin_email"></fmt:message></td>
            <td><input type="text" name="email" placeholder="<fmt:message key="enter_admin_email"></fmt:message>"></td>
            <td><input type="submit" value="<fmt:message key="button_find"></fmt:message>"></td>
        </tr>
    </table>
</form>
<form action="Controller" method="get">
    <input type="hidden" name="command" value="ManagerCatalog">
    <table>
        <tr>
            <td><fmt:message key="show_all_admin"></fmt:message></td>
            <td><input type="submit" value="<fmt:message key="button_find"></fmt:message>" name="allAdmins"></td>
        </tr>
    </table>
</form>

<c:if test="${not empty users}">
<div align="center">
<table border="1" cellpadding="5">
    <tr>
        <th>#</th>
        <th><fmt:message key="enter_user_id"></fmt:message></th>
        <th><fmt:message key="user_second_name"></fmt:message></th>
        <th><fmt:message key="user_last_name"></fmt:message></th>
        <th><fmt:message key="user_email"></fmt:message></th>
        <th><fmt:message key="user_date_registration"></fmt:message></th>
        <th><fmt:message key="user_number_of_violations"></fmt:message></th>
        <th><fmt:message key="user_role"></fmt:message></th>
        <th><fmt:message key="status"></fmt:message></th>
        <th><fmt:message key="change_status"></fmt:message></th>
    </tr>
    <c:forEach var="users" items="${users}" varStatus="status">
    <tr>
        <td><c:out value="${status.index + 1}"></c:out></td>
        <td><c:out value="${users.userId}"></c:out></td>
        <td><c:out value="${users.secondName}"></c:out></td>
        <td><c:out value="${users.lastName}"></c:out></td>
        <td><c:out value="${users.email}"></c:out></td>
        <td><c:out value="${users.dateRegistration}"></c:out></td>
        <td><c:out value="${users.countViolations}"></c:out></td>
        <td><c:out value="${users.role}"></c:out></td>
        <td><c:out value="${users.status}"></c:out></td>
        <td>
            <a href="?command=ActionAdminCommand&userId=${users.userId}&role=user">User</a>
            <a href="?command=ActionAdminCommand&userId=${users.userId}&role=admin">Admin</a>
            <a href="?command=ActionAdminCommand&userId=${users.userId}&role=manager">Manager</a>
        </td>
    </tr>
    </c:forEach>
        </table>
</div>
</c:if>
</body>
</html>
