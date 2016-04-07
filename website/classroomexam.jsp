<%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>

<sql:query dataSource="${snapshot}" var="result"> 
select a.course_id,b.course_id,b.classroom from slave as b,slave as a where a.timeslot_id is not null and b.timeslot_id=a.timeslot_id and b.classroom=a.classroom and a.course_id<b.course_id
</sql:query>
<c:forEach var="row" items="${result.rowsByIndex}"> <c:out value="${row[0]}"/> and <c:out value="${row[1]}"/> : <c:out value="${row[2]}"/></br>
</c:forEach>