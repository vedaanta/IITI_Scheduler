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
		body {
			padding: 0px;
			margin: 0px;
			background-color: #a0c6dc;
		}
		div.banner {
			position: relative;
			display: block;
			margin: 0px;
			padding: 0.5%;
			background-color: #19384a;
			width: 100%;
			height: 10%;
		}
		div.banner img {
			height: 100%;
		}
		table{
			float:left;
			border: 5px solid #19384a;
			background-color: #a0c6dc;
		}
		th {
			background-color: #19384a;
			color: white;
			text-weight: bold;
		}
		td {
			width:80px;
			height:80px;
			border: 2px solid #19384a;
			text-align: center;
			background-color: white; 
			font-weight: bold;
		}
		ul {
			border: 1px solid #19384a;
			height:69.5%;
			min-width: 50px;
			width: 10%;
			text-align: center;
			overflow:scroll;
			background-color: white;
			padding: 0px;
			float: left;
			margin: 0px;
			clear: right;
		}
		li {list-style-type: none;}
		.ui-dialog-titlebar-close {
		  visibility: hidden;
		}
		li:hover {
			background-color: #a0c6dc;
		}
		input[type=button] {
			border: 2px solid #19384a;
			color: white;
			background-color: #19384a;
			transition: border 0.25s;
			margin: 0px;
			padding: 10px;
		}
		input[type=button]:hover {
			border: 2px solid white;
		}
		input[type=submit] {
			border: 2px solid #19384a;
			color: white;
			background-color: #19384a;
			transition: border 0.25s;
			margin: 0px;
			padding: 10px;
		}
		input[type=submit]:hover {
			border: 2px solid white;
		}
		div.heading {
			display:block;
			background-color: #19384a;
			color: white;
			font-size: 20px;
			font-weight: bold;
			border: 5px solid #19384a;
		}
		form {
			display: inline;
			margin: 0px;
			padding: 0px;
		}
	</style>

	<script>
		var id1;
		var id2;
		var id3;
		var id4;
		var id5;
		var id6;
		$(function(){
			$("li").css('cursor','pointer').click(function(){
				$.ajax({
					type: 'POST',
					url: 'displayexam.jsp',
					data:{
						course_id: $(this).attr("data-id"),
					},
					success: function (response){
						document.getElementById("courseinfo").innerHTML=response;
					},
			    error: function() {
			        alert('Something Went Wrong');
			    }
				});
				$("#courseinfo").dialog('open');
			});
			$(".drag").draggable({
				revert:'invalid',
				cursor:'crosshair',
				helper:'clone'
			});
			$(".drop").droppable({
				accept:'.drag',
				tolerance:'pointer',
				hoverClass:'ui-state-highlight',
				drop: function(event,ui){
                    	$(ui.draggable).detach().css({top:0,left:0}).appendTo($(this));
                    	id1=$(this).attr("id");
                    	id2=$(ui.draggable).attr("data-id");
                    	$("#classinput").dialog('open');
               	}
			});
			$("ul").droppable({
				accept:'.drag',
				hoverClass:'ui-state-highlight',
				drop: function(event,ui){
                    	$(ui.draggable).detach().css({top:0,left:0}).appendTo($(this));
                    	id1=$(this).attr("id");
                    	id2=$(ui.draggable).attr("data-id");
                    	go();
               	}
			});
			$("#resetdialog").dialog({
				modal:true,
				autoOpen:false,
				buttons:[
					{
						text:"Yes",
						click:function(){
							$.ajax({
								url : 'generateexam.jsp',
								complete: function () {
									location.reload(true);
								}
							});
							$("#resetdialog").dialog('close');
						}
					}
				]
			});
			$("#classinput").dialog({
				modal:true,
				autoOpen:false,
 				closeOnEscape: false,
				buttons:[
					{
						text:"Submit",
						click:function(){
							id6=classroom.value;
							var letterNumber = /^[0-9A-Z]+$/; 
							if(letterNumber.test(id6)){
								go();
								$("#classinput").dialog('close');
							}
						}
					}
				]
			});
			$("#courseinfo").dialog({
				modal:true,
				autoOpen:false
			});
			$("#conflictstudent").dialog({
				modal:true,
				autoOpen:false
			});
			conflict();
		});

		function go(){
			$.ajax({
				type : 'POST',
				url : 'nextexam.jsp',
				data : {
					timeslot_id : id1 ,
					course_id : id2,
					classroom : id6
				},
			    complete: function(){
					conflict();
			    }
			});
			
		}

		function reset(){
			$("#resetdialog").dialog('open');
		}

		$(document).on('click', '.liststudent', function () {
	        	$("#conflictstudent").dialog('open');
	        	$.ajax({
	        		type:'POST',
	        		url:'liststudentexam.jsp',
	        		data:{
	        			course1:$(this).attr("data-c1"),
	        			course2:$(this).attr("data-c2")
	        		},
	        		success:function (response){
	        			document.getElementById("conflictstudent").innerHTML=response;
	        		}
	        	});
	    });

		function conflict(){
			$.ajax({
				type:'POST',
				url:'classroomexam.jsp',
				success:function(response){
					document.getElementById("conclass").innerHTML="<b>Conflicts in Classroom Assignment: </b><br>"+response;
				}
			});
			
			$.ajax({
				type:'POST',
				url:'teacherexam.jsp',
				data:{
					batch_id: id3
				},
				success:function(response){
					document.getElementById("conteacher").innerHTML="<b>Conflicts in Instructor Availablility: </b><br>"+response;
				}
			});
			$.ajax({
				type:'POST',
				url:'studentexam.jsp',
				success:function(response){
					document.getElementById("constudent").innerHTML="<b>Conflicts in Student's Schedule: </b><br>"+response;
				}
			});
		}
		

	</script>

