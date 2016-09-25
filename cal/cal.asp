<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/06/98
-->

<html>
<head><title>Boise Center Calendar</title></head>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<!--#include file="../authenticate.inc"-->
<!--#include file="cal_nav.inc"-->
<%
if Request.Form("event_context") = "(New)" then
	response.redirect "cal_new.asp"
end if

dim event_context,FirstDay,DaysInMonth,TheDay,cal,col,row,rows

' Determine values for the month and year to display
' Form values must be converted from strings to numerics

if Request.Form("month") = "" then
	call cal_nav(Month(now),Year(now))
	event_context = "Main"
else
	call cal_nav(CDbl(Request.Form("month")),CDbl(Request.Form("year")))
	event_context = Request.Form("event_context")
end if

' Pull event information from database

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT event_start FROM cal_events WHERE event_context='" & event_context _
	& "' AND event_start BETWEEN #" & m & "/1/" & y & "#" _
	& " AND #" & mnext & "/1/" & ynext & "#"

Set rs = db.Execute(query)

' Create a comma delimited string containing days with events

do while not rs.EOF
	events = events & "," & Day(rs("event_start")) & ","
	rs.movenext
loop

rs.Close

FirstDay = WeekDay(Dateserial(y,m,1))

' use Dateserial to find last day of this month by taking first
' day of next month -1

DaysInMonth = Day(Dateserial(y,m+1,1)-1)
TheDay = 0

' calculate total rows by finding total number of weeks after
' top row

rows = Fix((DaysInMonth - (8 - FirstDay))/7) + 2

for row = 1 to rows 
	cal = cal & "<tr>"
	for col = 1 to 7 
		active = 0
		if row = 1 AND col = FirstDay then TheDay = 1
		if TheDay > 0 AND TheDay <= DaysInMonth then

' Bracket the day if it is today

			if y & m & TheDay = Year(now) & Month(now) & Day(now) then
				today = "[<b>" & TheDay & "</b>]"
			else
				today = TheDay
			end if

			cal = cal & "<td align=center bgcolor='#"			

' Highlight the day if it has events or shade it if it's a weekend

			if InStr(1,events,"," & TheDay & ",",1) <> 0 then
				cal = cal & "ffffbb'><a href='cal_list.asp?"
			elseif col = 1 OR col = 7 then
				cal = cal & "e0e0e0'><a href='cal_edit.asp?action=add&"
			else
				cal = cal & "ffffff'><a href='cal_edit.asp?action=add&"
			end if
		
			cal = cal & "event_context=" & event_context _
				& "&year=" & y _
				& "&month=" & m _
				& "&day=" & TheDay _
				& "'><font size=2 face='arial'>" & today & "</font></a>"
			TheDay = TheDay + 1
		else
			cal = cal & "<td>"
		end if
		cal = cal & "</td>"
	next
next
%>

<center>

<!--
Netscape doesn't support full table backgrounds so encapsulate
table in container table cell with desired backround
-->

<table><tr><td bgcolor="#C0C0C0">
<table border="0" cellspacing="1" cellpadding="1" width=350>
<tr>
	<form method="post" action="cal.asp">
	<td colspan=7 align=center>
	<input type=submit value="Go to">

<!-- Create drop-downs by looping through months and 20 years -->

	<select name = "month">
<% for mloop = 1 to 12 %>
	<option value="<%=mloop%>"<% if mloop = m then %>selected<%end if%>><%=MonthName(mloop)%>
<% next %>
	</select>

	<select name = "year">
<% for yloop = year(Now) - 10 to year(Now) + 10 %>
	<option <% if yloop = y then %>selected<%end if%>><%=yloop%>
<% next %>
	</select>

<!-- Display list of calendars with option to create new -->

	<select name="event_context">
<%
Set rs = db.Execute("SELECT * FROM cal_context ORDER BY name")
do while not rs.EOF
	if Not Session("user") = "guest" then	
		response.write "<option"
		if rs("name") = event_context then response.write " selected"
		response.write ">" & rs("name")
	else
		if rs("private") <> "True" then
			response.write "<option"
			if rs("name") = event_context then response.write " selected"
			response.write ">" & rs("name")
		end if
	end if
	rs.movenext
loop
rs.close
db.close

if Not Session("user") = "guest" then response.write "<option>(New)"
%>
	</select>
	</td></form>
	
<!-- Create day headings by looping through day numbers -->
	
<tr>
<% for d = 1 to 7 %>
	<td width="14.285713%" align="CENTER" bgcolor="#800000">
	<font face="Arial" size="1" color="#FFFFFF"><%= WeekDayName(d,1) %></font></td>
<% next %>

<!-- insert the calendar here -->

	<%=cal%>
</table>
</td></table>

<table border=0 cellpadding=0 cellspacing=0 width=350>
<tr>
	<form action="cal.asp" method="post">
	<td align=left>
	<input type="hidden" name="month" value="<%= mprev %>">
	<input type="hidden" name="year" value="<%= yprev %>">
	<input type="hidden" name="event_context" value="<%= event_context %>">
	<input type=image src="../graphics/cal_left.jpg" border=0>
	</td></form>

	<td align=center>
<% if Not events = "" then %>
	<a href="cal_list.asp?event_context=<%=event_context%>
		&year=<%=y%>
		&month=<%=m%>
		&day=0">
	<img src="../graphics/cal_event.jpg" border=0></a>
<% end if %>
	</td>

	<form action="cal.asp" method="post">
	<td align=right>
	<input type="hidden" name="month" value="<%= mnext %>">
	<input type="hidden" name="year" value="<%= ynext %>">
	<input type="hidden" name="event_context" value="<%= event_context %>">
	<input type=image src="../graphics/cal_right.jpg" border=0>
	</td></form>
</table>

</center>
</html>
</body>