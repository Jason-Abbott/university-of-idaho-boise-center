<%
' Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
' Last updated 03/18/98

if Session("user") = "guest" then response.redirect "./error.asp"

' delete event from database

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "DELETE FROM cal_events" _
	& " WHERE (event_id)=" & Request.Form("event_id")
	
db.Execute(query)
db.Close

'uncomment this line to debug SQL:
'response.write query

' send user back to calendar

response.redirect "cal_list.asp" _
	& "?event_context=" & Replace(Request.Form("event_context")," ","%20") _
	& "&year=" & Request.Form("year") _
	& "&month=" & Request.Form("month") _
	& "&day=0"
%>