<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 02/04/99
-->

This depicts the second floor of Morrison Knudsen Plaza IV, where the majority of our rooms are.  We do, however, have a few rooms in the northeast corner of the seventh floor, listed here simply as "7th."

<%
query = "SELECT name_first, name_last, email_name, room, type " _
	& "FROM employee WHERE type='faculty' ORDER BY name_last"
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)
%>

<center>
<table border=0>
<tr>
	<td valign=top>
	<table cellpadding=2 border=0 cellspacing=0>
	<tr>
		<td colspan=2 align="center"><font face="arial" size=2><b>Faculty</b></font></td>
<% Do While Not rs.EOF %>
	<tr>
		<td align=right><font face="arial" size=2>
		<%=rs("room")%></font></td>
		<td <%=light%>><font size=2>
		<a href="/employee/detail.asp?email_name=<%=rs("email_name")%>">
		<%=rs("name_last") & ", " & rs("name_first")%></a></font></td>

<%
	rs.MoveNext
Loop
rs.Close
%>
	</table>
	</td>
<%
query = "SELECT name_first, name_last, email_name, room, type " _
	& "FROM employee WHERE type='staff' ORDER BY name_last"
Set rs = db.Execute(query)
%>
	<td valign=top>
	<table cellpadding=2 border=0 cellspacing=0>
	<tr>
		<td colspan=2 align="center"><font face="arial" size=2><b>Staff</b></font></td>
<% Do While Not rs.EOF %>
	<tr>
		<td align=right><font face="arial" size=2>
		<%=rs("room")%></font></td>
		<td <%=light%>><font size=2>
		<a href="/employee/detail.asp?email_name=<%=rs("email_name")%>">
		<%=rs("name_last") & ", " & rs("name_first")%></a></font></td>
<%
	rs.MoveNext
Loop
rs.Close
db.Close
%>
	</table>
	</td>
	<td valign=top>
	<table cellpadding=2 border=0 cellspacing=0>
	<tr>
		<td colspan=2 align="center"><font face="arial" size=2><b>Other Rooms</b></font></td>
	<tr>
		<td align=right><font face="arial" size=2>31</font></td>
		<td <%=light%>>
		<font size=2>Classroom 1</font></td>
	<tr>
		<td align=right><font face="arial" size=2>35</font></td>
		<td <%=light%>>
		<font size=2><a href="/rooms/classroom3.asp">Classroom 3</a></font></td>
	<tr>
		<td align=right><font face="arial" size=2>19</font></td>
		<td <%=light%>>
		<font size=2><a href="/lab/lab_intro.asp">Computer Lab</a></font></td>
	<tr>
		<td align=right><font face="arial" size=2>22</font></td>
		<td <%=light%>>
		<font size=2><a href="/rooms/conference.asp">Compressed Video</a></font></td>
	<tr>
		<td align=right><font face="arial" size=2>31</font></td>
		<td <%=light%>>
		<font size=2>Classroom 1</font></td>
	<tr>
		<td align=right><font face="arial" size=2>32</font></td>
		<td <%=light%>>
		<font size=2>Coffee Room</font></td>
	<tr>
		<td align=right><font face="arial" size=2>33</font></td>
		<td <%=light%>>
		<font size=2>Copy Room</font></td>
	<tr>
		<td align=right><font face="arial" size=2>23</font></td>
		<td <%=light%>>
		<font size=2>Swing Office</font></td>
	<tr>
		<td align=right><font face="arial" size=2>20</font></td>
		<td <%=light%>>
		<font size=2>Video Lab</font></td>
	<tr>
		<td align=right><font face="arial" size=2>42</font></td>
		<td <%=light%>>
		<font size=2>Video Production</font></td>
	<tr>
		<td align=right><font face="arial" size=2>7th</font></td>
		<td <%=light%>>
		<font size=2>E.E. Students</font></td>
	<tr>
		<td align=right><font face="arial" size=2>7th</font></td>
		<td <%=light%>>
		<font size=2>M.E. Students</font></td>

	</table>
	</td>
</table>
</center>