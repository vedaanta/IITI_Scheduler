<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>

<head>

	<link rel="stylesheet" href="jquery-ui.css">
    <script src="jquery.min.js"></script>
    <script src="jquery-ui.min.js"></script>

	<title>
		IITI SCHEDULER
	</title>

	<style>
	div.banner {
		position: relative;
		display: block;
		margin: 0px;
		padding: 0.5%;
		background-color: #19384a;
		width: 100%;
		height: 15%;
	}
	
	body {
		padding: 0px;
		margin: 0px;
		overflow: hidden;
	}
	
	div.banner img {
		height: 100%;
	}
	
	ul {
		list-style-type: none;
		position: absolute;
		width: 60%;
		height: 60%;
		top: 20%;
		left: 20%;
	}
	
	li {
		display: block;
		float: left;
		background-color: #a0c6dc;
		width: 40%;
		height: 80%;
		margin: 1%;
		border: 5px solid #a0c6dc;
		border-radius: 20px;
		transition: background-color 0.5s;
	}
	 li a{
		 display: block;
		 width: 100%;
		 height: 100%;
		 color: black;
	 }
	 
	 li img{
		 display: block;
		 width: 100%;
		 height: 60%;
	 }
	li:hover{
		background-color: white;
	}
	
	div.butt {
		position: absolute;
		display: block;
		width: 10%;
		height: 50%;
		top: 20%;
		left: 20%;
	}
	
	div.butt2 {
		position: absolute;
		display: block;
		width: 10%;
		height: 50%;
		top: 20%;
		left: 61%;
	}
	</style>
	<script>
	$(function() {
		$("#examdialog").dialog({
				modal:true,
				autoOpen:false,
				buttons:[
					{
						text: "Submit",
						click: function(){
							window.location.replace(returl());
						}
					}
				]
			});
	});
	function examd () {
		$("#examdialog").dialog("open");
	}
	function returl(){
		return "swagexam.jsp?day=0&date=\'"+document.getElementById("sysdate").value+"\'";
	}
	</script>

	
</head>

<body>
<div class="banner"><img src="images/logo.png"/></div>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

     <sql:query dataSource="${snapshot}" var="result">
		SELECT min(batch_id) as batchid from batch
	</sql:query>

	<c:forEach var="row" items="${result.rows}">
		<ul><li><a href="swag.jsp?batch=<c:out value="${row.batchid}"/>"><div class="butt"><img src="images/book.png"/><center><b>Classroom</b></center></div></a></li>
	</c:forEach>
	<li><a onclick="examd()"><div class="butt2"><img src="images/clipboard.svg"/><center><b>Examination</b></center></div></a></li></ul>
	<div id="examdialog" title="Exam Time Table Details">
	
	<form>
	<table><tr><td>Starting Date</td>
	<td><input type="date" id="sysdate" name="startdate"/></td></tr></table>
	</form>
	</div>
</body>
</html>