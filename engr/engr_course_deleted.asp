<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 5/27/98

if Session("user") <> "jabbott" then response.redirect "/error.asp"

' delete user from database

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "DELETE FROM courses_engr WHERE course_number = '" & Request.Form("course_number") & "'"
db.Execute(query)
db.Close

' send user back to employee listing

response.redirect "engr_course_intro.asp"
%>