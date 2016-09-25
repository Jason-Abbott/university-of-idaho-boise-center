<%
' Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
' Last updated 03/18/98

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "UPDATE courses_engr SET " _
	& "discipline = '" & Request.Form("discipline") & "', " _
	& "course_number = '" & Request.Form("course_number") & "', " _
	& "instructor = '" & Request.Form("instructor") & "', " _
	& "title = '" & Request.Form("title") & "', " _
	& "crn = '" & Request.Form("crn") & "', " _
	& "section = '" & Request.Form("section") & "', " _
	& "course_date = '" & Request.Form("course_date") & "', " _
	& "course_time = '" & Request.Form("course_time") & "', "

for each x in Session("engineering_dates")
   if Request.Form(x) = "on" then
      value = "1"
   else
      value = "0"
   end if
   query = query & x & " = '" & value & "', "
next

if Request.Form("credits") <> "" then
   query = query & "credits = '" & Request.Form("credits") & "', "
end if

query = query & "prerequisites = '" & Request.Form("prerequisites") & "', " _
	& "description = '" & Request.Form("description") & "' " _
	& "WHERE discipline = '" & Request.Form("discipline") & "' " _
	& "AND course_number = '" & Request.Form("course_number") & "'"

db.Execute(query)
db.Close

response.redirect "engr_course_detail.asp?" _
	& "course_number=" & Request.Form("course_number") _
	& "&discipline=" & Request.Form("discipline")

'response.write query

%>