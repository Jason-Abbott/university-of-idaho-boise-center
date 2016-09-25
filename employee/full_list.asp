<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 02/12/99
-->

<!--#include virtual="/header_start.inc"-->
Boise Center Employees
<!--#include virtual="/header_end.inc"-->

<center>
<table cellspacing=0 cellpadding=3 border=0>


<%
dim query, db, rs, n
n = 1

query = "SELECT name_first, name_last, email_name," _
	& " type, position, college, title" _
	& " FROM employee ORDER BY name_last"
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)
Do While Not rs.EOF
	if n mod 2 <> 0 then
		back = light
	else
		back = ""
	end if
	response.write "<tr>" & VbCrLf & "<td " & back & "><font size=2>" _
		& "<a href='detail.asp?email_name=" _
		& rs("email_name") & "' " _
		& "onMouseOver=""status='View detail for " _
		& rs("name_first") & " " & rs("name_last") & "'; " _
		& "return true;"">" & VbCrLf _
		& rs("name_last") & ", "
	if rs("type") = "faculty" then
		response.write rs("title") & " "
	end if
	response.write rs("name_first") & "</a></font></td>" & VbCrLf _
		& "<td " & back & "><font size=2>"
	if rs("position") <> "" then
		response.write rs("position")
	end if
	if rs("college") <> "Other" then
		response.write " (" & rs("college") & ")</font></td>"
	end if
	n = n + 1
	rs.MoveNext
Loop
rs.Close
db.Close
%>

</table>
</center>

<!--#include virtual="/footer.inc"-->