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
		SELECT * from batch;
	
	</sql:query>
	<form method="GET" action="swag.jsp">
	<select name="batchselector" id="batchselector">
	<%! int flag=1; %>
	<c:forEach var="row" items="${result.rows}">
	<% if(flag==1){ %>
		<option value="${row.batch_id}" selected><c:out value="${row.batch_name}"/></option>
		<% flag=0; 
	}
	else{ %> 
		<option value="${row.batch_id}" ><c:out value="${row.batch_name}"/></option>
	<% } %>
	</c:forEach>
	</select>
	<input type="submit" value="Submit"/>
	</form>

	<a href="swagexam.jsp">Go! Go! Go!</a>

</body>
</html>