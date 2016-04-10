<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

 	<%! String slot_id;
	    String course_id;
	    String classroom;
	%>

	<% slot_id= request.getParameter("timeslot_id"); 
      course_id= request.getParameter("course_id"); 
	   pageContext.setAttribute("qwe", slot_id); 
     %>

     <c:choose>
	    <c:when test="${qwe == 'list' }">
	   	   <sql:update dataSource="${snapshot}" var="result">
	        update slave set timeslot_id= nUlL where course_id="<%= course_id %>" 
	   	   </sql:update>
	    </c:when>
	    <c:otherwise>
	    	   <sql:update dataSource="${snapshot}" var="result">
	        update slave set timeslot_id="<%= slot_id %>" where course_id="<%= course_id %>" 
	   	   </sql:update>
	    </c:otherwise>
	</c:choose>