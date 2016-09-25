<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 02/05/99

' The technicians session variable is set in the authenticate.inc
' file in the web root.

query = "SELECT name_first, name_last, email_name, email_site FROM employee " _
	& "WHERE email_name IN (" & Session("technicians") & ")"

' This assumes that db has already been linked to the database
' in the including asp file.

Set rsTech = db.Execute(query)
Do While Not rsTech.EOF
	JMail.AddRecipientEx rsTech("email_name") & "@" & rsTech("email_site"), rsTech("name_first") & " " & rsTech("name_last")
rsTech.MoveNext
Loop
rsTech.Close
%>