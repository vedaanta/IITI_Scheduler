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
		table{
			float:left;
			border: 1px solid black;
		}
		td {
			width:80px;
			height:80px;
			border: 1px solid black;
			text-align: center;
		}
		ul {
			border: 1px solid black;
			height:300px;
			min-width: 50px;
			float:right;
			text-align: center;
			overflow:scroll;
		}
		li {list-style-type: none;}
		.ui-dialog-titlebar-close {
		  visibility: hidden;
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
					document.getElementById("conclass").innerHTML=response;
				}
			});
			
			$.ajax({
				type:'POST',
				url:'teacherexam.jsp',
				data:{
					batch_id: id3
				},
				success:function(response){
					document.getElementById("conteacher").innerHTML=response;
				}
			});
			$.ajax({
				type:'POST',
				url:'studentexam.jsp',
				success:function(response){
					document.getElementById("constudent").innerHTML=response;
				}
			});
		}
		

	</script>

</head>


<body>
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

	<table>
	<%! int i,j; 
	    String slotid;
	%>
	<tr>
		<td>
		EXAM
		</td>
		<td>Morning Session</td>
		<td>Afetrnoon Session</td>
	</tr>
	<% 
		for(int i=0;i<8;i++){
			out.print("<tr>\n");
			if(i==2)out.print("<td>Monday</td>");
			if(i==3)out.print("<td>Tuesday</td>");
			if(i==4)out.print("<td>Wednesday</td>");
			if(i==5)out.print("<td>Thrusday</td>");
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

	<ul id="list">
		<c:forEach var="row" items="${result.rows}">
			<li class="drag" data-id="<c:out value="${row.course_id}"/>">
			<c:out value="${row.course_id}"/>
			</li>
		</c:forEach>
	</ul>

	<div style="height:33%;width:33%;bottom:0; float: left;border:1px solid black;" id="constudent"></div >
	<div style="height:33%;width:33%;bottom:0; float: left;border:1px solid black;" id="conteacher"></div >
	<div style="height:33%;width:33%;bottom:0; float: left;border:1px solid black;" id="conclass"></div >

	<input type="button" value="RESET" onclick="reset()">
	<form action="printexam.jsp" method='get'>
	<input type="submit" value="PRINT"/>
	</form>

</body>

<div id="resetdialog" title="Are you sure?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>All courses will be removed from all slots!! If yes,please press the button below.</p>
</div>

<div id="classinput" title="Enter Classroom">
	<p>Provide the classroom where this course exam will be held below:</p>
	<input type="text" id="classroom"/>
</div>

<div id="courseinfo" title="Course Information"></div>

<div id="conflictstudent" title="List of Students"></div>

</html>


   


