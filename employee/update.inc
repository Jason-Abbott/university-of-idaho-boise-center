<%
' Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
' Last updated 12/12/97

dim db, rs, x, links, linkfile

if Session("count") = "" then
	Session("count") = 1
else
	Session("count") = Session("count") + 1
end if

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

' cycle through form values, adding only
' those that exist

for each x In Request.Form
	if not Request.Form(x) = "" then
	  	query = query & x & " = '" & Request.Form(x) & "', "
	end if
next

' don't bother with the update if the user
' didn't enter any values

if not query = "" then
	query = query & "update_machine='" _
		& Request.ServerVariables("REMOTE_ADDR") _
		& "', update_time='" & Now & "' " _
		& "WHERE email_name = '" & Request.Form("email_name") & "'"
	query = "UPDATE employee SET " & query
	db.Execute(query)
end if

' now extract the employee's full record

query = "SELECT * FROM employee WHERE " _
	& "email_name = '" & Request.QueryString("email_name") & "'"
Set rs = db.Execute(query)

if rs("type") = "faculty" then
	linkfile = "links_faculty.txt"
else
	linkfile = "links_staff.txt"
end if

Set links = Server.CreateObject("MSWC.NextLink") 
%>

<html>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">
<center>
<form action="<%=links.GetNextURL(linkfile)%>" method="post">