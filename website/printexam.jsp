<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<head>

	<style>
		table{
			float:left;
			border: 1px solid black;
		}
		td {
			width:120px;
			height:120px;
			border: 1px solid black;
			text-align: center;
		}
	</style>

</head>

<body>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>

<%!String name;%><%name= request.getParameter("batchprint");%>

<table>
	<%! int i,j; 
	    String slotid;
	%>
	<tr>
		<td>EXAM</td>
		<td>Morning Session</td>
		<td>Afetrnoon Session</td>
		
	</tr>
	<% 
		for(int i=0;i<8;i++){
			out.print("<tr>\n");
			if(i==2)out.print("<td>Monday</td>");
			if(i==3)out.print("<td>Tuesday</td>");
			if(i==4)out.print("<td>Wednesday</td>");
			if(i==5)out.print("<td>Thrusday</td>");
			if(i==6)out.print("<td>Friday</td>");
			if(i==0||i==7)out.print("<td>Saturday</td>");
			if(i==1)out.print("<td>Sunday</td>");
			for(int j=0;j<2;j++){
				out.print("<td><span style='width:0px;'></span>");
				slotid="slot"+(2*i+j);	
			%>
			<sql:query dataSource="${snapshot}" var="result">
					SELECT * from slave where timeslot_id="<%= slotid %>";
			</sql:query>
			
			<c:forEach var="row" items="${result.rows}">

			<c:out value="${row.course_id}"/>,<c:out value="${row.classroom}"/><c:set var="courseid" value="${row.course_id}"/><sql:query dataSource="${snapshot}" var="result">SELECT * from teacher as a,initials as b where course_id="<c:out value="${courseid}" />" and a.course_instructor=b.course_instructor;</sql:query><c:forEach var="qwerty" items="${result.rowsByIndex}">,<c:out value="${qwerty[3]}"/></c:forEach><br>
			</c:forEach>
			<%
				out.print("</td>\n");
			}
			out.print("</tr>\n");
		}
	%>
	</table>

</body>
</html>