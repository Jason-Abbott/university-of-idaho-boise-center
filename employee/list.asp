<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/12/97
-->

<!--#include file="../authenticate.inc"-->

<html>
<body link="#E4C721" vlink="#E4C721" alink="#E4C721" bgcolor="#FFFFFF">

<%
query = "SELECT * FROM employee WHERE type ='" _
	& Request.QueryString("type") & "' AND "

' Some colleges have their own listing while others
' are grouped under "other."

select case Request.QueryString("college")
	case "Engineering","Education","Agriculture"
		query = query & "college = ('" & Request.QueryString("college")
	case else
		query = query & "college NOT IN ('Engineering', 'Agriculture', 'Education"
end select

query = query & "') ORDER BY name_last"

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)
%>

<font face="arial" size=4" color="#800000">
<%= Request.QueryString("college") & " " & Request.QueryString("type")%>
</font>
<p>
<center>

<table cellspacing=3 cellpadding=3>

<!-- LOOP THROUGH RECORDS -->

<% Do While Not rs.EOF %>

<tr>
   <td colspan=2 bgcolor="#800000"><font size="4">
	<a href="detail.asp?email_name=<%=rs("email_name")%>">
<% if Request.QueryString("type") = "faculty" then %>
	<%=rs("title")%>
<% end if %>
	<%=rs("name_first") & " " & rs("name_last")%></a></font><font color="#FFFFFF">, <%= rs("position") %></font>
	</td>
<tr>
   <td align="right">
<% if Request.QueryString("type") = "faculty" then %>
	<%=rs("area")%><br>
<% end if %>
	<a href="mailto:<%=rs("email_name") & "@" & rs("email_site")%>">
	<font color="#800000"><%=rs("email_name") & "@" & rs("email_site")%></font></a>
	</td>
<tr>
   <td>&nbsp;</td>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

</table>

<!-- ADD BUTTON -->

<% if Not Session("user") = "guest" then %>
<a href="edit.asp?action=add&type=<%= Request.QueryString("type") %>&college=<%= Request.QueryString("college")%>">
<img src="../graphics/button_add.jpg" border=0>
</a>
<% end if %>

<!-- END BUTTON -->
</center>
</body>
</html>
