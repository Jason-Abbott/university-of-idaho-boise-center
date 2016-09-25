<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/12/97
-->

<!--#include file="../authenticate.inc"-->
<%
dim db, query, rs, i

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT * FROM employee WHERE " _
	& "email_name = '" & Request.QueryString("email_name") & "'"
Set rs = db.Execute(query)
%>

<html>
<body bgcolor="#FFFFFF" link="#800000" vlink="#800000">

<!-- START TABLE AND RETRIEVE PHOTO -->

<table border=0 width=400>
<tr>
   <td colspan=2>
<%
' check to see if a filename exists matching the user's
' e-mail name, otherwise display alien

Set fs = CreateObject("Scripting.FileSystemObject")
if fs.FileExists("c:\internet\www\graphics\" & rs("email_name") & ".jpg") then
%>
	<img src="../graphics/<%=rs("email_name")%>.jpg" align="left">
<% else %>
	<img src="../graphics/no_picture.jpg" align="left">
<% end if %>

<!-- DELETE BUTTON -->

<% if Session("user") = "jabbott" then %>
<a href="edit.asp?action=delete&email_name=<%=rs("email_name")%>">
<img src="../graphics/button_del.jpg" border=0 align=right>
</a>
<% end if %>

<!-- EDIT BUTTON -->

<% if Not Session("user") = "guest" then %>
<a href="edit.asp?action=update&email_name=<%=rs("email_name")%>">
<img src="../graphics/button_edit.jpg" border=0 align=right>
</a>
<% end if %>

<!-- CONTACT INFORMATION -->

<%
response.write "<font size=4>"

if rs("type") = "faculty" then
	response.write rs("title") & "&nbsp;"
end if

response.write rs("name_first") & "&nbsp;" & rs("name_last")  _
	& "<br></font><font face='arial' size='2'><b>" _
	& rs("position") & "</b><br>" _
	& rs("area") & "</font><p><font size=2><a href='mailto:" _
	& rs("email_name") & "@" & rs("email_site") & "'>" _
	& rs("email_name") & "@" & rs("email_site") & "</a>" _
	& "<br>(208) 364-" & rs("phone") & "</font>"
%>
	</td>
	
<!-- PERSONAL LINKS -->

<% if Not rs("site1_url") = "" then %>
<tr>
<form action="./jump.asp" method="post" target=_top>
	<td colspan=2 align=right>Related links:
	<select name="url">
<%
	for i = 1 to 6
   	if rs("site"&i&"_url") <> "" then
			response.write "<option value='" _
				& rs("site"&i&"_url") & "'>" _
				& rs("site"&i&"_description")
		end if
	next
%>
	</select>
	<input type=image src="../graphics/button_go.jpg" border=0>
	</td>
	
</form>

<% end if %>

<!-- FACULTY FIELDS -------------------------------------->

<% if rs("type") = "faculty" then %>

<!--education -->

<%	if Not rs("degree1_type") = "" then %>
	 
<tr>
   <td colspan="2" bgcolor="#800000">
	<font face="arial" color="#FFFFFF">Education</font></td>

<%
		for i = 4 to 1 step -1
		   if rs("degree"&i&"_type") <> "" then
%>

<tr>
   <td align="right" valign="top"><b><%=rs("degree"&i&"_type")%></b></td>
   <td valign="top"><%=rs("degree"&i&"_place")%>&nbsp;<%=rs("degree"&i&"_date")%></td>

<%
		   end if
		next
	end if
%>

<!-- emphasis -->

<%	if rs("emphasis").ActualSize > 5 then %>

<tr>
   <td colspan="2" bgcolor="#800000">
	<font face="arial" color="#FFFFFF">Emphasis</font></td>
<tr>
   <td colspan="2"><%=rs("emphasis")%></td>
	
<%	end if %>

<!-- experience -->

<%	if Not rs("exp1_time") = "" then %>

<tr>
   <td colspan="2" bgcolor="#800000">
	<font face="arial" color="#FFFFFF">Experience</font></td>

<%
		for i = 4 to 1 step -1
	   	if Not rs("exp"&i&"_time") = "" then
%>

<tr>
   <td align="right" valign="top"><b><%=rs("exp"&i&"_time")%></b></td>
   <td valign="top"><%=rs("exp"&i&"_desc")%></td>

<%
		   end if
		next
	end if
%>

<!-- scholarship -->

<%	if rs("scholarship").ActualSize > 5 then %>

<tr>
   <td colspan="2" bgcolor="#800000">
	<font face="Arial" color="#FFFFFF">Scholarship</font></td>
<tr>
   <td colspan="2"><%=rs("scholarship")%></td>
<%	end if %>

<!-- STAFF FIELDS ---------------------------------------->

<% else %>

<!-- duties -->

<%	if Not rs("duty1") = "" then %>

<tr>
   <td colspan="2" bgcolor="#800000"><font face="arial" color="#FFFFFF">Duties</font></td>
<tr>
   <td colspan="2">
<%
		for i = 1 to 6
		   if Not rs("duty"&i) = "" then
				response.write "<li>" & rs("duty"&i)
		   end if
		next
%>
   </td>
	
<%	end if %>

<!-- projects -->

<%	if Not rs("project1") = "" then %>

<tr>
   <td colspan="2" bgcolor="#800000"><font face="arial" color="#FFFFFF">Projects</font></td>
<tr>
   <td>
<%
		for i = 1 to 6
	   	if Not rs("project"&i) = "" then
				response.write "<li>" & rs("project"&i)
			end if
		next
%>
	</td>

<%
	end if
end if
rs.Close
db.Close
%>

</table>
</body>
</html>