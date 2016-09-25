<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/11/97
-->


<html>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<!--#include file="../authenticate.inc"-->
<!--#include file="cal_nav.inc"-->
<%
call cal_nav(CDbl(Request.QueryString("month")),CDbl(Request.QueryString("year")))

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT * FROM cal_events WHERE" _
	& " event_context='" & Request.QueryString("event_context") _
	& "' AND event_start BETWEEN #" & m _
	& "-1-" & y & "# AND #" _
	& mnext & "-1-" _
	& ynext & "#" _
	& " ORDER BY event_start"
	
Set rs = db.Execute(query)

' uncomment this line to debug SQL:
' response.write query
%>

<center>
<table cellpadding=4 cellspacing=0 border=0>
<tr>
	<td colspan=4 align=center bgcolor="#800000"><font size=4 color="#ffffff">
	<%=MonthName(m)%>,
	<%=y%>
	(<%=Request.QueryString("event_context")%>)
	</font></td>
<tr>
	<td align=center bgcolor="#c0c0c0">Day</td>
	<td align=center bgcolor="#c0c0c0">Start</td>
	<td align=center bgcolor="#c0c0c0">Event</td>
	<td align=center bgcolor="#c0c0c0">End</td>
	
<% Do While Not rs.EOF %>
<tr>
	<td
<% if CDbl(Request.QueryString("day")) = Day(rs("event_start")) then %>
	bgcolor="#ffffbb"
<% end if %>
	align=right><font face="arial" size=2>
	<%=Day(rs("event_start"))%></font></td>

	<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>
	<%=Left(Right(rs("event_start"),11),5) & " " & Right(rs("event_start"),2)%>
	</font></td>
	
	<td
<% if CDbl(Request.QueryString("day")) = Day(rs("event_start")) then %>
	bgcolor="#ffffbb"
<% end if %>
	>
	<a href="cal_event.asp?event_id=<%=rs("event_id")%>">
	<%=rs("event_title")%></a></td>
	
	<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>
	<%=Left(Right(rs("event_end"),11),5) & " " & Right(rs("event_end"),2)%>
	</font></td>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

</table>
<p>
<table border=0 cellpadding=0 cellspacing=0 width=300>
<tr>
	<td align=left>
	<a href="cal_list.asp?event_context=<%=Request.QueryString("event_context")%>
		&year=<%= yprev %>
		&month=<%= mprev %>
		&day=0">
	<img src="../graphics/cal_left.jpg" border=0></a></td>

	<form action="cal.asp" method="post">
	<td align=center>
	<input type="hidden" name="month" value="<%=m%>">
	<input type="hidden" name="year" value="<%=y%>">
	<input type="hidden" name="event_context" value="<%= Request.QueryString("event_context") %>">
	<input type=image src="../graphics/cal_cal.jpg" border=0></td>
	</td></form>



	<td align=right>
	<a href="cal_list.asp?event_context=<%=Request.QueryString("event_context")%>
		&year=<%= ynext %>
		&month=<%= mnext %>
		&day=0">
	<img src="../graphics/cal_right.jpg" border=0></a></td>
</table>

<!-- ADD BUTTON -->

<% if Not Session("user") = "guest" then %>
<p>
<a href="cal_edit.asp?action=add&event_context=<%=Request.QueryString("event_context")%>&year=<%=y%>&month=<%=m%>">
<img src="../graphics/button_add.jpg" border=0>
</a>
<% end if %>

<!-- END BUTTON -->

</center>
</body>
</html>