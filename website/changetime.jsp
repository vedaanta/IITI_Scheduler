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

	<%! String starthour; 
	String startminute; 
	%>

     <% starthour= request.getParameter("shour");
    	   startminute= request.getParameter("smin");
     %>

 	<sql:update dataSource="${snapshot}" var="result">
 		update time set starthour= <%= starthour %>
  	</sql:update>

  	<sql:update dataSource="${snapshot}" var="result">
 		update time set startminute= <%= startminute %>
  	</sql:update>

</body>

</html>