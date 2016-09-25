<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 05/18/98
-->

<HTML>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<!--#include file="../authenticate.inc"-->
<%
dim query

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

query = "SELECT * FROM helpdesk H INNER JOIN employee E " _
	& "ON (H.submitter = E.email_name) " _
	& "WHERE (id)=" & Request.QueryString("id")

Set rs = db.Execute(query)

description = rs("description")
%>

<center>
<table cellpadding="4" cellspacing="0" border="0" width=350>
<tr>
	<td colspan=3 align=center>
	<font face="arial"><b>Update Help Request</b></font></td>
<tr>
	<td align=center bgcolor="#800000">
	<font face="arial" color="#ffffff"><b>by</b></font></td>
	<td align=center bgcolor="#800000">
	<font face="arial" color="#ffffff"><b>on</b></font></td>
	<td align=center bgcolor="#800000">
	<font face="arial" color="#ffffff"><b>category</b></font></td>
<tr>
	<form action="help_updated.asp" method=post>
	<td align=right bgcolor="#c0c0c0"><font size=2>
	<a href="./employee/detail.asp?email_name=<%=rs("email_name")%>">
	<%=rs("name_first") & "&nbsp;" & rs("name_last")%></a></font></td>

	<td align=center bgcolor="#c0c0c0">
	<font face="arial narrow" size=2><%=rs("submit_time")%></font></td>

	<td align=center bgcolor="#c0c0c0">
	<font size=2><%=rs("category")%></font></td>

<% if Not description = "" then %>
<tr>

	<td bgcolor="#c0c0c0">&nbsp;</td>
	<td colspan=2 valign=top bgcolor="#c0c0c0"><font face="arial" size=1>
	<%=description%></font></td>

<% end if %>

<tr>
	<td colspan=3 bgcolor="#c0c0c0"><hr></td>
<tr>
	<td bgcolor="#c0c0c0" valign=top align=center><font face="arial" size=1>
	Primary Tehcnician<br>
	<select name="technician">
	<option value="jabbott">Jason Abbott
	<option value="haochen">Diane Griffitts
	<option value="ngaley">Norm Galey
	</select>
	<br>
	Time Spent (hours)<br>
	<input type="text" name="time_spent" size=5>
	<p>
	<input type="submit" value="update">
	</font></td>

	<td colspan=2 bgcolor="#c0c0c0" valign=top><font face="arial" size=1>
	Comments</font><br>
	<textarea name="comments" cols=30 rows=4></textarea>
	</td>

<input type="hidden" name="status" value="closed">
<input type="hidden" name="id" value="<%=rs("id")%>">
<input type="hidden" name="submitter_first" value="<%=rs("name_first")%>">
<input type="hidden" name="submitter_last" value="<%=rs("name_last")%>">
<input type="hidden" name="submitter_email_name" value="<%=rs("email_name")%>">
<input type="hidden" name="submitter_email_site" value="<%=rs("email_site")%>">
<input type="hidden" name="category" value="<%=rs("category")%>">
<input type="hidden" name="description" value="<%=description%>">
<input type="hidden" name="submit_time" value="<%=rs("submit_time")%>">
</form>
</table>

<%
rs.Close
db.Close
%>

</center>
</body>
</html>