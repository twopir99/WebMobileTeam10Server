<%@ page language="java" contentType="text/html; charset=utf-8" import="java.sql.*" %>
<%
Class.forName("com.mysql.jdbc.Driver");
//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "twopir" , "twopir");
Connection conn = DriverManager.getConnection("jdbc:mysql://websys1.stern.nyu.edu:3306/websysS1310", "websysS1310" , "websysS1310!!");
Statement stmt = conn.createStatement();
ResultSet rset = null;
 
String query = "SELECT * FROM samples";
rset = stmt.executeQuery(query);

String sample_id="";
String description="";
String mean="";
String variance="";
String sd="";


 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table>
	<TR>
		<TD>ID</TD>
		<TD>Desc</TD>
		<TD>Mean</TD>
		<TD>Variance</TD>
		<TD>SD</TD>
	</TR>
	<%
	while(rset.next()) {
		sample_id = rset.getString("sample_id");
		description = rset.getString("description");
		mean = rset.getString("mean");
		variance = rset.getString("variance");
		sd = rset.getString("sd");
	%>
		<TR>
			<TD><%=sample_id %></TD>
			<TD><%=description %></TD>
			<TD><%=mean %></TD>
			<TD><%=variance %></TD>
			<TD><%=sd %></TD>
		</TR>
	<%		
		} 
	%> 
</table>
</body>
</html>

<%

rset.close();
stmt.close();
conn.close();

%>
