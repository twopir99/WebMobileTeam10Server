<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.json.*" %>

<%@ include file="./ConnectionHeader.jsp"%>

<%
	System.out.println("IN CANCELL PROCESS ");
	String scheduleid = request.getParameter("scheduleid");
	
	System.out.println("scheduleid : " + scheduleid);
%>

<% 

String query = "Delete from schedule";
query = query + " where schedule_id = '" + scheduleid + "'";
System.out.println("query ::: " + query);
int rscnt = 0;
rscnt = stmt.executeUpdate(query);

%>
<% 

query = "Delete from schedule_level";
query = query + " where schedule_id = '" + scheduleid + "'";
System.out.println("query ::: " + query);
rscnt = stmt.executeUpdate(query);

%>
<% 

query = "Delete from schedule_age";
query = query + " where schedule_id = '" + scheduleid + "'";
System.out.println("query ::: " + query);
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