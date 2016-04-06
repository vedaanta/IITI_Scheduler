<%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>
<sql:query dataSource="${snapshot}" var="result">
select a.course_id,b.course_id,c.course_instructor from slave as a,slave as b,teacher as c,teacher as d where a.timeslot_id=b.timeslot_id and a.course_id<b.course_id and a.course_id=c.course_id and b.course_id=d.course_id and c.course_instructor=d.course_instructor
</sql:query>
<c:forEach var="row" items="${result.rowsByIndex}">
<c:out value="${row[0]}"/> and <c:out value="${row[1]}"/> : <c:out value="${row[2]}"/>
</c:forEach>