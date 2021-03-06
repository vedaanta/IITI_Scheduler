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
			height:394px;
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
		div.optCont {
			float: left;
			width: 331px;
			background-color: #19384a;
			color: white;
			border: 1px solid #19384a;
		}
		table.normal {
			border: 0px solid black;
			background-color: transparent;
		}
		table.normal td{
			width: 100px;
			height: 20px;
			border: none;
			background-color: transparent;
			text-align: left;
			font-weight: normal;
			color: white;
		}
		#taul {
			padding: 0px;
			margin: 20px;
		}
		
		#taul .tali {
			list-style-type: decimal;
			color: black;
			text-align: left;
		}
		
		#taul .tali:hover {
			color: black;
			background-color:white;
		}
		#ta {
			background-color: white;
			overflow: hidden;
			width: 300px;
			padding: 0px;
			margin: 0px;
		}
	</style>

	<script>
		var id1;
		var id2;
		var id3;
		var id4;
		var id5;
		var id6;
		var count=0;
		var i;
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
			$(".inputtime").css('cursor','pointer').click(function(){
				$("#taketime").dialog('open');
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
			$("#taketime").dialog({
				modal:true,
				autoOpen:false,
				buttons:[
					{
						text:"Submit",
						click:function(){
							$.ajax({
								type : 'POST',
								url : 'changetime.jsp',
								data : {
									shour: $("#hour :selected").val(),
									smin: $("#min :selected").val()
								},
								error: function(jqXHR,exception){ 
									alert("Error: Ready State: "+jqXHR.readyState+" Status: "+jqXHR.status);
								},
								complete: function () {
									location.reload(true);
								}
							});
							$("#timeinput").dialog('close');
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
					document.getElementById("conclass").innerHTML="<b>Conflicts in Classroom Assignment: </b><br>"+response;
				}
			});
			$.ajax({
				type:'POST',
				url:'teacher.jsp',
				data:{
					batch_id: id3
				},
				success:function(response){
					document.getElementById("conteacher").innerHTML="<b>Conflicts in Instructor Availablility: </b><br>"+response;
				}
			});
			$.ajax({
				type:'POST',
				url:'student.jsp',
				data:{
					batch_id: id3
				},
				success:function(response){
					document.getElementById("constudent").innerHTML="<b>Conflicts in Student's Schedule: </b><br>"+response;
				}
			});
		}

		
		function handle(e){
			if(e.keyCode == 13){
				document.getElementById("taul").innerHTML = document.getElementById("taul").innerHTML+"<li class='tali'><input type='text' value='"+document.getElementById("ct").value+"' name='cto'/></li>";
				document.getElementById("ct").value = "";
				count++;
			}
		}
		function clrAr(){
			document.getElementById("taul").innerHTML = "";
		}
		function expfn(){
			//alert(""+document.getElementById("ta").innerHTML);
			if(document.getElementById("y").value == "" || document.getElementById("md").value == "" || document.getElementById("ta").innerHTML == ""){
				alert("Please enter the details in \"Additional Options\".");
			}else{
			window.open("exp.jsp?sem='"+document.getElementById("sem").value+"'&year='"+document.getElementById("y").value+"'&md='"+document.getElementById("md").value+"'&ta="+document.getElementById("ta").innerHTML+"");
			}
		}
		function prnfn(){
			sessionStorage.myVal2 = "";
			if(document.getElementById("y").value == "" || document.getElementById("md").value == "" || document.getElementById("ta").innerHTML == ""){
				alert("Please enter the details in \"Additional Options\".");
			}else{
			var el = document.getElementsByName("cto");
			for(i=0;i<count;i++){
				sessionStorage.myVal2 = sessionStorage.myVal2+"<li>"+el[i].value+"</li>";
			}
			//alert(""+document.getElementById("ta").innerHTML);
			window.open("print.jsp?sem="+document.getElementById("sem").value+"&year="+document.getElementById("y").value+"&md="+document.getElementById("md").value+"&ta="+document.getElementById("ta").innerHTML+"");
			}
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


		<sql:query dataSource="${snapshot}" var="result">
			SELECT * from time;
		</sql:query>
		<c:forEach var="row" items="${result.rows}">
			<c:set var="sh" value="${row.starthour}"/>
			<c:set var="sm" value="${row.startminute}"/>
		</c:forEach>

		<c:forEach var="i" begin="0" end="9">
		<c:choose>
		<c:when test="${sm == 0}">
   			<th class="inputtime"><c:out value="${sh+i}"/>:<c:out value="${sm}"/>0-<c:out value="${sh+i+1}"/>:<c:out value="${sm}"/>0</th>
   		</c:when>
   		<c:otherwise>
			<th class="inputtime"><c:out value="${sh+i}"/>:<c:out value="${sm}"/>-<c:out value="${sh+i+1}"/>:<c:out value="${sm}"/></th>
  	 	</c:otherwise>
   		</c:choose>
		</c:forEach>

	</tr>
	<% 
		for(int i=0;i<5;i++){
			out.print("<tr>\n");
			if(i==0)out.print("<td>Monday</td>");
			if(i==1)out.print("<td>Tuesday</td>");
			if(i==2)out.print("<td>Wednesday</td>");
			if(i==3)out.print("<td>Thursday</td>");
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
	
	<div class="heading">Courses
	<input type="button" value="RESET" onclick="reset()">
	<input type="submit" value="EXPORT TO EXCEL" onclick='expfn()' />
	<input type="submit" value="PRINT" onclick='prnfn()'/>
	<form action="index.jsp" method='get'>
	<input type="submit" value="EXIT"/>
	</form></div>
	<ul id="list">
		<c:forEach var="row" items="${result.rows}">
			<li class="drag" data-id="<c:out value="${row.course_id}"/>" data-type="<c:out value="${row.type}"/>" data-serial="<c:out value="${row.serial}"/>"><c:out value="${row.course_id}"/> (<c:out value="${row.type}"/>)</li>
		</c:forEach>
	</ul>
	<div style="height:33%;width:321.5px;bottom:0; float: left;border:1px solid #19384a;background-color:white;padding: 5px" id="constudent"></div >
	<div style="height:33%;width:321px;bottom:0; float: left;border:1px solid #19384a;background-color:white;padding: 5px" id="conteacher"></div >
	<div style="height:33%;width:321px;bottom:0; float: left;border:1px solid #19384a;background-color:white;padding: 5px" id="conclass"></div >



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

<div id="classinput" title="Enter Classroom">
	<p>Provide the classroom where this course lectures will be held below:</p>
	<input type="text" id="classroom"/>
</div>

<div id="courseinfo" title="Course Information"></div>

<div id="taketime" title="Change the start time">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>All batches will be get the same start hour and minute you provide below. To proceed press Submit:</p>
	<p>
		<select name="hour" id="hour">
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
		</select>:
		<select name="min" id="min">
			<option value="0">00</option>
			<option value="15">15</option>
			<option value="30">30</option>
			<option value="45">45</option>
		</select>
	</p>
</div>
<div id="conflictstudent" title="List of Students"></div>
<div class="optCont"><b>Additional Options: </b><br><table class="normal"><tr><td>Semester:</td><td><select id="sem"><option value="Autumn">Autumn</option><option value="Spring">Spring</option></select></td></tr>
	<tr><td>Year:</td><td><input type='text' id='y' /></td></tr>
	<tr><td>Prepared by: </td><td><input type='text' id='md' /></td></tr>
	<tr><td>Copy to: </td><td><input type='text' id='ct' onkeypress='handle(event)' placeholder='Press Enter to Submit'/></td><td><input type="button" value="X" onclick="clrAr()"/></td></tr>
	<tr><td colspan=3><div id='ta'><ol id='taul'></ol></div></td></tr></table>
	</div>
   </body>

</html>
