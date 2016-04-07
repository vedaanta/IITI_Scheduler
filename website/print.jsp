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
		<td>

     <sql:query dataSource="${snapshot}" var="result">
		SELECT * from batch where batch_id="<%= name %>"
	</sql:query>
	
	<c:forEach var="row" items="${result.rows}">
		<c:out value="${row.batch_name}"/>
	</c:forEach>

     <script>id3="<%= name %>";</script>
		</td>
		<td>8:00-9:00</td>
		<td>9:00-10:00</td>
		<td>10:00-11:00</td>
		<td>11:00-12:00</td>
		<td>12:00-1:00</td>
		<td>1:00-2:00</td>
		<td>2:00-3:00</td>
		<td>3:00-4:00</td>
		<td>4:00-5:00</td>
		<td>5:00-6:00</td>
	</tr>
	<% 
		for(int i=0;i<5;i++){
			out.print("<tr>\n");
			if(i==0)out.print("<td>Monday</td>");
			if(i==1)out.print("<td>Tuesday</td>");
			if(i==2)out.print("<td>Wednesday</td>");
			if(i==3)out.print("<td>Thrusday</td>");
			if(i==4)out.print("<td>Friday</td>");
			for(int j=0;j<10;j++){
				out.print("<td><span style='width:0px;'></span>");
				slotid="slot"+(10*i+j);	
			%>
			<sql:query dataSource="${snapshot}" var="result">
					SELECT * from master where batch_id="<%= name %>" && timeslot_id="<%= slotid %>";
			</sql:query>
			
			<c:forEach var="row" items="${result.rows}">
			<c:set var="courseid" value="${row.course_id}"/>
			<c:out value="${row.course_id}"/>
			<c:choose>
			<c:when test="${ courseid != 'Break'}">
			 (<c:out value="${row.type}"/>),<c:out value="${row.classroom}"/>
			 <sql:query dataSource="${snapshot}" var="result">
			 SELECT * from teacher as a,initials as b where course_id="<c:out value="${courseid}" />" and a.course_instructor=b.course_instructor;</sql:query>
			 <c:forEach var="qwerty" items="${result.rowsByIndex}">
			 ,<c:out value="${qwerty[3]}"/>
			</c:forEach></c:when>
			</c:choose><br>
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