<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 6/9/98

dim error, status

status = "This action is available only to registered users."
error = "The information you entered could not be validated. " _
	& "Please try again."

if Request.Form("username") <> "" then
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open "bc"
	query = "SELECT * FROM ext_employee WHERE email_name = '" _
		& Request.Form("username") & "'"
	Set rs = db.Execute(query)
	if rs.EOF = -1 then
		status = error
	else
		if rs("password") = Request.Form("password") then
			Session("ext") = Request.Form("username")
			response.redirect Session("url") & "?" & Session("query")
		else
			status = error
		end if
	end if
end if
%>

<!--#include virtual="/header_start.inc"-->
Authenticate
<!--#include virtual="/header_end.inc"-->

<%=status%>
<p>
<table>
<tr>
<form action="ext_cal_auth.asp" method="post">
	<td align="right">Username:</td>
	<td><input type="text" name="username"><td>
<tr>
	<td align="right">Password:</td>
	<td><input type="password" name="password"></td>
<tr>
	<td></td>
	<td align="center"><input type="submit" value="Continue"></td>
</form>
</table>


<!--#include virtual="/footer.inc"-->