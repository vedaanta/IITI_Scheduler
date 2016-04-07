<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<body>

	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

	<%! String course_id;
	    String batch_id;
	    String type;
	    String serial;
	%>
	

     <% 
      course_id= request.getParameter("course_id"); 
      batch_id= request.getParameter("batch_id");
      serial= request.getParameter("serial");
      type= request.getParameter("type"); 
     %>

    <b>Course ID</b> : <%= course_id %></br>

     <sql:query dataSource="${snapshot}" var="result">
		SELECT * from course where course_id="<%= course_id %>";
	</sql:query>

	<c:forEach var="row" items="${result.rows}">
	<c:set var="temp" value="${row.course_id}"/>
		<b>Course Title</b> : <c:out value="${row.course_name}"/></br>
		<c:choose>
			<c:when test="${temp != 'Break'}">
		<b>L-T-P</b> : <c:out value="${row.lecture_hour}"/> <c:out value="${row.tutorial_hour}"/> <c:out value="${row.practical_hour}"/></br></c:when>
		</c:choose>
	</c:forEach>
 	
	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from master where course_id="<%= course_id %>" and batch_id="<%= batch_id %>" and serial="<%= serial %>" and type="<%= type %>";
	</sql:query>
	
	<c:forEach var="row" items="${result.rows}">
		<c:set var="qwer" value="${row.classroom}"/>
		
		<c:choose>
			<c:when test="${(qwer != null) && (temp != 'Break') }">
				<b>Classroom</b> : <c:out value="${row.classroom}"/></br>
			</c:when>
		</c:choose>
	</c:forEach>	

	<c:choose>
			<c:when test="${temp != 'Break'}">
	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from teacher where course_id="<%= course_id %>";
	</sql:query>

	<b>Teacher</b> : 
	<c:forEach var="row" items="${result.rows}">
		<c:out value="${row.course_instructor}"/></br>
	</c:forEach>
	
	</c:when>
		</c:choose>
</body>

</html>