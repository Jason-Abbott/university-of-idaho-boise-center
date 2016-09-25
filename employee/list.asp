<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 5/27/98
-->

<%
query = "SELECT * FROM employee WHERE type ='" _
	& Request.QueryString("type") & "' AND "

' Some colleges have their own listing while others
' are grouped under "other"

select case Request.QueryString("college")
	case "Engineering","Education","Agriculture","Law"
		query = query & "college = ('" & Request.QueryString("college")
	case else
		query = query & "college NOT IN ('Engineering', 'Agriculture', 'Education', 'Law"
end select

query = query & "') ORDER BY name_last"

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)
%>

<!--#include virtual="/header_start.inc"-->

College of <%=Request.QueryString("college") & " " & Request.QueryString("type")%> members

<!-- insert "add" button -->

	</td>
	<td align=right>
	
<% if Not Session("user") = "guest" then %>
<a href="edit.asp?action=add&type=<%= Request.QueryString("type") %>&college=<%= Request.QueryString("college")%>">
<img src="/graphics/button_add.gif" border=0>
</a>
<% end if %>

<!--#include virtual="/header_end.inc"-->

<center>
<table cellspacing=3 cellpadding=3>

<!-- LOOP THROUGH RECORDS -->

<% Do While Not rs.EOF %>

<tr>
   <td colspan="2" <%=light%>><font size="4">
	<a href="detail.asp?email_name=<%=rs("email_name")%>">
<% if Request.QueryString("type") = "faculty" then %>
	<%=rs("title")%>
<% end if %>
	<%=rs("name_first") & " " & rs("name_last")%></a></font>,
	<i><%=rs("position") %></i></font>
	</td>
<tr>
   <td align="right">
<% if Request.QueryString("type") = "faculty" then %>
	<%=rs("area")%><br>
<% end if %>
	<a href="mailto:<%=rs("email_name") & "@" & rs("email_site")%>">
	<%=rs("email_name") & "@" & rs("email_site")%></a>
	<br><br>
	</td>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

</table>
</center>

<!--#include virtual="/footer.inc"-->