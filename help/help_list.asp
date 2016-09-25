<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 05/18/98
-->

<html>
<body bgcolor="#FFFFFF" link="#800000" vlink="#800000" alink="#E4C721">

<!--#include file="../authenticate.inc"-->
<%
dim combine, query, join, count
combine = ""

' combine form elements in SQL

if Not Request.Form("email_name") = "(list all)" then
	query = "H.submitter ='" & Request.Form("email_name") & "'"
	combine = " AND "
end if

if Not Request.Form("category") = "(list all)" then
	query = query & combine & "H.category = '" & Request.Form("category") & "'"
	combine = " AND "
end if

' if the values of open and closed are the same, whether
' both checked or not checked, the SQL can skip filtering
' on status altogether

if Not (Request.Form("open") = Request.Form("closed")) then
	if Request.Form("open") = "on" then
		query = query & combine & "H.status = 'open'"
		combine = " AND "
	else
		query = query & combine & "H.status = 'closed'"
		combine = " AND "
	end if
end if

if Not Request.Form("description") = "" then
	query = query & combine & "H.description LIKE '%%" & Request.Form("description") & "%%'"
end if

' link the helpdesk to the employee database

join = "SELECT * FROM helpdesk H INNER JOIN employee E " _
	& "ON (H.submitter = E.email_name)"

' determine if any criteria were entered at all

if query <> "" then
	query = join & " WHERE " & query
else
	query = join
end if

' add sorting information

query = query & " ORDER BY H.submit_time DESC"

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

Set rs = db.Execute(query)

'response.write query

if rs.EOF = -1 then
%>

<!-- IF NO RECORDS ARE FOUND -->

<font size="5">N</font>o HelpDesk entries match the criteria you entered.  Please try your <a href="help_search.asp">search again</a>.

<%else%>

<!-- LIST COURSES -->

<center>
<table cellpadding="1" cellspacing="0" border="0" width=400>
<tr>
	<td>&nbsp;</td>
	<td colspan=4 align=center>
	<font face="arial"><b>Help Requests</b></font></td>
<tr>
	<td>&nbsp;</td>
	<td align=center bgcolor="#800000">
	<font face="arial" color="#ffffff"><b>by</b></font></td>
	<td align=center bgcolor="#800000">
	<font face="arial" color="#ffffff"><b>on</b></font></td>
	<td align=center bgcolor="#800000">
	<font face="arial" color="#ffffff"><b>category</b></font></td>
	<td align=center bgcolor="#800000">
	<font face="arial" color="#ffffff"><b>status</b></font></td>

<%
count = 1
Do While Not rs.EOF
	description = rs("description")
	if count mod 2 <> 0 then
		color = "c0c0c0"
	else
		color = "eeeeee"
	end if
%>

<tr>
	<td rowspan=2 valign=top align=right>
	<font face="arial narrow" size=2><%=count%>)&nbsp;</font></td>
	<td align=right bgcolor="#<%=color%>"><font size=2>
	<a href="./employee/detail.asp?email_name=<%=rs("email_name")%>">
	<%=rs("name_first") & "&nbsp;" & rs("name_last")%></a></font></td>
	<td align=center bgcolor="#<%=color%>">
	<font face="arial narrow" size=2><%=rs("submit_time")%></font></td>
	<td align=center bgcolor="#<%=color%>">
	<font size=2><%=rs("category")%></font></td>
	<td align=center bgcolor="#<%=color%>">

<%	if (Session("user") = "jabbott" OR Session("user") = "dianeg" OR Session("user") = "ngaley") AND Not rs("status") = "closed" then %>

	<a href="help_edit.asp?id=<%=rs("id")%>"><%=rs("status")%></a></td>
	
<% else %>

	<%=rs("status")%></td>
	
<% end if %>

<% if Not description = "" then %>
<tr>

	<td bgcolor="#<%=color%>">&nbsp;</td>
	<td colspan=3 valign=top bgcolor="#<%=color%>"><font face="arial" size=1>
	<%=description%></font></td>
<% end if %>

<% if rs("status") = "closed" then %>
<tr>
	<td>&nbsp;</td>
	<td bgcolor="#<%=color%>">&nbsp;</td>
	<td colspan=3 bgcolor="#<%=color%>"><hr></td>
<tr>
	<td>&nbsp;</td>
	<td bgcolor="#<%=color%>" align=right>
	<font size=2><%=rs("technician")%></font></td>
	<td bgcolor="#<%=color%>" align=center>
	<font face="arial narrow" size=2><%=rs("complete_time")%></font></td>
	<td colspan=2 bgcolor="#<%=color%>">&nbsp;</td>
<tr>
	<td>&nbsp;</td>
	<td bgcolor="#<%=color%>">&nbsp;</td>
	<td colspan=3 bgcolor="#<%=color%>"><font face="arial" size=1>
	<%=rs("comments")%></font>
	</td>
<%
	end if
	rs.MoveNext
	count = count + 1
Loop
end if
rs.Close
db.Close
%>

</table>
</center>
</body>
</html>