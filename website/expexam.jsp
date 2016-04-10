<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>

	<style>
		table{
			border: 1px solid black;
			border-spacing: 0px;
			border-collapse: collapse;
		}
		td {
			border: 1px solid black;
			padding: 10px;
		}
		th {
			border: 1px solid black;
			padding: 10px;
		}
		caption {
			border: 1px solid black;
		}
		ul {
			list-style-type: none;
			margin: 0px;
			padding: 0px;
		}
	</style>

</head>

<body onload='document.getElementById("ta").innerHTML=sessionStorage.myVal;'>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

	<table>
	<%! int i,j,k; 
	    String slotid;
	%>
	<% 
		String fst = request.getParameter("fst").toString();
		String fen = request.getParameter("fen").toString();
		String ast = request.getParameter("ast").toString();
		String aen = request.getParameter("aen").toString();
		String sem = request.getParameter("sem").toString();
		String part = request.getParameter("part").toString();
		String md = request.getParameter("md").toString();
		String ta = request.getParameter("ta").toString();
		int day = Integer.parseInt(request.getParameter("date").toString().substring(1,3));
		int mon = Integer.parseInt(request.getParameter("date").toString().substring(4,6));
		int yer = Integer.parseInt(request.getParameter("date").toString().substring(7,11));
		fst = fst.substring(1,fst.length()-1);
		fen = fen.substring(1,fen.length()-1);
		ast = ast.substring(1,ast.length()-1);
		aen = aen.substring(1,aen.length()-1);
		sem = sem.substring(1,sem.length()-1);
		part = part.substring(1,part.length()-1);
		md = md.substring(1,md.length()-1);
		ta = ta.substring(1,ta.length()-1);
	%>
	<tr><th colspan=6>Indian Institute of Technology, Indore</th></tr>
	<tr><th colspan=6>Date Sheet for <%= part %> Examination, <%= yer %> <%= sem %> Semester</th></tr>
	<tr>
		<th>
		Time Slot
		</th>
		<th colspan=2>Forenoon Session<br><%= fst %>-<%= fen %></th>
		<th colspan=3>Afternoon Session<br><%= ast %>-<%= ast %></th>
	</tr>
	<tr><th>Year: </th><th>I Year</th><th>III Year</th><th>II Year</th><th>IV Year</th><th>MSC/MTECH/PHD</th></tr>
	<tr><th>Day and Date</th><th colspan=2>Course Code</th><th colspan=2>Course Code</th><th>Course Code</th></tr>
	<% 
		k = Integer.parseInt(request.getParameter("day").toString());
		for(int i=0;i<8;i++){
			out.print("<tr>\n");
			if(k==2)out.print("<td><ul><li>Monday</li>");
			if(k==3)out.print("<td><ul><li>Tuesday</li>");
			if(k==4)out.print("<td><ul><li>Wednesday</li>");
			if(k==5)out.print("<td><ul><li>Thursday</li>");
			if(k==6)out.print("<td><ul><li>Friday</li>");
			if(k==0||k==7)out.print("<td><ul><li>Saturday</li>");
			if(k==1)out.print("<td><ul><li>Sunday</li>");
			out.print("<li>("+day+"/"+mon+"/"+yer+")</li></ul></td>");
			if((day==30 && (mon==4 || mon==6 || mon==8 || mon==10 || mon==12)) || (day==31 && (mon==1 || mon==3 || mon==5 || mon==7 || mon==9 || mon==11)) || (day==29 && mon==2 && (yer%4)==0) || (day==28 && mon==2 && (yer%4)!=0)){
				day = 1;
				mon++;
				if(mon == 13){
					mon = 1;
					yer++;
				}
			}else{
				day++;
			}
			for(int j=0;j<5;j++){
				int dat;
				switch(j){
					case 0: dat = 1;
						break;
					case 1: dat = 3;
						break;
					case 2: dat = 2;
						break;
					case 3: dat = 4;
						break;
					default: dat = 6;
				}
				out.print("<td class=\"drop\" id=\"slot" + (5*i+j) + "\" data-yr=\"" +dat+ "\"><span style='width:0px;'></span>");
				slotid="slot"+(5*i+j);	
			%>
			<sql:query dataSource="${snapshot}" var="result">
					SELECT * from slave where timeslot_id="<%= slotid %>";
			</sql:query>
			<c:forEach var="row" items="${result.rows}">
				<c:set var="len" value="${fn:length(row.course_id)}"/>
				<c:set var="yr" value="${fn:substring(row.course_id,len-3,len-2)}"/>
				<c:out value="${row.course_id}"/>
				<br>
			</c:forEach><%
				out.print("</td>\n");
			}
			out.print("</tr>\n");
			if(k==6){
				k=0;
			}else{
				k++;
			}
		}
	%>
	</table><br>
	Prepared by: <%= md %><br><br>Copy to: <br><div id="ta" style="margin:0px;padding:5px;"><%= ta %></div>
<%
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "inline; filename="
                    + "excel.xls");
    %>
</body>
</html>