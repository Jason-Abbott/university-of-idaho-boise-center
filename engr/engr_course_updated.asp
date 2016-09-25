<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 05/28/98

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "UPDATE courses_engr SET "

' generate schedule

for each y in Application("years")
	for each s in Application("sems")
		for each m in Application("media")
		   if Request.Form(s & "_" & y & "_" & m) = "on" then
		      value = "1"
		   else
		      value = "0"
		   end if
		   query = query & s & "_" & y & "_" & m & " = '" & value & "', "
		next
	next
next

' the credit field doesn't like a null value

if Request.Form("credits") <> "" then
   query = query & "credits = '" & Request.Form("credits") & "', "
end if

query = query _
	& "discipline = '" & Request.Form("discipline") & "', " _
	& "course_number = '" & Request.Form("course_number") & "', " _
	& "instructor = '" & Request.Form("instructor") & "', " _
	& "title = '" & Request.Form("title") & "', " _
	& "crn = '" & Request.Form("crn") & "', " _
	& "section = '" & Request.Form("section") & "', " _
	& "course_date = '" & Request.Form("course_date") & "', " _
	& "course_time = '" & Request.Form("course_time") & "', " _
	& "prerequisites = '" & Request.Form("prerequisites") & "', " _
	& "description = '" & Request.Form("description") & "', " _
	& "update_time = '" & Now & "', " _
	& "update_machine = '" & Request.ServerVariables("REMOTE_ADDR") & "' " _
	& "WHERE discipline = '" & Request.Form("discipline") & "' " _
	& "AND course_number = '" & Request.Form("course_number") & "'"

db.Execute(query)
db.Close

response.redirect "engr_course_detail.asp?" _
	& "course_number=" & Request.Form("course_number") _
	& "&discipline=" & Request.Form("discipline")

'response.write query

%>