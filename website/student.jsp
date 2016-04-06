<!DOCTYPE HTML>
<%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>
<html>

<%!String batch_id;%>
<%batch_id= request.getParameter("batch_id");%>

<sql:query dataSource="${snapshot}" var="result">

select a.course_id,b.course_id,count(*) from master as a,master as b,student as c,student as d where a.timeslot_id=b.timeslot_id and (a.course_id<b.course_id or (a.course_id=b.course_id and a.type<b.type) or (a.course_id=b.course_id and a.type=b.type and a.serial<b.serial) or (a.course_id=b.course_id and a.type=b.type and a.serial=b.serial and a.batch_id<b.batch_id)) and a.course_id=c.course_id and b.course_id=d.course_id and c.roll_no=d.roll_no group by a.course_id,b.course_id

</sql:query>

<c:forEach var="row" items="${result.rowsByIndex}">
<span class="liststudent" data-c1="<c:out value="${row[0]}"/>" data-c2="<c:out value="${row[1]}"/>"><c:out value="${row[0]}"/> and <c:out value="${row[1]}"/> : <c:out value="${row[2]}"/></span></br>
</c:forEach>

</html>