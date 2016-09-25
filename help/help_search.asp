<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/16/97
-->

<HTML>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<!--#include file="../authenticate.inc"-->
<%
dim db, rs, query

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

query = "SELECT name_last, name_first, email_name, ip " _
	& "FROM employee ORDER BY name_last"

Set rs = db.Execute(query)
%>

<center>
<table border=0 cellspacing=0 cellpadding=2 width=300>
<tr>
	<td colspan=2 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">
	<b>HelpDesk Search</b></font></td>
<tr>
	<td colspan=2 bgcolor="#c0c0c0"><font face="arial" size=2>
	<b>Quick Search:</b>
	</font></td>
<tr>
	<form action="help_list.asp" method="post">
	<td colspan=2 align=center bgcolor="#c0c0c0">
	<input type="submit" value="List all open requests">
	<hr>
	</td>
	<input type="hidden" name="email_name" value="(list all)">
	<input type="hidden" name="category" value="(list all)">
	<input type="hidden" name="open" value="on">
	</form>
<tr>
	<td colspan=2 bgcolor="#c0c0c0"><font face="arial" size=2>
	<b>Detailed Search:</b>
	</font></td>
<tr>
	<form action="help_list.asp" method="post">
	<td align=right bgcolor="#c0c0c0" valign=top>
	<font face="arial" size=2>Name</font></td>
	<td bgcolor="#c0c0c0" valign=top><select name="email_name">
	<option>(list all)

<% Do While Not rs.EOF %>

	<option value="<%=rs("email_name")%>"<% if Session("user") = rs("email_name") then %> selected<% end if %>><%=rs("name_first") & " " & rs("name_last")%>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

	</select><br>
	<font face="arial" size=1>Who submitted the request?<p></font>
	</td>
<tr>
	<td align=right bgcolor="#c0c0c0" valign=top>
	<font face="arial" size=2>Problem with</font></td>
	<td bgcolor="#c0c0c0" valign=top><select name="category">
	<option>(list all)

<!--#include file="help_categories.inc"-->

	</select><br>
	<font face="arial" size=1>How was it categorized?<p></font></td>
<tr>
	<td align=right bgcolor="#c0c0c0" valign=top>
	<font face="arial" size=2>Description</font></td>
	<td bgcolor="#c0c0c0" valign=top>
	<input type="text" name="description"><br>
	<font face="arial" size=1>What key word was used to describe it?<p></font></td>
<tr>
	<td align=right bgcolor="#c0c0c0" valign=top>
	<font face="arial" size=2>Status</font></td>
	<td bgcolor="#c0c0c0" valign=top><font face="arial" size=2>
	<input type="checkbox" name="open" checked>Open
	<input type="checkbox" name="closed" checked>Closed
	</font><br>
	<font face="arial" size=1>What is the status?</font></td>
<tr>
	<td colspan=2 align=right bgcolor="#c0c0c0">
	<input type="submit" value="Find"></td>
	</form>
</table>
</center>

</body>
</html>