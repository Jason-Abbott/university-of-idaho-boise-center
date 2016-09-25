<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 05/28/98

dim db, query, y, s, m

if Session("user") = "guest" then response.redirect "/error.asp"

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "INSERT INTO courses_engr ("

' generate schedule names

for each y in Application("years")
	for each s in Application("sems")
		for each m in Application("media")
			query = query & s & "_" & y & "_" & m & ", "
		next
	next
next

query = query _
	& "discipline, " _
	& "course_number, " _
	& "instructor, " _
	& "title, " _
	& "crn, " _
	& "section, " _
	& "course_date, " _
	& "course_time, " _
	& "update_machine, " _
	& "update_time) VALUES ("

' generate schedule values

for each y in Application("years")
	for each s in Application("sems")
		for each m in Application("media")
		   if Request.Form(s & "_" & y & "_" & m) = "on" then
		      query = query & "'1', "
		   else
		      query = query & "'0', "
		   end if
		next
	next
next

query = query & "'" _
	& Request.Form("discipline") & "', '" _
	& Request.Form("course_number") & "', '" _
	& Request.Form("instructor") & "', '" _
	& Request.Form("title") & "', '" _
	& Request.Form("crn") & "', '" _
	& Request.Form("section") & "', '" _
	& Request.Form("course_date") & "', '" _
	& Request.Form("course_time") & "', '" _
	& Request.ServerVariables("REMOTE_ADDR") & "', '" _
	& Now & "')"

db.Execute(query)
db.Close

' send user to new course page

response.redirect "engr_course_detail.asp?" _
	& "course_number=" & Request.Form("course_number") _
	& "&discipline=" & Request.Form("discipline")

'response.write query
%>