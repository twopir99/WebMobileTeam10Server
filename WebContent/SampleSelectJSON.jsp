<%@ page language="java" contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>
<%

	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String callBack = request.getParameter("callback");

   // Returns all data as json.
   response.setContentType("application/json");
   response.setHeader("Content-Disposition", "inline");
%>
<%
Class.forName("com.mysql.jdbc.Driver");
//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "twopir" , "twopir");
Connection conn = DriverManager.getConnection("jdbc:mysql://websys1.stern.nyu.edu:3306/websysS1310", "websysS1310" , "websysS1310!!");
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
ResultSet rs = null;
 
String query = "SELECT * FROM samples";
rs = stmt.executeQuery(query);

String sample_id="";
String description="";
String mean="";
String variance="";
String sd="";
 
%>
<%=callBack%>(
[
<%
while(rs.next()) {
	sample_id = rs.getString("sample_id");
	description = rs.getString("description");
	mean = rs.getString("mean");
	variance = rs.getString("variance");
	sd = rs.getString("sd");
%>
	{
		"ID":"<%=sample_id %>",
		"Description":"<%=description %>",
		"Mean":"<%=mean %>",
		"Variance":"<%=variance %>",
		"SD":"<%=sd %>"
	}
<%		
	if(!rs.isLast()){
	%>
	,
	<%
	}
} 
%> 
]
)
<%

rs.close();
stmt.close();
conn.close();

%>
