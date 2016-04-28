<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>
	 
<%!
	String stmin;
	String batch_id;
	String sthr;
	String enhr;
	%>
	
<%
    stmin= request.getParameter("stmin");
	batch_id = request.getParameter("batch_id");
	sthr= request.getParameter("sthr");
	enhr = request.getParameter("enhr");
	%>
	
	<sql:update dataSource="${snapshot}" var="result">
	        update master set sttime = "<%= sthr %>:<%= stmin %>" where batch_id="<%= batch_id %> and hour(sttime) = <%= sthr %>"
	   	   </sql:update>
		   <sql:update dataSource="${snapshot}" var="result">
	        update master set entime = "<%= enhr %>:<%= stmin %>" where batch_id="<%= batch_id %> and hour(sttime) = <%= sthr %>"
	   	   </sql:update>