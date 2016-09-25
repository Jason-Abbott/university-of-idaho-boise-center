<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 05/12/1999

' This opens the database webNav.mdb stored in the
' the directory /data under the main webNav files

dim db
Set db = Server.CreateObject("ADODB.Connection")
DSN = "DRIVER={Microsoft Access Driver (*.mdb)}; " _
	& "DBQ=" & Server.Mappath("data/bcNav.mdb")
db.Open DSN

' make sure the containing file does
' db.Close
' Set db = nothing
%>