<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>

<%!String batch_id;%><%batch_id= request.getParameter("batch_id");%>

<sql:query dataSource="${snapshot}" var="result">

select * from master as a,master as b,teacher as c,teacher as d where a.timeslot_id is not null and a.timeslot_id=b.timeslot_id and (a.course_id<b.course_id or (a.course_id=b.course_id and a.type<b.type) or (a.course_id=b.course_id and a.type=b.type and a.serial<b.serial) or (a.course_id=b.course_id and a.type=b.type and a.serial=b.serial and a.batch_id<b.batch_id)) and a.course_id=c.course_id and b.course_id=d.course_id and c.course_instructor=d.course_instructor

</sql:query>

<c:forEach var="row" items="${result.rowsByIndex}">
<c:out value="${row[1]}"/> and <c:out value="${row[7]}"/> : <c:out value="${row[15]}"/></br>
</c:forEach>