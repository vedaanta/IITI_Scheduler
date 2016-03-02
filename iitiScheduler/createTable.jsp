<%@ page import="java.sql.*" %>
<%  
            Connection connection = null;
	    String str = request.getParameter("batid");
	    String str2 = request.getParameter("sem");
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                connection = DriverManager.getConnection("jdbc:mysql://localhost", "root", "root");
                Statement statement = connection.createStatement();
		String query = "use schData;";
		statement.executeQuery(query);
                String command = "create table "+str+""+str2+"tt (timeslotid varchar(20) PRIMARY KEY, starttime time, endtime time, dayofslot varchar(20), courseid varchar(20));";
                statement.executeUpdate(command);
		out.println("Table loaded.");

            } catch (Exception e) {
                out.println("An error occurred: "+e.toString());
            }
%>