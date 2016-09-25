<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/15/97
-->

<%
query = "SELECT name_first, name_last, email_name, room, type " _
	& "FROM employee WHERE type='faculty' ORDER BY name_last"
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)
%>

<table border=0>
<tr>
	<td valign=top>
	<table cellpadding=2 border=0 cellspacing=0>
	<tr>
		<td colspan=2 align="center" bgcolor="#800000"><font color="#ffffff">
		Faculty</font></td>
<% Do While Not rs.EOF %>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>
		<%=rs("room")%></font></td>
		<td><font size=2>
		<a href="./employee/detail.asp?email_name=<%=rs("email_name")%>">
		<%=rs("name_first") & " " & rs("name_last")%></a></font></td>

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
		<td colspan=2 align="center" bgcolor="#800000"><font color="#ffffff">
		Staff</font></td>
<% Do While Not rs.EOF %>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>
		<%=rs("room")%></font></td>
		<td><font size=2>
		<a href="./employee/detail.asp?email_name=<%=rs("email_name")%>">
		<%=rs("name_first") & " " & rs("name_last")%></a></font></td>
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
		<td colspan=2 align="center" bgcolor="#800000"><font color="#ffffff">
		Other Rooms</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>31</font></td>
		<td><font size=2>Classroom 1</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>35</font></td>
		<td><font size=2>Classroom 3</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>19</font></td>
		<td><font size=2>Computer Lab</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>22</font></td>
		<td><font size=2>Compressed Video</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>31</font></td>
		<td><font size=2>Classroom 1</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>32</font></td>
		<td><font size=2>Coffee Room</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>33</font></td>
		<td><font size=2>Copy Room</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>23</font></td>
		<td><font size=2>Swing Office</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>20</font></td>
		<td><font size=2>Video Lab</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>42</font></td>
		<td><font size=2>Video Production</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>12</font></td>
		<td><font size=2>E.E. Students</font></td>
	<tr>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>13</font></td>
		<td><font size=2>M.E. Students</font></td>

	</table>
	</td>
</table>
