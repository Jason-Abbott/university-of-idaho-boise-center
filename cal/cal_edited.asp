<%
' Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
' updated 01/28/98

dim db, event_start, event_end

' generate correct event_start date format

event_start = Request.Form("month") & "-" _
	& Request.Form("day") & "-" _
	& Right(Request.Form("year"),2) & " " _
	& Request.Form("event_start") & " " & Request.Form("s_apm")

event_end = Request.Form("month") & "-" _
	& Request.Form("day") & "-" _
	& Right(Request.Form("year"),2) & " " _
	& Request.Form("event_end") & " " & Request.Form("e_apm")

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

if Request.Form("action") = "add" then
	query = "INSERT INTO cal_events (event_title, event_description, " _
	& "event_start, event_end, event_context, " _
	& "update_time, update_machine) VALUES ('" _
	& replace(Request.Form("event_title"), "'", "’") & "', '" _
	& replace(Request.Form("event_description"), "'", "’") & "', '" _
	& event_start & "', '" _
	& event_end & "', '" _
	& Request.Form("event_context") & "', '" _
	& Now & "', '" _
	& Request.ServerVariables("REMOTE_ADDR") & "')"
else
	query = "UPDATE cal_events SET " _
	& "event_title = '" & replace(Request.Form("event_title"), "'", "’") & "', " _
	& "event_description = '" & replace(Request.Form("event_description"), "'", "’") & "', " _
	& "event_start = '" & event_start & "', " _
	& "event_end = '" & event_end & "', " _
	& "event_context = '" & Request.Form("event_context") & "', " _
	& "update_time= '" & Now & "', " _
	& "update_machine = '" & Request.ServerVariables("REMOTE_ADDR") & "' " _
	& "WHERE event_context = '" & Request.Form("old_context") _
	& "' AND event_title = '" & Request.Form("old_title") _
	& "' AND event_start = #" & Request.Form("old_start") & "#"
end if

db.Execute(query)
db.Close

' send user to calendar

response.redirect "cal_list.asp" _
	& "?event_context=" & Replace(Request.Form("event_context")," ","%20") _
	& "&year=" & Request.Form("year") _
	& "&month=" & Request.Form("month") _
	& "&day=0"
%>

<!-- used only to debug SQL -->

<html>
<body bgcolor="#FFFFFF">
<%= query %>
</body>
</html>