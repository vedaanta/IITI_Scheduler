<%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/><%! String slot_id;
	    String course_id;
	    String batch_id;
	    String type;
	    String serial;
	    String classroom;
	%><% slot_id= request.getParameter("timeslot_id"); 
      course_id= request.getParameter("course_id"); 
      batch_id= request.getParameter("batch_id");
      serial= request.getParameter("serial");
      classroom= request.getParameter("classroom");
      type= request.getParameter("type");
	   pageContext.setAttribute("qwe", slot_id); 
     %><c:choose>
	    <c:when test="${qwe == 'list' }">
	    	   <sql:update dataSource="${snapshot}" var="result">
	        update master set classroom = nUlL where course_id="<%= course_id %>" and batch_id="<%= batch_id %>" and serial="<%= serial %>" and type="<%= type %>"
	   	   </sql:update>
	   	   <sql:update dataSource="${snapshot}" var="result">
	        update master set timeslot_id= nUlL where course_id="<%= course_id %>" and batch_id="<%= batch_id %>" and serial="<%= serial %>" and type="<%= type %>"
	   	   </sql:update>
	    </c:when>
	    <c:otherwise>
	    	   <sql:update dataSource="${snapshot}" var="result">
	        update master set timeslot_id="<%= slot_id %>" where course_id="<%= course_id %>" and batch_id="<%= batch_id %>" and serial="<%= serial %>" and type="<%= type %>"
	   	   </sql:update>
	   	   <sql:update dataSource="${snapshot}" var="result">
	        update master set classroom= "<%= classroom %>" where course_id="<%= course_id %>" and batch_id="<%= batch_id %>" and serial="<%= serial %>" and type="<%= type %>"
	   	   </sql:update>
	    </c:otherwise>
	</c:choose><sql:query dataSource="${snapshot}" var="result">
		select * from master as b,master as a,batch as c,batch as d where b.timeslot_id=a.timeslot_id and b.classroom=a.classroom and (a.course_id<b.course_id or a.type<b.type or a.serial<b.serial or a.batch_id<b.batch_id) and b.batch_id=c.batch_id and a.batch_id=d.batch_id
	</sql:query><c:forEach var="row" items="${result.rowsByIndex}">
		<c:out value="${row[1]}"/>(<c:out value="${row[13]}"/>) and <c:out value="${row[7]}"/>(<c:out value="${row[15]}"/>)
	</c:forEach><sql:query dataSource="${snapshot}" var="result">
		select * from master as a,master as b,teacher as c,teacher as d where a.timeslot_id=b.timeslot_id and (a.course_id<b.course_id or a.type<b.type or a.serial<b.serial or a.batch_id<b.batch_id) and a.course_id=c.course_id and b.course_id=d.course_id and c.course_instructor=d.course_instructor 
	</sql:query><c:forEach var="row" items="${result.rowsByIndex}">
		<c:out value="${row[1]}"/>(<c:out value="${row[13]}"/>) and <c:out value="${row[7]}"/>(<c:out value="${row[15]}"/>)
	</c:forEach>
	<sql:query dataSource="${snapshot}" var="result">
		select * from master as a,master as b,student as c,student as d where a.timeslot_id=b.timeslot_id and (a.course_id<b.course_id or a.type<b.type or a.serial<b.serial or a.batch_id<b.batch_id) and a.course_id=c.course_id and b.course_id=d.course_id and c.roll_no=d.roll_no 
	</sql:query><c:forEach var="row" items="${result.rowsByIndex}">
		<c:out value="${row[1]}"/>(<c:out value="${row[12]}"/>) and <c:out value="${row[7]}"/>(<c:out value="${row[14]}"/>)
	</c:forEach>