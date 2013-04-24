<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>

<%@ include file="./ConnectionHeader.jsp"%>

<% 
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
%>
<%@ include file="./CloseFooter.jsp"%>