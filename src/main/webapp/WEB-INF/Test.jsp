<%--
  Created by IntelliJ IDEA.
  User: Александр
  Date: 17.12.2021
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>TEST.JSP</h1>
<c:out value="${requestScope.message}"></c:out>
</body>
</html>