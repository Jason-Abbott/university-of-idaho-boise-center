<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/16/97
-->

<HTML>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<!--#include file="../authenticate.inc"-->
<%
dim query

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

query = "SELECT name_last, name_first, email_name, ip " _
	& "FROM employee ORDER BY name_last"

Set rs = db.Execute(query)
%>

<center>
<table border=0 cellspacing=0 cellpadding=2 width=50>
<tr>
	<td colspan=2 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">
	<b>HelpDesk Request</b></font></td>
<tr>
	<form action="help_added.asp" method="post">
	<td align=right bgcolor="#c0c0c0">
	<font face="arial" size=2>Name</font></td>
	<td bgcolor="#c0c0c0"><select name="submitter">
	<option>(not listed here)*

<% Do While Not rs.EOF %>

	<option value="<%=rs("email_name")%>"<% if rs("email_name") = Session("user") then %> selected<% end if %>><%=rs("name_first") & " " & rs("name_last")%>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

	</select>
	</td>
<tr>
	<td align=right bgcolor="#c0c0c0">
	<font face="arial" size=2>Problem with</font></td>
	<td bgcolor="#c0c0c0"><select name="category">

<!--#include file="help_categories.inc"-->

	</select></td>
<tr>
	<td colspan=2 align=center bgcolor="#c0c0c0">
	<font face="arial" size=2>Description</font></td>
<tr>
	<td colspan=2 align=center bgcolor="#c0c0c0">
	<textarea name="description" cols=40 rows=4></textarea></td>
<tr>
	<td colspan=2 align=center bgcolor="#c0c0c0">
	<input type="submit" value="Send Request"></td>
	</form>
<tr>
	<td colspan=2 align=center><font size=2>
	*If you would like to request help but your name is not listed here you will first need to add yourself to the database of Boise Center employees.  You can start that process from here by selecting whether you are <a href="./employee/edit.asp?action=add&type=staff">staff</a> or <a href="./employee/edit.asp?action=add&type=faculty">faculty</a>.
	</td>	
</table>
</center>
</body>
</html>