<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 02/05/99

' If the user has already been authenticated then we don't
' need to run this script again.

if Session("user") = "" then

' The technicians variable controls who has technician "rights."
' Technicians are able to manage help requests and edit or
' delete the generated personal web pages.

	Session("technicians") = "'jabbott','dianeg','jpchoi','hsyoon'"

' We need a list of the center's colleges for use during the 
' session.

	college_list = array( _
		"Agriculture", _
		"Engineering", _
		"Education", _
		"Forestry", _
		"Law", _
		"Letters and Sciences", _
		"Other")
	
	Session("colleges") = college_list
	
' Begin authentication by checking to see if the user is
' hailing from within the Boise Center.

	if InStr(1,Request.ServerVariables("REMOTE_ADDR"),"129.101.93",1) <> 0 then

' If so, begin next filtering level.
' Create array out of calling IP.

		IP = split(Request.ServerVariables("REMOTE_ADDR"),".",-1,1)

' Determine if IP belongs to an employee
' this value is per user so use session object.

		Set dbUsers = Server.CreateObject("ADODB.Connection")
		dbUsers.Open "bc"
		userQuery = "SELECT email_name, ip FROM employee " _
			& "WHERE ip = " & IP(3)
		Set rsUsers = dbUsers.Execute(userQuery)
		if NOT rsUsers.EOF = -1 then
			Session("user") = rsUsers("email_name")
		else
			Session("user") = "guest"
		end if
		rsUsers.Close
		dbUsers.Close

' If they're not in the Boise Center check to see if they're
' at the web server.

	elseif Request.ServerVariables("REMOTE_ADDR") = "127.0.0.1" then
		Session("user") = "jabbott"
	else
		Session("user") = "guest"
	end if
end if		
%>