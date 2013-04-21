<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.json.*" %>

<%@ include file="./ConnectionHeader.jsp"%>

<%
	System.out.println("IN LOGIN PROCESS ");
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String age = request.getParameter("age");
	String nationality = request.getParameter("nationality");
	String level = request.getParameter("level");
	String email = request.getParameter("email");
	String phonenumber = request.getParameter("phonenumber");
	
	System.out.println("userid : " + userid);
	System.out.println("password : " + password);
%>

<% 
String query = "Insert into user (user_id, password, name, level, gender, age, nationality, email, phone_number) ";
query = query + "values('"+userid+"', ";
query = query + "'"+password+"', ";
query = query + "'"+name+"', ";
query = query + "'"+level+"', ";
query = query + "'"+gender+"', ";
query = query + "'"+age+"', ";
query = query + "'"+nationality+"', ";
query = query + "'"+email+"', ";
query = query + "'"+phonenumber+"') ";

int rscnt = 0;
rscnt = stmt.executeUpdate(query);

%>

<%=callBack%>(

<%

JSONArray jsonarr = new JSONArray(); 
JSONObject obj = new JSONObject();
obj.put("rscnt",rscnt);
if(rscnt==0){
	obj.put("success",new Boolean(false));
}else{
	obj.put("success",new Boolean(true));
}

jsonarr.put(obj);
	

System.out.println(jsonarr.toString());
out.print(jsonarr.toString());
out.flush();
%> 

)

<%@ include file="./CloseFooter.jsp"%>