<!DOCTYPE HTML>
<%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>
<html>
Same Session Conflicts: <br>
<% int i=0;
while(i!=40){ %>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i) %>") and a.roll_no = b.roll_no and a.course_id < b.course_id;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i+1) %>") and a.roll_no = b.roll_no;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>
<% i+=2; %>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i) %>") and a.roll_no = b.roll_no and a.course_id < b.course_id;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i+1) %>") and a.roll_no = b.roll_no;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>
<% i+=3;
} %>
<br>Same Day Conflicts: <br>
<% i=0;
while(i!=40){ %>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i+2) %>") and a.roll_no = b.roll_no;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i+3) %>") and a.roll_no = b.roll_no;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>

<% i+=1; %>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i+1) %>") and a.roll_no = b.roll_no;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>
<sql:query dataSource="${snapshot}" var="result">
select a.roll_no as rno, a.course_id as course1, b.course_id as course2 from student a,student b where a.course_id in (select course_id from slave where timeslot_id="slot<%= i %>") and b.course_id in (select course_id from slave where timeslot_id="slot<%= (i+2) %>") and a.roll_no = b.roll_no;

</sql:query>

<c:forEach var="row" items="${result.rows}">
<span class="liststudent" data-c1="<c:out value="${row.course1}"/>" data-c2="<c:out value="${row.course2}"/>"><c:out value="${row.course1}"/> and <c:out value="${row.course2}"/> : <c:out value="${row.rno}"/></span></br>
</c:forEach>
<% i+=4; 
} %>
</html>