</head>


<body>
<div class="banner"><img src="images/logo.png"/></div>
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

	<table>
	<%! int i,j; 
	    String slotid;
	%>
	<tr>
		<th>
		EXAM
		</th>
		<th>Morning Session</th>
		<th>Afternoon Session</th>
	</tr>
	<% 
		for(int i=0;i<8;i++){
			out.print("<tr>\n");
			if(i==2)out.print("<td>Monday</td>");
			if(i==3)out.print("<td>Tuesday</td>");
			if(i==4)out.print("<td>Wednesday</td>");
			if(i==5)out.print("<td>Thursday</td>");
			if(i==6)out.print("<td>Friday</td>");
			if(i==0||i==7)out.print("<td>Saturday</td>");
			if(i==1)out.print("<td>Sunday</td>");
			for(int j=0;j<2;j++){
				out.print("<td class=\"drop\" id=\"slot" + (2*i+j) + "\" ><span style='width:0px;'></span>");
				slotid="slot"+(2*i+j);	
			%>
			<sql:query dataSource="${snapshot}" var="result">
					SELECT * from slave where timeslot_id="<%= slotid %>";
			</sql:query>
			
			<c:forEach var="row" items="${result.rows}">
				<li class="drag" data-id="<c:out value="${row.course_id}"/>">
				<c:out value="${row.course_id}"/>
				</li>
			</c:forEach><%
				out.print("</td>\n");
			}
			out.print("</tr>\n");
		}
	%>
	</table>


	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from slave where timeslot_id is null
	</sql:query>
	<div class="heading">Courses
	<input type="button" value="RESET" onclick="reset()">
	<form action="printexam.jsp" method='get'>
	<input type="submit" value="PRINT"/>
	</form>
	<form action="index.jsp" method='get'>
	<input type="submit" value="EXIT"/>
	</form></div>
	<ul id="list">
		<c:forEach var="row" items="${result.rows}">
			<li class="drag" data-id="<c:out value="${row.course_id}"/>">
			<c:out value="${row.course_id}"/>
			</li>
		</c:forEach>
	</ul>

	<div style="height:33%;width:321px;bottom:0; float: left;border:1px solid #19384a;background-color:white;padding: 5px" id="constudent"></div >
	<div style="height:33%;width:321px;bottom:0; float: left;border:1px solid #19384a;background-color:white;padding: 5px" id="conteacher"></div >
	<div style="height:33%;width:321px;bottom:0; float: left;border:1px solid #19384a;background-color:white;padding: 5px" id="conclass"></div >


<div id="resetdialog" title="Are you sure?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>All courses will be removed from all slots!! If yes, please press the button below.</p>
</div>

<div id="classinput" title="Enter Classroom">
	<p>Provide the classroom where this course exam will be held below:</p>
	<input type="text" id="classroom"/>
</div>

<div id="courseinfo" title="Course Information"></div>

<div id="conflictstudent" title="List of Students"></div>
</body>
</html>


   


