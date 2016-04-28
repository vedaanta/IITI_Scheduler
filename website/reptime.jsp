<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>
	 
<%! String sthr;
	String stmin;
	String sthr2;
	String stmin2;
	String batch_id;
	int nhr;
	int ohr;
	%>
	
<%
	sthr= request.getParameter("sthr");
    stmin= request.getParameter("stmin");
	sthr2= request.getParameter("sthr2");
    stmin2= request.getParameter("stmin2");
	batch_id = request.getParameter("batch_id");
	nhr = Integer.parseInt(sthr2);
	ohr = Integer.parseInt(sthr);
	nhr++;
	ohr++;
	if(nhr >= 24){
		nhr = nhr-24;
	}
	if(ohr >= 24){
		ohr = ohr-24;
	}
	%>
	
	<sql:update dataSource="${snapshot}" var="result">
	        update master set sttime = "<%= sthr2 %>:<%= stmin2 %>" where batch_id="<%= batch_id %>" and sttime="<%= sthr %>:<%= stmin %>"
	   	   </sql:update>
		   <sql:update dataSource="${snapshot}" var="result">
	        update master set entime = "<%= nhr %>:<%= stmin2 %>" where batch_id="<%= batch_id %>" and sttime="<%= sthr2 %>:<%= stmin %>"
	   	   </sql:update>