<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.json.*" %>
<%@ page import="schedule.*"%>

<%@ include file="./ConnectionHeader.jsp"%>

<%
	System.out.println("IN SCHEDULE PROCESS ");
	String userid = request.getParameter("userid");
	String date = request.getParameter("date");
	String timestart = request.getParameter("timestart");
	String timeend = request.getParameter("timeend");
	String gender = request.getParameter("gender");
	String nationality = request.getParameter("nationality");
	String level = request.getParameter("level");
	System.out.println("level :: "+level);
 	String[] levelarr = level.split(",");
	System.out.println("levelarr :: "+levelarr[0]);
    String age = request.getParameter("age");
	String[] agearr = age.split(","); 
	String type = request.getParameter("type");
	String double_yn= "y";
	if(type == "sinlge"){
		double_yn = "n";
	}else{}
	String status = "1";
	String status_push = "1";
	String status_mail = "1";
	
	System.out.println("userid : " + userid);
%>

<%
//First match the exist records
/* String match = "Select * from schedule where";
match = match + "date='" + date + "' and ";
match = match + "timeslot_start='" + timestart + "' and ";
match = match + "timeslot_end='" + timeend + "' and ";
match = match + "double_yn='" + double_yn + "' and ";
match = match + "status=1";
System.out.println(match);
ResultSet rs = stmt.executeQuery(match);
while(rs.next()){ 
	
}
*/
%>

<% 
String query = "Insert into schedule (schedule_id, user_id, date, timeslot_start, timeslot_end, gender, nationality, double_yn, status, status_push, status_mail, create_date, mod_date) ";
query = query + "select get_next_seq_val('schedule'), ";
query = query + "'"+userid+"', ";
query = query + "'"+date+"', ";
query = query + "'"+timestart+"', ";
query = query + "'"+timeend+"', ";
query = query + "'"+gender+"', ";
query = query + "'"+nationality+"', ";
query = query + "'"+double_yn+"', ";
query = query + "'"+status+"', ";
query = query + "'"+status_push+"', ";
query = query + "'"+status_mail+"', ";
query = query + "now(), ";
query = query + "now() ";
System.out.println("INSERT INTO SCHEDULE :: "+query);
int rscnt = 0;
rscnt = stmt.executeUpdate(query);
%>

<% 
for (int i = 0 ; i < levelarr.length ; i++)
{
	String lquery;
	if(i==0){
		lquery = "Insert into schedule_level (schedule_id, level_id, level) ";
		lquery = lquery + "select get_curr_seq_val('schedule'), ";
		lquery = lquery+ " reset_seq_val('level'), ";
		lquery = lquery + "'"+levelarr[i]+"' ";
	}else{
		lquery = "Insert into schedule_level (schedule_id, level_id, level) ";
		lquery = lquery + "select get_curr_seq_val('schedule'), ";
		lquery = lquery+ " get_next_seq_val('level'), ";
		lquery = lquery + "'"+levelarr[i]+"' ";
	}
	rscnt = 0;
	rscnt = stmt.executeUpdate(lquery);
}
%>

<% 
for (int i = 0 ; i < agearr.length ; i++)
{
	String aquery;
	if(i==0){
		aquery = "Insert into schedule_age (schedule_id, age_id, age) ";
		aquery = aquery + "select get_curr_seq_val('schedule'), ";
		aquery = aquery+ " reset_seq_val('age'), ";
		aquery = aquery + "'"+agearr[i]+"' ";
	}else{
		aquery = "Insert into schedule_age (schedule_id, age_id, age) ";
		aquery = aquery + "select get_curr_seq_val('schedule'), ";
		aquery = aquery+ "get_next_seq_val('age'), ";
		aquery = aquery + "'"+agearr[i]+"' ";
	}
	rscnt = 0;
	rscnt = stmt.executeUpdate(aquery);
}
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

<%-- call bean functions  --%>
<%
	HashMap<String, Object> umap = new HashMap<String, Object>();
	umap.put("userid", userid);
	umap.put("date", date);
	umap.put("timestart", timestart);
	umap.put("timeend", timeend);
	umap.put("gender", gender);
	umap.put("nationality", nationality);
	umap.put("double_yn", double_yn);
	umap.put("status", status);
	umap.put("agearr", agearr);
	umap.put("levelarr", levelarr);
	
	MatchingProcessBean matchingProcess = new MatchingProcessBean();
	matchingProcess.getMatch(umap);
	
%>

<%@ include file="./CloseFooter.jsp"%>