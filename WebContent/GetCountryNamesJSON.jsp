<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>

<%@ include file="./ConnectionHeader.jsp"%>

<% 
String query = "SELECT * FROM countries order by name_en ";

ResultSet rs = null;
rs = stmt.executeQuery(query);

String code="";
String name_en="";
String name_fr="";
 
%>
<%=callBack%>(
[
<%
while(rs.next()) {
	code = rs.getString("code");
	name_en = rs.getString("name_en");
	name_fr = rs.getString("name_fr");
%>
	{
		"code":"<%=code %>",
		"name_en":"<%=name_en %>",
		"name_fr":"<%=name_fr %>"
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