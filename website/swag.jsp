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
			width:75px;
			height:75px;
			border: 1px solid black;
			text-align: center;
		}
		ul {
			border: 1px solid black;
			height:200px;
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
                    	$("#classinput").dialog('open');
                    	id1=$(this).attr("id");
                    	id2=$(ui.draggable).attr("data-id");
                    	id4=$(ui.draggable).attr("data-type");
                    	id5=$(ui.draggable).attr("data-serial");
                    	
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
								}
							});
							$("#resetdialog").dialog('close');
							location.reload(true);
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
							$("#classinput").dialog('close');

							go();
						}
					}
				]
			});
			$("#courseinfo").dialog({
				modal:true,
				autoOpen:false
			});
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
				success : function (response){
					document.getElementById("conflict").innerHTML=response;
				},
			    error: function() {
			        alert('Something Went Wrong');
			    }
			});
		}

		function reset(){
			$("#resetdialog").dialog('open');
		}

		

	</script>

</head>


<body>
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/mydb"
     user="root"  password=";"/>

     <% String name = request.getParameter("batchselector"); %> 
     <script>id3="<%= name %>";</script>

     <sql:query dataSource="${snapshot}" var="result">
		SELECT batch_name from batch where batch_id="<%= name %>";
	</sql:query>

	<c:forEach var="row" items="${result.rows}">
		<c:out value="${row.batch_name}"/></br>
	</c:forEach>

	<table>
	<%! int i,j; 
	    String slotid;
	%>
	<% 
		for(int i=0;i<5;i++){
			out.print("<tr>\n");
			if(i==0)out.print("<td>Monday</td>");
			if(i==1)out.print("<td>Tuesday</td>");
			if(i==2)out.print("<td>Wednesday</td>");
			if(i==3)out.print("<td>Thrusday</td>");
			if(i==4)out.print("<td>Friday</td>");
			for(int j=0;j<9;j++){
				out.print("<td class=\"drop\" id=\"slot" + (9*i+j) + "\" ><span style='width:0px;'></span>");
				slotid="slot"+(9*i+j);	
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

	<ul id="list">
		<c:forEach var="row" items="${result.rows}">
			<li class="drag" data-id="<c:out value="${row.course_id}"/>" data-type="<c:out value="${row.type}"/>" data-serial="<c:out value="${row.serial}"/>"><c:out value="${row.course_id}"/> (<c:out value="${row.type}"/>)</li>
		</c:forEach>
	</ul>

	<textarea rows="20" cols="150" id="conflict"></textarea>

	<input type="button" value="RESET" onclick="reset()">

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

<div id="classinput" title="Enter Classroom">
	<p>Provide the classroom where this course lectures will be held below:</p>
	<input type="text" id="classroom"/>
</div>

<div id="courseinfo" title="Course Information"></div>

</html>


   


