<!DOCTYPE HTML>
<%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>
<html>

<%!
String course1;
String course2;
%>
<%
course1= request.getParameter("course1");
course2= request.getParameter("course2");
%>
<b><%= course1 %> and <%= course2 %> :</b><br>
<sql:query dataSource="${snapshot}" var="result">

select c.roll_no from slave as a,slave as b,student as c,student as d where a.timeslot_id is not null and b.timeslot_id is not null and a.course_id=c.course_id and b.course_id=d.course_id and c.roll_no=d.roll_no and a.course_id="<%= course1 %>" and b.course_id="<%= course2 %>"

</sql:query>

<c:forEach var="row" items="${result.rowsByIndex}">
<c:out value="${row[0]}"/><br>
</c:forEach>

</html>