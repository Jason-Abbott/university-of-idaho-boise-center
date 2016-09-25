<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 02/11/98
-->

<html>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<!--#include file="../authenticate.inc"-->
<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT * FROM cal_events" _
	& " WHERE (event_id)=" & Request.QueryString("event_id")

Set rs = db.Execute(query)

'uncomment this line to debug SQL:
'response.write query
%>

<center>
<table border=0 cellspacing=0 cellpadding=3 width=300>
<tr>
	<td align=center bgcolor="#800000" colspan=2><font size=5 color="#ffffff">
	<%=rs("event_title")%></font></td>
<tr>
	<td colspan=2 width=300><pre><%=rs("event_description")%></pre></td>
<tr>
	<td align=center bgcolor="#c0c0c0"><font face="arial">
	<b>Start</b></font></td>
	<td align=center bgcolor="#c0c0c0"><font face="arial">
	<b>End</b></font></td>
<tr>
	<td align=center><%= Right(rs("event_start"),11)%></td>
	<td align=center><%=Right(rs("event_end"),11)%></td>
<tr>
	<td align=center bgcolor="#c0c0c0" colspan=2><font face="arial" size=2>
	<b>Updated</b></font></td>
<tr>
	<td align=center colspan=2><font size=2>on <%=rs("update_time")%><br>
	by <%=rs("update_machine")%></font></td>
</table>

<!-- EDIT BUTTON -->

<% if Not Session("user") = "guest" then %>
<a href="cal_edit.asp?action=update&event_id=<%=rs("event_id")%>">
<img src="../graphics/button_edit.jpg" border=0>
</a>

<!-- DELETE BUTTON -->

<a href="cal_del.asp?event_id=<%=rs("event_id")%>">
<img src="../graphics/button_del.jpg" border=0>
</a>
<% end if %>

<!-- END BUTTONS -->

<%
rs.Close
db.Close
%>
</center>
</body>
</html>