<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<HTML>
<HEAD>
<TITLE>IITI Scheduler</TITLE>
<SCRIPT type="text/javascript" src="http://localhost:9999/iitiScheduler/resources/script/main.js">
</SCRIPT>
<LINK rel="stylesheet" type="text/css" href="http://localhost:9999/iitiScheduler/resources/stylesheet/main.css" />
</HEAD>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/schData"
     user="root"  password="root"/>

<sql:query dataSource="${snapshot}" var="result">
SELECT distinct(batchid) from batch where batchname = "<%= request.getParameter("selBat") %>";
</sql:query>

<c:forEach var="row" items="${result.rows}">
	<c:set var="bi" value="${row.batchid}" />
</c:forEach>
<BODY onload='createTable("<c:out value="${bi}" />","<%= request.getParameter("sem") %>")'>
<div class='header'  >
<img src='http://localhost:9999/iitiScheduler/resources/images/logo.png'>
</div>
<div class='tit'>IITI Scheduler
</div>
<form>
<%! int Hours; %>
<%! int Minutes; %>
<%! String str; %>
<%! int num; %>
<%! int i; %>
<%! String str2; %>
<% Hours = Integer.parseInt(request.getParameter("stHr")); %>
<% Minutes = Integer.parseInt(request.getParameter("stMin")); %>
<% str = request.getParameter("selBat"); %>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/schData"
     user="root"  password="root"/>
<sql:query dataSource="${snapshot}" var="result">
SELECT DISTINCT(noc) from batch where batchname="<%= str %>";
</sql:query>
<c:forEach var="row" items="${result.rows}">
	<c:set var="str2" value="${row.noc}" />
</c:forEach>
<sql:query dataSource="${snapshot}" var="result">
SELECT DISTINCT(courseid) from batch where batchname="<%= str %>";
</sql:query>
<table border=2% width=70%>
	<tr>
		<td>&nbsp;&nbsp;</td>
		<c:forEach var="i" begin="1" end="${str2}" >
		<td>
			<% if(Hours>=10){ %><%= Hours++ %><% }else{ out.println("0"+Hours);Hours++; }%> : <% if(Minutes>=10) { %><%= Minutes %><% }else{ out.println("0"+Minutes); }%> - <% if(Hours>=10){ %><%= Hours %><% }else{ out.println("0"+Hours); }%> : <% if(Minutes>=10) { %><%= Minutes %><% }else{ out.println("0"+Minutes); }%>
		</td>
		</c:forEach>
	</tr>
	<%! int cnt=0; %> 
	<c:forEach var="i" begin="1" end="5" >
	<tr>
	<td>
	<% cnt++;
	switch(cnt){
		case 1:out.println("Monday"); %>
			<c:set var="d" value="MO" />
			<% break;
		case 2:out.println("Tuesday"); %>
			<c:set var="d" value="TU" />
			<% break;
		case 3:out.println("Wednesday"); %>
			<c:set var="d" value="WE" />
			<% break;
		case 4:out.println("Thursday"); %>
			<c:set var="d" value="TH" />
			<% break;
		case 5:out.println("Friday"); %>
			<c:set var="d" value="FR" />
			<% break;
		default: ;
	}
	%>
	</td>
	<c:forEach var="j" begin="1" end="${str2}" >
	<td id="<c:out value="${d}" /><c:out value="${j}" />">
	<select id="<c:out value="${d}" /><c:out value="${j}" /><c:out value="dd" />">
	<c:forEach var="row" items="${result.rows}">
	<option value="<c:out value="${row.courseid}" />"><c:out value="${row.courseid}" /></option>
</c:forEach>
	<c:set var="chk" value="${str2}" />
	<c:choose>
	<c:when test="${j == (chk+1)/2}">
	<option value="break" selected="selected">Break</option>
	<option value="null">-</option>
	</c:when>
	<c:otherwise>
	<option value="break">Break</option>
	<option value="null" selected="selected">-</option>
	</c:otherwise>
	</c:choose>
	</select>
	</td>
	</c:forEach>
	</tr>
	</c:forEach>
	<% cnt=0; %>
</table>
<div id="status"></div>
</BODY>
</HTML>