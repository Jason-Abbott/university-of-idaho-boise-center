<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 12/12/97

if Session("user") = "guest" then response.redirect "/error.asp"

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "UPDATE employee SET "

' generate SQL by cyling through form variables

for each x In Request.Form
   query = query & x & " = '" & Request.Form(x) & "', "
next

query = query & "update_machine='" & Request.ServerVariables("REMOTE_ADDR") & "', update_time='" & Now & "'"
query = query & " WHERE email_name = '" & Request.Form("email_name") & "'"
db.Execute(query)
db.Close

' send user to the updated employee page

response.redirect "detail.asp?email_name=" & Request.Form("email_name")

%>

<!-- used only to debug SQL -->

<html>
<body bgcolor="#FFFFFF">
<%= query %>
</body>
</html>