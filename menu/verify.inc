<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 05/12/1999

' check to see if the user has already logged in
' if not, send them to the login page

if Session("bcNavUser") = "" then
	response.redirect "authenticate.asp?url=" _
		& Request.ServerVariables("URL") & "?" _
		& Request.ServerVariables("QUERY_STRING")
end if
%>