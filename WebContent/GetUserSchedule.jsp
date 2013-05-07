<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>

<%@ include file="./ConnectionHeader.jsp"%>

<% 
String userid = request.getParameter("userid");
String query = "SELECT * FROM schedule where user_id = '" + userid + "'";
System.out.println(query);

ResultSet rs = null;
rs = stmt.executeQuery(query);

String scheduleid="";
String date="";
String timestart="";
String timeend="";
String level;
String age;
String pgender="";
String pnationality="";
String type="";
String status="";
String statuspush="";
String statusmail="";

int i=0;
 
%>
<%=callBack%>(
[
<%
while(rs.next()) {
	scheduleid=rs.getString("schedule_id");
	date = rs.getString("date");
	timestart = rs.getString("timeslot_start");
	timeend = rs.getString("timeslot_end");
	pgender = rs.getString("gender");
	pnationality = rs.getString("nationality");
	type = rs.getString("double_yn");
	status = rs.getString("status");
	statuspush = rs.getString("status_push");
	statusmail = rs.getString("status_mail");
%>
	{
		"scheduleid":"<%=scheduleid %>",
		"date":"<%=date %>",
		"timestart":"<%=timestart %>",
		"timeend":"<%=timeend %>",
		"pgender":"<%=pgender %>",
		"pnationality":"<%=pnationality %>",
		"type":"<%=type %>",
		"status":"<%=status %>",
		"statuspush":"<%=statuspush %>",
		"statusmail":"<%=statusmail %>",	
<%
	String queryl = "SELECT * FROM schedule_level where schedule_id = '" + scheduleid + "'";
	System.out.println(queryl);
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery(queryl);
	String querya = "SELECT * FROM schedule_age where schedule_id = '" + scheduleid + "'";
	System.out.println(querya);
	ResultSet rs3 = null;
	rs3 = stmt3.executeQuery(querya);
	%>
	"level":[
	<%
	while(rs2.next()){
		level=rs2.getString("level");
		%>
		{"lv":"<%=level%>"}
		<%
		if(!rs2.isLast()){
			%>
			,
			<%
		}
	}
	%>
	],
	"age":[
	<%	
	while(rs3.next()){
		age=rs3.getString("age");
		%>
		{"a":"<%=age%>"}
		<%
		if(!rs3.isLast()){
			%>
			,
			<%
		}
	}

	%>
	]
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