<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' updated 6/10/98

' custom calendar for Cooperative Extension System

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

' generate INSERT or UPDATE SQL
' replace function used to substitute real apostrophes
' for tick marks so there is no ambiguity

if Request.Form("action") = "add" then
	query = "INSERT INTO ext_cal_events (event_title, " _
	& "event_location, event_description, " _
	& "event_start, event_end, event_context, " _
	& "update_time, update_machine) VALUES ('" _
	& replace(Request.Form("event_title"), "'", "’") & "', '" _
	& replace(Request.Form("event_location"), "'", "’") & "', '" _
	& replace(Request.Form("event_description"), "'", "’") & "', '" _
	& event_start & "', '" _
	& event_end & "', '" _
	& Request.Form("event_context") & "', '" _
	& Now & "', '" _
	& Request.ServerVariables("REMOTE_ADDR") & "')"
else
	query = "UPDATE ext_cal_events SET " _
	& "event_title = '" & replace(Request.Form("event_title"), "'", "’") & "', " _
	& "event_location = '" & replace(Request.Form("event_location"), "'", "’") & "', " _
	& "event_description = '" & replace(Request.Form("event_description"), "'", "’") & "', " _
	& "event_start = '" & event_start & "', " _
	& "event_end = '" & event_end & "', " _
	& "event_context = '" & Request.Form("event_context") & "', " _
	& "update_time= '" & Now & "', " _
	& "update_machine = '" & Request.ServerVariables("REMOTE_ADDR") & "' " _
	& "WHERE (event_id)=" & Request.Form("event_id")
end if

db.Execute(query)
db.Close

' send user to event list

response.redirect "ext_cal.asp" _
	& "?event_context=" & Request.Form("event_context") _
	& "&year=" & Request.Form("year") _
	& "&month=" & Request.Form("month")
%>

<!-- used only to debug SQL -->

<html>
<body bgcolor="#FFFFFF">
<%= query %>
</body>
</html>