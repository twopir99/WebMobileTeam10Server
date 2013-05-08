<%@ page language="java" contentType="application/json" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.*"%>

<%@ include file="./ConnectionHeader.jsp"%>

<% 
String scheduleid = request.getParameter("scheduleid");
String matchid = request.getParameter("matchid");
scheduleid="13";
matchid="1";
System.out.println("scheduleid for json " + scheduleid);
String query = "SELECT * FROM schedule where schedule_id = '" + scheduleid + "'";
System.out.println(query);

ResultSet rs = null;
rs = stmt.executeQuery(query);



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
String puserid="";

int i=0;
 
%>
<%=callBack%>(
[
<%
while(rs.next()) {
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
String querymatch = "SELECT user_id FROM schedule where match_result_id = '" + matchid + "'";
ResultSet rs1 = null;
rs1 = stmt1.executeQuery(querymatch);
while(rs1.next()){
	puserid=rs1.getString("user_id");
}
%>
		"puserid":"<%=puserid %>",
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