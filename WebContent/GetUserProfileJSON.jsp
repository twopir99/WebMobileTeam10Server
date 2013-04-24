<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>

<%@ include file="./ConnectionHeader.jsp"%>

<% 
String query = "SELECT * FROM user ";//userid should get from previous step

ResultSet rs = null;
rs = stmt.executeQuery(query);

String userid="";
String password="";
String name="";
String level="";
String gender="";
String age="";
String nationality="";
String email="";
String phonenumber="";
 
%>
<%=callBack%>(
[
<%
while(rs.next()) {
	userid = rs.getString("user_id");
	password = rs.getString("password");
	name = rs.getString("name");
	level = rs.getString("level");
	gender = rs.getString("gender");
	age = rs.getString("age");
	nationality = rs.getString("nationality");
	email = rs.getString("email");
	phonenumber = rs.getString("phone_number");
%>
	{
		"userid":"<%=userid %>",
		"password":"<%=password %>",
		"name":"<%=name %>"
		"level":"<%=level %>",
		"gender":"<%=gender %>",
		"age":"<%=age %>"
		"nationality":"<%=nationality %>",
		"email":"<%=email %>",
		"phonenumer":"<%=phonenumber %>"
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