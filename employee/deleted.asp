<%
' Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
' Last updated 12/10/97

if Session("user") <> "jabbott" then response.redirect "./error.asp"

' delete user from database

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "DELETE FROM employee WHERE email_name = '" & Request.Form("email_name") & "'"
db.Execute(query)
db.Close

' send user back to employee listing

response.redirect "list.asp?college=" & Request.Form("college") & "&type=" & Session("type")
%>