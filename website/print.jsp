<%@ page import="java.io.*,java.util.*,java.sql.*"%> <%@ page import="javax.servlet.http.*,javax.servlet.*" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  
<html> 
<head>  
<style> table{ border: 1px solid black; border-spacing: 0px; border-collapse: collapse; } td { border: 1px solid black; padding: 10px; } th { border: 1px solid black; padding: 10px; } caption { border: 1px solid black; } ul { list-style-type: none; margin: 0px; padding: 0px; } </style>  
</head>  
<body onload='var ta = document.getElementsByName("ta");for(var k=0;k<ta.length;k++){ta[k].innerHTML="<ol>"+sessionStorage.myVal2+"</ol>";}window.print();'> <% 
		String sem = request.getParameter("sem").toString();
		String part = request.getParameter("year").toString();
		String md = request.getParameter("md").toString();
		String ta = request.getParameter("ta").toString();
		String cto[] = request.getParameterValues("cto");
		%>
		<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>   
		<sql:query dataSource="${snapshot}" var="result"> SELECT * from batch </sql:query>  
		<c:forEach var="ovrow" items="${result.rows}"> 
		<c:set var="bid" value="${ovrow.batch_id}" /> 
		<p style="page-break-after: always; text-align: center;">
		<table style="border:none;width: 700px;"> 
		<%! int i,j; String slotid; String bid; %> 
		<caption><b>Indian Institute of Technology, Indore</b></caption>
		<tr><th colspan=11><%= part %> <%= sem %>: Class Time Table for <c:out value="${ovrow.batch_name}"/></th></tr>
		<tr><td> <script>id3="<c:out value="${ovrow.batch_id}" />";</script>Day/Time</td>
		<sql:query dataSource="${snapshot}" var="result"> SELECT * from time; </sql:query> 
		<c:forEach var="row" items="${result.rows}"> 
		<c:set var="sh" value="${row.starthour}"/> 
		<c:set var="sm" value="${row.startminute}"/> 
		</c:forEach>  
		<c:forEach var="i" begin="0" end="9"> 
		<c:choose> 
		<c:when test="${sm == 0}"> <th class="inputtime"><c:out value="${sh+i}"/>:<c:out value="${sm}"/>0-<c:out value="${sh+i+1}"/>:<c:out value="${sm}"/>0</th> </c:when> 
		<c:otherwise> <th class="inputtime"><c:out value="${sh+i}"/>:<c:out value="${sm}"/>-<c:out value="${sh+i+1}"/>:<c:out value="${sm}"/></th> </c:otherwise> 
		</c:choose> 
		</c:forEach></tr> 
		<% bid = (String)pageContext.getAttribute("bid"); 
		for(int i=0;i<5;i++){ 
		out.print("<tr>\n"); 
		if(i==0)out.print("<td>Monday</td>"); 
		if(i==1)out.print("<td>Tuesday</td>"); 
		if(i==2)out.print("<td>Wednesday</td>"); 
		if(i==3)out.print("<td>Thursday</td>"); 
		if(i==4)out.print("<td>Friday</td>"); 
		for(int j=0;j<10;j++){ 
		slotid="slot"+(10*i+j); 
		out.print("<td><span style='width:0px;'></span>"); 
		%>
		<sql:query dataSource="${snapshot}" var="result2"> SELECT * from master where batch_id="<%= bid %>" and timeslot_id="<%= slotid %>"; </sql:query> 
		<c:forEach var="row2" items="${result2.rows}"> 
		<c:set var="courseid" value="${row2.course_id}"/> 
		<c:out value="${row2.course_id}"/> 
		</c:forEach> 
		<% out.print("</td>\n"); 
		} 
		out.print("</tr>\n"); 
		} 
		%> 
		<tr><td colspan=5 style='border: none'>Made by: <%= md %></td></tr>
		<tr></tr>
		<tr><td colspan=1 style='border: none'>Copy to: </td></tr>
		<tr><td colspan=6 style='border: none' name='ta'></td></tr>
		</table> 
		</p>
		</c:forEach>  
		</body> 
		</html>