<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>

<head>

	<link rel="stylesheet" href="jquery-ui.css">
    <script src="jquery.min.js"></script>
    <script src="jquery-ui.min.js"></script>

	<title>
		IITI SCHEDULER
	</title>

</head>

<body>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

     <sql:query dataSource="${snapshot}" var="result">
		SELECT min(batch_id) as batchid from batch
	</sql:query>

	<c:forEach var="row" items="${result.rows}">
		<a href="swag.jsp?batch=<c:out value="${row.batchid}"/>">Classroom</a>
	</c:forEach>
	<a href="swagexam.jsp">Exam</a>

</body>
</html>