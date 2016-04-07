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
			height:300px;
			min-width: 50px;
			width: 10%;
			float:right;
			text-align: center;
			overflow:scroll;
			background-color: white;
			padding: 0px;
			float: left;
			margin: 0px;
		}
		li {
			list-style-type: none;
		}
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
		}
		input[type=button]:hover {
			border: 2px solid white;
		}
		input[type=submit] {
			border: 2px solid #19384a;
			color: white;
			background-color: #19384a;
			transition: border 0.25s;
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
					url: 'display.jsp',
					data:{
						course_id: $(this).attr("data-id"),
						serial: $(this).attr("data-serial"),
						type: $(this).attr("data-type"),
						batch_id: id3
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
                    	//alert($(this).attr("id")+"->"+$(ui.draggable).attr("id"));
                    	
                    	id1=$(this).attr("id");
                    	id2=$(ui.draggable).attr("data-id");
                    	id4=$(ui.draggable).attr("data-type");
                    	id5=$(ui.draggable).attr("data-serial");
                    	if(id4!='-'){
                    		$("#classinput").dialog('open');
                    	}
                    	else go();
               	}
			});
			$("ul").droppable({
				accept:'.drag',
				hoverClass:'ui-state-highlight',
				drop: function(event,ui){
                    	$(ui.draggable).detach().css({top:0,left:0}).appendTo($(this));
                    	//alert($(this).attr("id")+"->"+$(ui.draggable).attr("id"));
                    	id1=$(this).attr("id");
                    	id2=$(ui.draggable).attr("data-id");
                    	id4=$(ui.draggable).attr("data-type");
                    	id5=$(ui.draggable).attr("data-serial");
                    	//alert(id1+id2+id3+id4+id5);
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
								type : 'POST',
								url : 'generate.jsp',
								data : {
									batch_id: id3,
									year: $("#year :selected").val()
								},
								error: function(jqXHR,exception){ 
									alert("Error: Ready State: "+jqXHR.readyState+" Status: "+jqXHR.status);
								},
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
				url : 'next.jsp',
				data : {
					timeslot_id : id1 ,
					course_id : id2,
					batch_id: id3,
					type: id4,
					serial: id5,
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
	        		url:'liststudent.jsp',
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
				url:'classroom.jsp',
				data:{
					batch_id: id3
				},
				success:function(response){
					document.getElementById("conclass").innerHTML=response;
				}
			});
			$.ajax({
				type:'POST',
				url:'teacher.jsp',
				data:{
					batch_id: id3
				},
				success:function(response){
					document.getElementById("conteacher").innerHTML=response;
				}
			});
			$.ajax({
				type:'POST',
				url:'student.jsp',
				data:{
					batch_id: id3
				},
				success:function(response){
					document.getElementById("constudent").innerHTML=response;
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

			<% String name = request.getParameter("myselect");
     if(name==null)name=request.getParameter("batch");
     pageContext.setAttribute("qwer", name); 
      %> 

     <sql:query dataSource="${snapshot}" var="result">
		SELECT * from batch
	</sql:query>
	<form action="swag.jsp" method="get">
	<select name="myselect" id="myselect" onchange="this.form.submit()">
	<c:forEach var="row" items="${result.rows}">
	<c:set var="temp" value="${row.batch_id}"/>
	<c:choose>
		 <c:when test="${ qwer == temp }">
		 	<option value="<c:out value="${row.batch_id}"/>" selected><c:out value="${row.batch_name}"/></option>
		 </c:when>
		 <c:otherwise>
		 	<option value="<c:out value="${row.batch_id}"/>"><c:out value="${row.batch_name}"/></option>
		 </c:otherwise>
	</c:choose>
	</c:forEach>
	 </select>
	</form>

     <script>id3="<%= name %>";</script>
		</th>
		<th>8:00-9:00</th>
		<th>9:00-10:00</th>
		<th>10:00-11:00</th>
		<th>11:00-12:00</th>
		<th>12:00-1:00</th>
		<th>1:00-2:00</th>
		<th>2:00-3:00</th>
		<th>3:00-4:00</th>
		<th>4:00-5:00</th>
		<th>5:00-6:00</th>
	</tr>
	<% 
		for(int i=0;i<5;i++){
			out.print("<tr>\n");
			if(i==0)out.print("<td>Monday</td>");
			if(i==1)out.print("<td>Tuesday</td>");
			if(i==2)out.print("<td>Wednesday</td>");
			if(i==3)out.print("<td>Thrusday</td>");
			if(i==4)out.print("<td>Friday</td>");
			for(int j=0;j<10;j++){
				out.print("<td class=\"drop\" id=\"slot" + (10*i+j) + "\" ><span style='width:0px;'></span>");
				slotid="slot"+(10*i+j);	
			%><sql:query dataSource="${snapshot}" var="result">
					SELECT * from master where batch_id="<%= name %>" && timeslot_id="<%= slotid %>";
				</sql:query><c:forEach var="row" items="${result.rows}"><li class="drag" data-id="<c:out value="${row.course_id}"/>" data-type="<c:out value="${row.type}"/>" data-serial="<c:out value="${row.serial}"/>"><c:out value="${row.course_id}"/>  (<c:out value="${row.type}"/>)</li></c:forEach><%
				out.print("</td>\n");
			}
			out.print("</tr>\n");
		}
	%>
	</table>


	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from master where batch_id="<%= name %>" and timeslot_id is null
	</sql:query>
	
	<div class="heading">Courses</div>
	<ul id="list">
		<c:forEach var="row" items="${result.rows}">
			<li class="drag" data-id="<c:out value="${row.course_id}"/>" data-type="<c:out value="${row.type}"/>" data-serial="<c:out value="${row.serial}"/>"><c:out value="${row.course_id}"/> (<c:out value="${row.type}"/>)</li>
		</c:forEach>
	</ul>
	<div style="height:33%;width:33%;bottom:0; float: left;border:1px solid black;background-color:white" id="constudent"></div >
	<div style="height:33%;width:33%;bottom:0; float: left;border:1px solid black;background-color:white" id="conteacher"></div >
	<div style="height:33%;width:33%;bottom:0; float: left;border:1px solid black;background-color:white" id="conclass"></div >
	<input type="button" value="RESET" onclick="reset()">
	<form action="print.jsp" method='get'>
	<input hidden="hidden" value="<%= name %>" name="batchprint"/>
	<input type="submit" value="PRINT"/>
	</form>
</body>

<div id="resetdialog" title="Are you sure?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>All courses for this batch will be removed from all slots!! If yes,please select the current year for this batch and press the button below.</p>
	<p>
		<select name="year" id="year">
			<option value="1">1</optoin>
			<option value="2">2</optoin>
			<option value="3">3</optoin>
			<option value="4">4</optoin>
			<option value="6">Other</optoin>
		</select>
	</p>
</div>

</html>

<div id="classinput" title="Enter Classroom">
	<p>Provide the classroom where this course lectures will be held below:</p>
	<input type="text" id="classroom"/>
</div>

<div id="courseinfo" title="Course Information"></div>

<div id="conflictstudent" title="List of Students"></div>
   


