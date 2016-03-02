<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<HTML>
<HEAD>
<TITLE>IITI Scheduler</TITLE>
<LINK rel="stylesheet" type="text/css" href="http://localhost:9999/iitiScheduler/resources/stylesheet/main.css" />
</HEAD>
<BODY>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/schData"
     user="root"  password="root"/>

<sql:query dataSource="${snapshot}" var="result">
SELECT distinct(batchname) from batch;
</sql:query>

<div class='header'>
<img src='http://localhost:9999/iitiScheduler/resources/images/logo.png'>
</div>
<div class='tit'>IITI Scheduler
</div>
<form action='timetableview.jsp' method='GET'>
<table width=20%>
<tr><td>Select Batch&nbsp&nbsp</td>
<td><select name='selBat'>
<c:forEach var="row" items="${result.rows}">
	<option value="<c:out value="${row.batchname}"/>"><c:out value="${row.batchname}"/></option>
</c:forEach>
</select>
</td>
</tr>
<tr><td>Start time </td><td><input name='stHr' type='text' value='00' maxLength=2 size=1%>:<input name='stMin' type='text' value='00' maxLength=2 size=1%></td></tr>
<tr><td>Semester </td><td><select name='sem'><option value='autumn'>Autumn</option><option value='spring'>Spring</option></select></td></tr>
<tr><td colspan=2><center><input type='submit' value='Generate'></center></td></tr>
</table>
</BODY>
</HTML>