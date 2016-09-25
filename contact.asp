<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/15/97
-->

<HTML>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<table cellpadding=4>
<tr>
	<td align=right><font face="arial"><b>Mailing address</b></font></td>
	<td>800 Park Boulevard, Suite 200<br>Boise, Idaho  83712
<tr>
	<td align=right><font face="arial"><b>Telephone</b></font></td>
	<td>(208) 334-2999</td>
<tr>
	<td align=right><font face="arial"><b>FAX</b></font></td>
	<td>(208) 364-4035</td>
<tr>
	<td align=right><font face="arial"><b>e-mail</b></font></td>
	<td><a href="mailto:kittyw@uidaho.edu">kittyw@uidaho.edu</td>
<tr>
	<td align=right><font face="arial"><b>web</b></font></td>
	<td><a href="http://boise.uidaho.edu" target=_top>http://boise.uidaho.edu</a></td>
</table>
<p>
If you have questions about these web pages you can contact <a href="http://www.uidaho.edu/~jabbott" target=_top>Jason Abbott</a> at <a href="mailto:jabbott@uidaho.edu">jabbott@uidaho.edu</a>.
<p>
<%
query = "SELECT name_first, name_last, email_name, phone, type " _
	& "FROM employee WHERE type='faculty' ORDER BY name_last"
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)
%>
<center>
The prefix for all numbers is 364.
<table border=0>
<tr>
	<td valign=top>
	<table cellpadding=2 border=0 cellspacing=0>
	<tr>
		<td colspan=2 align="center" bgcolor="#800000"><font color="#ffffff">
		Faculty</font></td>
<% Do While Not rs.EOF %>
	<tr>
		<td align=right><font size=2>
		<a href="./employee/detail.asp?email_name=<%=rs("email_name")%>">
		<%=rs("name_first") & " " & rs("name_last")%></a></font></td>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>
		<%=rs("phone")%></font></td>

<%
rs.MoveNext
Loop
rs.Close
%>
	</table>
	</td>
<%
query = "SELECT name_first, name_last, email_name, phone, type " _
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
		<td align=right><font size=2>
		<a href="./employee/detail.asp?email_name=<%=rs("email_name")%>">
		<%=rs("name_first") & " " & rs("name_last")%></a></font></td>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>
		<%=rs("phone")%></font></td>
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
		Other Numbers</font></td>
	<tr>
		<td align=right><font size=2>Classroom 1</font></td>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>4011</font></td>
	<tr>
		<td align=right><font size=2>Classroom 3</font></td>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>4053</font></td>
	<tr>
		<td align=right><font size=2>Computer Lab</font></td>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>4009</font></td>
	<tr>
		<td align=right><font size=2>Copy Room</font></td>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>4034</font></td>
	<tr>
		<td align=right><font size=2>Video Lab</font></td>
		<td align=right bgcolor="#c0c0c0"><font face="arial" size=2>4052</font></td>
	</table>
	</td>
</table>
</center>
</BODY>
</HTML>
