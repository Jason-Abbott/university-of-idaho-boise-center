<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 6/10/98
-->

<%
' custom calendar for Cooperative Extension System

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT * FROM ext_cal_events E INNER JOIN ext_cal_context C" _
	& " ON (E.event_context = C.id) " _
	& " WHERE (event_id)=" & Request.QueryString("event_id")
Set rs = db.Execute(query)
%>

<!--#include virtual="/header_start.inc"-->
	<%=rs("name")%> Calendar:
	<%=MonthName(Month(rs("event_start"))) & " "%>
	<%=Day(rs("event_start")) & ", "%>
	<%=Year(rs("event_start"))%>

	</td>
	<td align=right>
	
<!-- buttons -->
<% if session("ext") <> "" then %>
<a href="ext_cal_edit.asp?action=update&event_id=<%=rs("event_id")%>">
<img src="/graphics/button_edit.gif" border=0>
</a>

<a href="ext_cal_del.asp?event_id=<%=rs("event_id")%>">
<img src="/graphics/button_del.gif" border=0>
</a>
<% end if %>

<!-- end buttons -->

<!--#include virtual="/header_end.inc"-->

<center>
<table border=0 cellspacing=0 cellpadding=3 width=300>
<tr>
	<td align=center colspan=2>
	<font size=5><%=rs("event_title")%></font></td>
<tr>
	<td align=center colspan=2>
	<font size=4><%=rs("event_location")%></font></td>
<tr>
	<td colspan=2><%=rs("event_description")%></td>
<tr>
	<td align=center <%=light%>>
	<font face="arial"><b>Start</b></font></td>
	<td align=center <%=light%>>
	<font face="arial"><b>End</b></font></td>
<tr>
	<td align=center><%= Right(rs("event_start"),11)%></td>
	<td align=center><%=Right(rs("event_end"),11)%></td>
<tr>
	<td align=center colspan=2 <%=light%>>
	<font face="arial" size=2><b>Updated</b></font></td>
<tr>
	<td align=center colspan=2><font size=2>on <%=rs("update_time")%><br>
	by <%=rs("update_machine")%></font></td>
</table>
<%
rs.Close
db.Close
%>
</center>

<!--#include virtual="/footer.inc"-->