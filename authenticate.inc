<%
' Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
' Last updated 12/11/97

' check to see if the user has already been authenticated

if Session("user") = "" then

' Begin authentication by checking to see if the user is
' hailing from within the Boise Center

	if InStr(1,Request.ServerVariables("REMOTE_ADDR"),"129.101.93",1) <> 0 then

' if so, begin next filtering level:
' create array out of calling IP

		IP = split(Request.ServerVariables("REMOTE_ADDR"),".",-1,1)

' determine if IP belongs to an employee
' this value is per user so use session object

		Set db = Server.CreateObject("ADODB.Connection")
		db.Open "bc"
		query = "SELECT email_name, ip FROM employee " _
			& "WHERE ip = " & IP(3)
		Set rs = db.Execute(query)
		if NOT rs.EOF = -1 then
			Session("user") = rs("email_name")
		elseif IP(3) = 245 OR IP(3) = 17 then
			Session("user") = "jabbott"
		else
			Session("user") = "guest"
		end if
		rs.Close
		db.Close

' if they're not in the Boise Center check to see if they're
' at the web server

	elseif Request.ServerVariables("REMOTE_ADDR") = "127.0.0.1" then
		Session("user") = "jabbott"
	else
		Session("user") = "guest"
	end if
end if		
%>