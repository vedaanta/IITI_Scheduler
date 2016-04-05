<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>

<head>

</head>

<body>

	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

	<%! String batch_id; 
	    char[] year;
	    String temp;
	    char[] courseid;
	    char num;
	    int count;
	%>

     <% batch_id= request.getParameter("batch_id");
    	   year= request.getParameter("year").toCharArray();
	   //out.print(batch_id+year); 
     %>

 	<sql:update dataSource="${snapshot}" var="result">
 		delete from master where batch_id="<%= batch_id %>"
 	</sql:update>

	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from course;
	</sql:query>
	
	<c:forEach var="row" items="${result.rows}">
		<c:set var="temp2" value="${row.course_id}"/>
		<% temp=(String)pageContext.getAttribute("temp2"); %>
		<% courseid=temp.toCharArray(); %>
		<% num=courseid[ temp.length()-3 ]; %>

		<% if( (year[0]==num) || (num=='7' && year[0]=='6') ) { %>

			<c:set var="cnt" value="${row.lecture_hour}"/>
			<% count=(int)pageContext.getAttribute("cnt"); 
				for(int i=count;i>0;i--){
				%>

				<sql:update dataSource="${snapshot}" var="result">
			 		insert into master value("<%= batch_id %>","<%= temp %>","L",<%= i %>,null,null)
			 	</sql:update>

				<%
				}
			%>

			<c:set var="cnt" value="${row.tutorial_hour}"/>
			<% count=(int)pageContext.getAttribute("cnt"); 
				for(int i=count;i>0;i--){
				%>

				<sql:update dataSource="${snapshot}" var="result">
			 		insert into master value("<%= batch_id %>","<%= temp %>","T",<%= i %>,null,null)
			 	</sql:update>

				<%
				}
			%>

			<c:set var="cnt" value="${row.practical_hour}"/>
			<% count=(int)pageContext.getAttribute("cnt"); 
				for(int i=count;i>0;i--){
				%>

				<sql:update dataSource="${snapshot}" var="result">
			 		insert into master value("<%= batch_id %>","<%= temp %>","P",<%= i %>,null,null)
			 	</sql:update>

				<%
				}
			%>

		<%}%>
	</c:forEach>	







	<sql:update dataSource="${snapshot}" var="result">
 		insert into master value("<%= batch_id %>","Break","-",1,null,null)
 	</sql:update>

 	<sql:update dataSource="${snapshot}" var="result">
 		insert into master value("<%= batch_id %>","Break","-",2,null,null)
 	</sql:update>

 	<sql:update dataSource="${snapshot}" var="result">
 		insert into master value("<%= batch_id %>","Break","-",3,null,null)
 	</sql:update>

 	<sql:update dataSource="${snapshot}" var="result">
 		insert into master value("<%= batch_id %>","Break","-",4,null,null)
 	</sql:update>

 	<sql:update dataSource="${snapshot}" var="result">
 		insert into master value("<%= batch_id %>","Break","-",5,null,null)
 	</sql:update>

</body>

</html>