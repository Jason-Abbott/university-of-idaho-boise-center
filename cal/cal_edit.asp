<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/11/97
-->

<!--#include file="../authenticate.inc"-->
<%
if Session("User") = "guest" then response.redirect "cal_denied.asp"

dim form, fill, e_day, e_month, e_year
dim e_start, e_start_apm, e_end, e_end_apm

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

if Request.QueryString("action") = "add" then
   fill = 0
	if Request.QueryString("day") = 0 then
		e_day = 1
	else
		e_day = CDbl(Request.QueryString("day"))
	end if
	e_month = CDbl(Request.QueryString("month"))
	e_year = CDbl(Request.QueryString("year"))
	e_start = "8:00"
	e_end = "5:00"
	e_start_apm = "AM"
	e_end_apm = "PM"
	e_context = Request.QueryString("event_context")
else
   fill = 1

query = "SELECT * FROM cal_events" _
	& " WHERE (event_id)=" & Request.QueryString("event_id")
	Set rs = db.Execute(query)
		
	e_day = Day(rs("event_start"))
	e_month = Month(rs("event_start"))
	e_year = Year(rs("event_start"))
	if Hour(rs("event_start")) > 12 then
		e_start = Hour(rs("event_start")) - 12 & ":" & Left(Right(rs("event_start"),8),2)
	else
		e_start = Hour(rs("event_start")) & ":" & Left(Right(rs("event_start"),8),2)
	end if
	e_start_apm = Right(rs("event_start"),2)
	e_end_apm = Right(rs("event_end"),2)
	if Hour(rs("event_end")) > 12 then
		e_end = Hour(rs("event_end")) - 12 & ":" & Left(Right(rs("event_end"),8),2)
	else
		e_end = Hour(rs("event_end")) & ":" & Left(Right(rs("event_end"),8),2)
	end if
	e_context = rs("event_context")
end if
%>

<html>
<body link="#E4C721" vlink="#E4C721" alink="#E4C721" bgcolor="#FFFFFF">
<center>
<table border=0 cellspacing=0 cellpadding=2>
<tr>
	<td align=center><font face="arial" size=4><b>Event</b></font></td>
<form method="post" action="cal_edited.asp">
<input type="hidden" name="action" value="<%=Request.QueryString("action")%>">
<% if fill = 1 then %>
<input type="hidden" name="old_context" value="<%=rs("event_context")%>">
<input type="hidden" name="old_title" value="<%=rs("event_title")%>">
<input type="hidden" name="old_start" value="<%=rs("event_start")%>">
<% end if %>

	<td align=center bgcolor="#80000" colspan=2><font color="#ffffff">

	<select name="month">
<%
for m = 1 to 12
	response.write "<option value='" & m & "'"
	if m = e_month then response.write " selected"
	response.write ">" & MonthName(m)
next
%>
	</select>
	<select name="day">
<%
for d = 1 to 31
	response.write "<option"
	if d = e_day then response.write " selected"
	response.write ">" & d
next
%>
	</select>, 
	<select name="year">
<%
for y = e_year - 1 to e_year + 1
	response.write "<option"
 	if y = e_year then response.write " selected"
	response.write ">" & y
next
%>
	</select>
	</font></td>
<tr>
	<td align="RIGHT" bgcolor="#80000">
	<font face="arial" color="#ffffff" size=2>Title</font></td>
	<td bgcolor="#C0C0C0" colspan=2>
	<input type="text" name="event_title"<%if fill=1 then%>value="<%=rs("event_title")%>" <%end if%>size=45>
	</td>
<tr>
	<td align=right bgcolor="#80000" valign=top>
	<font face="arial" color="#ffffff" size=2>Description</font></td>
	<td bgcolor="#C0C0C0" colspan=2>
	<textarea name="event_description" cols=40 rows=5><%if fill=1 then%><%=rs("event_description")%><%end if%></textarea>
	</td>
<tr>
	<td align=right bgcolor="#80000" valign=top>
	<font face="arial" color="#ffffff" size=2>Start Time</font></td>
	<td bgcolor="#C0C0C0" colspan=2><font face="arial" size=2>
	<select name="event_start">
<%
for t = 1 to 12
	response.write "<option"
	if e_start = t & ":00" then response.write " selected"
	response.write ">" & t & ":00<option"
	if e_start = t & ":30" then response.write " selected"
	response.write ">" & t & ":30"
next
%>
	</select>
	<input type="radio" name="s_apm" value="am"
	<%if e_start_apm = "AM" then %> checked<%end if%>>AM
	<input type="radio" name="s_apm" value="pm"
	<%if e_start_apm = "PM" then %> checked<%end if%>>PM
	</font></td>
<tr>
	<td align=right bgcolor="#80000" valign=top>
	<font face="arial" color="#ffffff" size=2>End Time</font></td>
	<td bgcolor="#C0C0C0" colspan=2><font face="arial" size=2>
	<select name="event_end">
<%
for t = 1 to 12
	response.write "<option"
	if e_end = t & ":00" then response.write " selected"
	response.write ">" & t & ":00<option"
	if e_end = t & ":30" then response.write " selected"
	response.write ">" & t & ":30"
next
%>
	</select>
	<input type="radio" name="e_apm" value="am"
	<%if e_end_apm = "AM" then %> checked<%end if%>>AM
	<input type="radio" name="e_apm" value="pm"
	<%if e_end_apm = "PM" then %> checked<%end if%>>PM
	</font></td>
<tr>
	<td align=right bgcolor="#80000" valign=top>
	<font face="arial" color="#ffffff" size=2>Calendar</font></td>
	<td bgcolor="#C0C0C0">
	<select name="event_context">
<%
if fill = 1 then rs.close
Set rs = db.Execute("SELECT name FROM cal_context ORDER BY name")
do while not rs.EOF
	response.write "<option"
	if rs("name") = e_context then response.write " selected"
	response.write ">" & rs("name")
	rs.movenext
loop
rs.close
db.close
%>
	</select>
	</td>
	<td align=right bgcolor="#C0C0C0">
	<input type="submit" value="<%=Request.QueryString("action")%>"></td>
</table>
</form>
</center>
</body>
</html>