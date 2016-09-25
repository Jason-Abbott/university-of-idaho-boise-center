<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/29/99
-->

<!--#include virtual="/header_start.inc"-->
Boise Center HelpDesk Detail
<!--#include virtual="/header_end.inc"-->

<%
dim query, bc, rs, days, description, comments, name_first, name_last, email_name, email_site, link

' determine whether the person viewing the page should
' be able to modify database values

if InStr(Session("technicians"), Session("user")) > 0 then
	technician = 1
end if

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

<% if technician = 1 then %>

<form action="help_updated.asp" method=post>
<tr>
   <td align="right" <%=light%>><font face="arial"><b>New<br>Comments</b></font></td>
   <td bgcolor="#c0c0c0">
   <textarea name="comments_new" cols="40" rows="7" wrap="virtual"></textarea></td>
<tr>
   <td align="right" <%=light%>><font face="arial"><b>Technician</b></font></td>
   <td bgcolor="#c0c0c0">
	<select name="technician">
	
<%
	query = "SELECT name_first, name_last, email_name FROM employee " _
		& "WHERE email_name IN (" & Session("technicians") & ") " _
		& "ORDER BY name_last"
	Set rs2 = db.Execute(query)
	Do While Not rs2.EOF
%>

	<option value="<%=rs2("email_name")%>"<% if rs2("email_name") = Session("user") then %> selected<% end if %>><%=rs2("name_first") & " " & rs2("name_last")%>

<%
	rs2.MoveNext
	Loop
%>
	</select></td>
<tr>
   <td align="right" <%=light%>><font face="arial"><b>Status</b></font></td>
   <td bgcolor="#c0c0c0">
	<input type="checkbox" name="close"><font face="arial" size=2>This request is now closed<br>
	It took <input type="text" name="time_spent" size=5> (required) hours to complete
	</td>
		
<input type="hidden" name="id" value='<%=rs("id")%>'>
<input type="hidden" name="submitter_first" value='<%=name_first%>'>
<input type="hidden" name="submitter_last" value='<%=name_last%>'>
<input type="hidden" name="submitter_email_name" value='<%=email_name%>'>
<input type="hidden" name="submitter_email_site" value='<%=email_site%>'>
<input type="hidden" name="category" value='<%=rs("category")%>'>
<input type="hidden" name="description" value='<%=description%>'>
<input type="hidden" name="submit_time" value='<%=rs("submit_time")%>'>
<tr>
	<td colspan=2 align="right"><input type="submit" value="update"></td>

<% else %>
	<form>
<% end if %>

<tr>
       <td align="right" <%=light%>><font face="arial"><b>From</b></font></td>
       <td bgcolor="#c0c0c0">
       <a href="<%=link%>">
       <%=name_first & "&nbsp;" & name_last%></a></td>

<% if rs("hname_first") <> "" then %>

<tr>
       <td align="right" <%=light%>><font face="arial"><b>Phone</b></font></td>
       <td bgcolor="#c0c0c0"><%=rs("hphone")%></td>

<% end if%>

<tr>
	<td align="right" <%=light%>><font face="arial"><b>Submitted</b></font></td>
	<td bgcolor="#c0c0c0"><%=WeekDayName(WeekDay(rs("submit_time")))%>,
	<%=MonthName(Month(rs("submit_time")))%>&nbsp;<%=Day(rs("submit_time"))%>, 
	<%=Year(rs("submit_time"))%></td>
<tr>
       <td align="right" <%=light%>><font face="arial"><b>Status</b></font></td>    
       <td bgcolor="#c0c0c0"><%=rs("status")%></td>

<% if rs("due") <> "" AND rs("status") <> "closed" then
		days = DateDiff("d", Now(), rs("due"))
%>

<tr>
   <td align="right" <%=light%>><font face="arial"><b>Due</b></font></td> 
   <td bgcolor="#c0c0c0"><%=WeekDayName(WeekDay(rs("due")))%>,
	<%=MonthName(Month(rs("due")))%>&nbsp;<%=Day(rs("due"))%>, 
	<%=Year(rs("due"))%>	(in <%=days%> days)
   </td>

<% end if %>
	
<tr>
       <td align="right" <%=light%>><font face="arial"><b>Category</b></font></td>    
       <td bgcolor="#c0c0c0"><%=rs("category")%></td>

<% if description <> "" then %>

<tr>
       <td align="right" <%=light%>><font face="arial"><b>Description</b></font></td>
       <td bgcolor="#c0c0c0">
       <textarea cols="40" rows="5" wrap="virtual"><%=description%></textarea></td>

<%
end if
if comments <> "" then
%>

<tr>
   <td align="right" <%=light%>><font face="arial"><b>Comments</b></font></td>
   <td bgcolor="#c0c0c0">
   <textarea cols="40" rows="15" wrap="virtual"><%=comments%></textarea></td>
	<input type="hidden" name="comments_old" value='<%=comments%>'>
	
<%
end if
db.Close
if technician <> 1 then
%>

<tr>
   <td <%=light%>>&nbsp;</td>
   <td bgcolor="#c0c0c0"><font face="arial" size=2>
   If you have any questions, comments or concerns about this information please send e-mail to <a href="mailto:help@borah.engboi.uidaho.edu">help@borah.engboi.uidaho.edu</a>.
   </td>

<% end if %>

</form>
</table>
</center>

<!--#include virtual="/footer.inc"-->