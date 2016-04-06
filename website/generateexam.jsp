<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>

<head>

</head>

<body>

	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

 	<sql:update dataSource="${snapshot}" var="result">
 		delete from slave
 	</sql:update>

	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from course
	</sql:query>
	
	<c:forEach var="row" items="${result.rows}">
		<sql:update dataSource="${snapshot}" var="result">
		insert into slave value("<c:out value="${row.course_id}"/>",null,null)
		</sql:update>
	</c:forEach>

	<sql:update dataSource="${snapshot}" var="result">
		delete from slave where course_id="Break"
	</sql:update>
</body>

</html>