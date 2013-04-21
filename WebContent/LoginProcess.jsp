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
	System.out.println("userid : " + userid);
	System.out.println("password : " + password);
%>

<% 
String query = "SELECT count(user_id) as usercnt FROM user ";
query = query + "WHERE user_id = '"+userid+"' ";
query = query + "AND password = '"+password+"' ";

ResultSet rs = null;
rs = stmt.executeQuery(query);


%>

<%=callBack%>(

<%

int usercnt=0;
JSONArray jsonarr = new JSONArray(); 
while(rs.next()) {
	JSONObject obj = new JSONObject();
	usercnt = rs.getInt("usercnt");
	obj.put("usercnt",usercnt);
	if(usercnt==0){
		obj.put("success",new Boolean(false));
	}else{
		obj.put("success",new Boolean(true));
	}
	
	jsonarr.put(obj);
	
}
System.out.println(jsonarr.toString());
out.print(jsonarr.toString());
out.flush();
%> 

)

<%
rs.close();
%>
<%@ include file="./CloseFooter.jsp"%>