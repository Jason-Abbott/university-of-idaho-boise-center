<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 5/12/1999

dim error, status, query, rs

status = "This action is available only to registered users"
error = "The information you entered could not be validated. " _
	& "Please try again."

if Request.Form("id") <> "" then
%>
<!--#include file="data/webNav2_data.inc"-->
<%
	query = "SELECT * FROM users WHERE " _
		& "id = '" & Request.Form("id") & "'"
	Set rs = db.Execute(query,,&H0001)
	if rs.EOF = -1 then
		status = error
	else
		if rs("password") = Request.Form("password") then
			Session("bcNavUser") = Request.Form("id")
			response.redirect Request.Form("url")
		else
			status = error
		end if
	end if
	rs.Close
	db.Close
	Set rs = nothing
	Set db = nothing
end if
%>

<html>
<!--#include file="webNav2_themes.inc"-->
<body bgcolor="#<%=color(1)%>" link="#<%=color(7)%>" vlink="#<%=color(7)%>" alink="#<%=color(6)%>">
<center>

<!-- framing table -->
<table bgcolor="#<%=color(6)%>" width="60%" border=0 cellpadding=3 cellspacing=0><tr><td>
<!-- end framing table -->

<table bgcolor="#<%=color(11)%>" border=0 cellpadding=3 cellspacing=0 width="100%">
<form action="authenticate.asp" method="post">
<tr bgcolor="#<%=color(4)%>" valign="bottom">
	<td colspan=4><font face="Tahoma, Arial, Helvetica" size=4>
	<b>Login</b></font></td>
<tr>
	<td colspan=4 align="center"><font face="Arial, Helvetica" size=2>
	<%=status%><br></font></td>
<tr>
	<td>&nbsp;</td>
	<td bgcolor="#<%=color(12)%>" align="right"><font face="Arial, Helvetica">Username:&nbsp;</td>
	<td bgcolor="#<%=color(12)%>"><input type="text" name="id" size=10 value="guest"></td>
	<td>&nbsp;</td>
<tr>
	<td>&nbsp;</td>
	<td bgcolor="#<%=color(12)%>" align="right"><font face="Arial, Helvetica">Password:&nbsp;</td>
	<td bgcolor="#<%=color(12)%>"><input type="password" name="password" size=10 value="user"></td>
	<td>&nbsp;</td>
<tr>
	<td colspan=4 align="center"><br>
	<input type="submit" value="Continue"></td>

<%
response.write "<input type=""hidden"" name=""url"" value="""
if Request.Form("url") <> "" then
	response.write Request.Form("url")
else
	response.write Request.QueryString("url")
end if
response.write """>"
%>
</form>
</table>

<!-- framing table -->
</td></table>
<!-- end framing table -->

</center>
</body>
</html>