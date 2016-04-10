<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>

<head>

	<link rel="stylesheet" href="jquery-ui.css">
    <script src="jquery.min.js"></script>
    <script src="jquery-ui.min.js"></script>

	<title>
		IITI Scheduler
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
			overflow: hidden
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
		var da;
		var datee;
		var sa;
		var satee;
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
                    	id1=$(this).attr("id");
                    	id2=$(ui.draggable).attr("data-id");
						var year=$(ui.draggable).attr("data-yr");
						var chkyr=$(this).attr("data-yr");
						if(year == chkyr){
							$(ui.draggable).detach().css({top:0,left:0}).appendTo($(this));
							go();
						}else{
							if(chkyr != 6){
								var r=confirm("Sorry, the course dragged was of "+year+" year, while the slot was of "+chkyr+" year. Do you want to continue?");
							}else{
								var r=confirm("Sorry, the course dragged was of "+year+" year, while the slot was of MSC/MTECH/PHD. Do you want to continue?");
							}
							if(r == true){
								$(ui.draggable).detach().css({top:0,left:0}).appendTo($(this));
								go();
							}
						}
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
			conflict();
		});

		function go(){
			$.ajax({
				type : 'POST',
				url : 'nextexam.jsp',
				data : {
					timeslot_id : id1 ,
					course_id : id2
				},
			    complete: function(){
					conflict();
			    }
			});
			
		}

		function reset(){
			$("#resetdialog").dialog('open');
		}

		function conflict(){
			$.ajax({
				type:'POST',
				url:'studentexam.jsp',
				success:function(response){
					document.getElementById("constudent").innerHTML="<b>Conflicts in Student's Schedule: </b><br>"+response;
				}
			});
		}
		function expfn(da,datee){
			alert(""+document.getElementById("ta").innerHTML);
			window.open("expexam.jsp?day="+da+"&date='"+datee+"'&fst='"+document.getElementById("fst").value+"'&fen='"+document.getElementById("fen").value+"'&ast='"+document.getElementById("ast").value+"'&aen='"+document.getElementById("aen").value+"'&sem='"+document.getElementById("sem").value+"'&part='"+document.getElementById("part").value+"'&md='"+document.getElementById("md").value+"'&ta='"+document.getElementById("ta").innerHTML+"'","_self");
		}
		function printfn(sa,satee){
			sessionStorage.myVal = document.getElementById("ta").innerHTML.toString();
			window.open("printexam.jsp?day="+sa+"&date='"+satee+"'&fst='"+document.getElementById("fst").value+"'&fen='"+document.getElementById("fen").value+"'&ast='"+document.getElementById("ast").value+"'&aen='"+document.getElementById("aen").value+"'&sem='"+document.getElementById("sem").value+"'&part='"+document.getElementById("part").value+"'&md='"+document.getElementById("md").value+"'&ta='"+document.getElementById("ta").innerText+"'");
		}
		function handle(e){
			if(e.keyCode == 13){
				document.getElementById("taul").innerHTML = document.getElementById("taul").innerHTML+"<li class='tali'>"+document.getElementById("ct").value+"</li>";
				document.getElementById("ct").value = "";
			}
		}
		function clrAr(){
			document.getElementById("taul").innerHTML = "";
		}
	</script>

</head>


<body>
<div class="banner"><img src="images/logo.png"/></div>
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

	<table>
	<%! int i,j,k; 
	    String slotid;
	%>
	<tr>
		<th>
		Time Slot
		</th>
		<th colspan=2>Forenoon Session<br><input type="text" id="fst" value="9:30" style="width:50px"/>-<input type="text" id="fen" value="12:30" style="width:50px"/></th>
		<th colspan=3>Afternoon Session<br><input type="text" id="ast" value="2:30" style="width:50px"/>-<input type="text" id="aen" value="5:30" style="width:50px"/></th>
	</tr>
	<tr><th>Year: </th><th>I Year</th><th>III Year</th><th>II Year</th><th>IV Year</th><th>MSC/MTECH/PHD</th></tr>
	<tr><th>Day and Date</th><th colspan=2>Course Code</th><th colspan=2>Course Code</th><th>Course Code</th></tr>
	<% 
		k = Integer.parseInt(request.getParameter("day").toString());
		int day = Integer.parseInt(request.getParameter("date").toString().substring(1,3));
		int mon = Integer.parseInt(request.getParameter("date").toString().substring(4,6));
		int yer = Integer.parseInt(request.getParameter("date").toString().substring(7,11));
		for(int i=0;i<8;i++){
			out.print("<tr>\n");
			if(k==2)out.print("<td>Monday<br>");
			if(k==3)out.print("<td>Tuesday<br>");
			if(k==4)out.print("<td>Wednesday<br>");
			if(k==5)out.print("<td>Thursday<br>");
			if(k==6)out.print("<td>Friday<br>");
			if(k==0||k==7)out.print("<td>Saturday<br>");
			if(k==1)out.print("<td>Sunday<br>");
			out.print("("+day+"/"+mon+"/"+yer+")</td>");
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
				<li class="drag" data-id="<c:out value="${row.course_id}"/>" data-yr="<c:out value="${yr}"/>">
				<c:out value="${row.course_id}"/>
				</li>
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
	</table>


	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from slave where timeslot_id is null
	</sql:query>
	<div class="heading">Courses
	<input type="button" value="RESET" onclick="reset()">
	<input type="submit" value="EXPORT TO EXCEL" onclick='expfn("<%= k %>","<% out.print(request.getParameter("date").toString().substring(1,11)); %>")' />
	<input type="button" value="PRINT" onclick='printfn("<%= k %>","<% out.print(request.getParameter("date").toString().substring(1,11)); %>")' />
	<form action="index.jsp" method='get'>
	<input type="submit" value="EXIT"/>
	</form></div>
	<ul id="list">
		<c:forEach var="row" items="${result.rows}">
			<c:set var="len" value="${fn:length(row.course_id)}"/>
			<c:set var="yr" value="${fn:substring(row.course_id,len-3,len-2)}"/>
			<li class="drag" data-id="<c:out value="${row.course_id}"/>" data-yr="<c:out value="${yr}"/>">
			<c:out value="${row.course_id}"/>
			</li>
		</c:forEach>
	</ul>

	<div style="height:33%;width:321px;bottom:0; float: left;border:1px solid #19384a;background-color:white;padding: 5px" id="constudent"></div >
	<div class="optCont"><b>Additional Options: </b><br><table class="normal"><tr><td>Semester:</td><td><select id="sem"><option value="Autumn">Autumn</option><option value="Spring">Spring</option></select></td></tr>
	<tr><td>Part of Semester:</td><td><select id="part"><option value="Mid Semester">Mid Semester</option><option value="End Semester">End Semester</option></select></td></tr>
	<tr><td>Prepared by: </td><td><input type='text' id='md' /></td></tr>
	<tr><td>Copy to: </td><td><input type='text' id='ct' onkeypress='handle(event)' placeholder='Press Enter to Submit'/></td><td><input type="button" value="X" onclick="clrAr()"/></td></tr>
	<tr><td colspan=3><div id='ta'><ol id='taul'></ol></div></td></tr></table>
	</div>
	<div id="resetdialog" title="Are you sure?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>All courses will be removed from all slots!! If yes, please press the button below.</p>
</div>

<div id="courseinfo" title="Course Information"></div>

<div id="conflictstudent" title="List of Students"></div>
</body>
</html>


   


