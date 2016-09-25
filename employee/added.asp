<%
' Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
' Last updated 12/21/97

dim db, query, x

if Session("user") = "guest" then response.redirect "./error.asp"

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "INSERT INTO employee ("

' generate SQL by cyling through form variables

for each x In Request.Form
	if not Request.Form(x) = "" then
	   query = query & x & ", "
	end if
next

query = query & "type, update_machine, update_time) VALUES ("

for each x In Request.Form
	if not Request.Form(x) = "" then	
	   query = query & "'" & Request.Form(x) & "', "
	end if
next

query = query & "'" & Session("type") & "', "
query = query & "'" & Request.ServerVariables("REMOTE_ADDR") & "', "
query = query & "'" & Now & "')"

db.Execute(query)
db.Close

' send user to new employee page

response.redirect "detail.asp?email_name=" & Request.Form("email_name")
%>

<!-- used only to debug SQL -->

<html>
<body bgcolor=#FFFFFF>
<%= query %>
</body>
</html>