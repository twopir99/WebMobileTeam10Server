<%@ page import="java.sql.*" %>

<%

	String callBack = request.getParameter("callback");
	//System.out.println("callback : " + callBack);
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
   // Returns all data as json.
   response.setContentType("application/json");
   response.setHeader("Content-Disposition", "inline");
%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "twopir" , "twopir");
//Connection conn = DriverManager.getConnection("jdbc:mysql://websys1.stern.nyu.edu:3306/websysS1310", "websysS1310" , "websysS1310!!");
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

%>