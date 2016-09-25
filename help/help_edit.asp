<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/27/99
-->

<!--#include virtual="/header_start.inc"-->
Boise Center HelpDesk Update
<!--#include virtual="/header_end.inc"-->

<%
dim query, bc, rs, description, comments, name_first, name_last, email_name, email_site, link

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

query = "SELECT * FROM helpdesk H LEFT JOIN employee E " _
	& "ON (H.submitter = E.email_name) " _
	& "WHERE (id)=" & Request.QueryString("id")

Set rs = db.Execute(query)

if rs("hname_first") <> "" then
	name_first = rs("hname_first")
	name_last = rs("hname_last")
	email_name = rs("submitter")
	email_site = rs("hemail_site")
	link = "mailto:" & email_name & "@" & email_site
else
	name_first = rs("name_first")
	name_last = rs("name_last")
	email_name = rs("email_name")
	email_site = rs("email_site")
	link = "/employee/detail.asp?email_name=" & email_name
end if

description = rs("description")
comments = rs("comments")
%>

<center>
<table cellpadding="4" cellspacing="0" border="0" width="80%">
<tr>
	<td align="center" <%=light%>>
	<font face="arial"><b>by</b></font></td>
	<td align="center" <%=light%>>
	<font face="arial"><b>on</b></font></td>
	<td align="center" <%=light%>>
	<font face="arial"><b>category</b></font></td>
<tr>
	<form action="help_updated.asp" method=post>
	<td align="center" bgcolor="#c0c0c0"><font size=2>
	<a href="<%=link%>">
	<%=name_first & "&nbsp;" & name_last%></a></font></td>

	<td align=center bgcolor="#c0c0c0">
	<font face="arial narrow" size=2><%=rs("submit_time")%></font></td>

	<td align=center bgcolor="#c0c0c0">
	<font size=2><%=rs("category")%></font></td>

<% if description <> "" then %>
<tr>

	<td bgcolor="#c0c0c0">&nbsp;</td>
	<td colspan=2 valign=top bgcolor="#c0c0c0"><font face="arial" size=1>
	<%=description%></font></td>

<% end if %>

<input type="hidden" name="id" value='<%=rs("id")%>'>
<input type="hidden" name="submitter_first" value='<%=name_first%>'>
<input type="hidden" name="submitter_last" value='<%=name_last%>'>
<input type="hidden" name="submitter_email_name" value='<%=email_name%>'>
<input type="hidden" name="submitter_email_site" value='<%=email_site%>'>
<input type="hidden" name="category" value='<%=rs("category")%>'>
<input type="hidden" name="description" value='<%=description%>'>
<input type="hidden" name="submit_time" value='<%=rs("submit_time")%>'>

<tr>
	<td colspan=3 bgcolor="#c0c0c0"><hr>

<% if comments <> "" then %>

	<font face="arial" size=1>Existing Comments</font><br>
	<textarea cols="50" rows="4" wrap="virtual"><%=comments%></textarea>
	<input type="hidden" name="comments_old" value='<%=comments%>'>
	<br>
	
<% end if %>

	<font face="arial" size=1>New Comment</font><br>
	<textarea name="comments_new" cols="50" rows="8" wrap="virtual"></textarea>
	<br>
	<font face="arial" size=1>by</font>
	<select name="technician">
	
<%
rs.Close

query = "SELECT name_first, name_last, email_name FROM employee " _
	& "WHERE email_name IN (" & Session("technicians") & ") " _
	& "ORDER BY name_last"
Set rs = db.Execute(query)
Do While Not rs.EOF
%>

<option value="<%=rs("email_name")%>"<% if rs("email_name") = Session("user") then %> selected<% end if %>><%=rs("name_first") & " " & rs("name_last")%>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

	</select>
	<hr>
	<input type="checkbox" name="close"><font face="arial" size=2>This request is now closed<br>
	It took <input type="text" name="time_spent" size=5> (required) hours to complete
	<hr>
	</td>
<tr>
	<td colspan=3 bgcolor="#c0c0c0" align="right"><input type="submit" value="update"></td>
</form>
</table>
</center>

<!--#include virtual="/footer.inc"-->