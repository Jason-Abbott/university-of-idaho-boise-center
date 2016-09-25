<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 11/12/98
-->

<!--#include virtual="/header_start.inc"-->
Boise Center HelpDesk Listing
<!--#include virtual="/header_end.inc"-->

<%
dim combine, query, join, count
combine = ""

' combine form elements in SQL

if Request.Form("email_name") <> "(list all)" then
	query = "H.submitter ='" & Request.Form("email_name") & "'"
	combine = " AND "
end if

if Request.Form("category") <> "(list all)" then
	query = query & combine & "H.category = '" & Request.Form("category") & "'"
	combine = " AND "
end if

if Request.Form("weeks") <> "" then
	query = query & combine & "(H.submit_time BETWEEN #" _
		& DateAdd("ww", -Request.Form("weeks"), now) & "# AND #" & now & "# OR " _
		& "H.complete_time BETWEEN #" _
		& DateAdd("ww", -Request.Form("weeks"), now) & "# AND #" & now & "#)"
	combine = " AND "
end if

' Do an SQL IN list for the status.  These are combined with commas.

query = query & combine & "H.status IN ("

if Request.Form("open") = "on" then
   query = query & "'open'"
   combine = ", "
end if

if Request.Form("pending") = "on" then
   query = query & combine & "'pending'"
   combine = ", "
end if

if Request.Form("closed") = "on" then
   query = query & combine & "'closed'"
end if

query = query & ")"
combine = " AND "

' Do a wildcard match with entered description against DB description

if Request.Form("description") <> "" then
	query = query & combine & "H.description LIKE '%%" & Request.Form("description") & "%%'"
end if

' link the helpdesk to the employee database
' The left join includes all records from helpdesk
' and only those employees in helpdesk.  Use a union
' join to restrict further.

join = "SELECT * FROM helpdesk H LEFT JOIN employee E " _
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

' response.write query

if rs.EOF = -1 then
%>

<!-- IF NO RECORDS ARE FOUND -->

<font size="5">N</font>o HelpDesk entries match the criteria you entered.  Please try your <a href="help_search.asp">search again</a>.

<%else%>

<!-- LIST REQUESTS -->

<center>
<font face="arial" size=2>
New requests are in <i>italics</i><br>
Click on the request number to see more detail</font>

<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000" bordercolordark="#000000">

<%
count = 1
Do While Not rs.EOF
	description = rs("description")
%>

<tr>
	<td <%=light%>>
	<table width="100%" cellspacing="2" cellpadding="1">
	<tr>
		<form method="post" action='help_detail.asp?id=<%=rs("id")%>'>
		<td><font face="arial" size=2><input type="submit" value="<%=count%>"><b>
		<% if rs("status") = "open" then %><i><% end if %>
		
<% if rs("hname_first") <> "" then %>
	<a href="mailto:<%=rs("submitter")%>@<%=rs("hemail_site")%>">
	<%=rs("hname_first") & "&nbsp;" & rs("hname_last")%></a>
<% else %>
	<a href="/employee/detail.asp?email_name=<%=rs("email_name")%>">
	<%=rs("name_first") & "&nbsp;" & rs("name_last")%></a>
<% end if %>

		</b></td></form>
		<td align="right"><font face="arial" size=2>
		<% if rs("status") = "open" then %><i><% end if %>
		<%=rs("submit_time")%></font></td>

<% if description <> "" then %>
	<tr>
		<td colspan=2>
		<font face="arial" size=1><%=description%></font></td>
<% end if %>

<%
if rs("due") <> "" AND rs("status") <> "closed" then
	days = DateDiff("d", Now(), rs("due"))
%>
	<tr>
		<td colspan=2 align="right" <%=light%>><font face="arial" size=2 color="#ff0000">
		Complete by <%=WeekDayName(WeekDay(rs("due")))%>,
		<%=MonthName(Month(rs("due")))%>&nbsp;<%=Day(rs("due"))%>, 
		<%=Year(rs("due"))%>
		(in <%=days%> days)
		</font></font>
<%
	end if
	response.write "</td></table></td>"
	rs.MoveNext
	count = count + 1
Loop
end if
rs.Close
db.Close
%>

</table>
</center>

<!--#include virtual="/footer.inc"-->