<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 5/28/98
-->

<!--#include virtual="/header_start.inc"-->

<%
dim db, query, rs, i

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT * FROM employee WHERE " _
	& "email_name = '" & Request.QueryString("email_name") & "'"
Set rs = db.Execute(query)

if rs("type") = "faculty" then
	response.write rs("title") & "&nbsp;"
end if

response.write rs("name_first") & "&nbsp;" & rs("name_last")  _
	& ", " & rs("position")
%>
	</td>
	<td align=right>

<!-- edit button -->

<%
' check to see if the page belongs to the current user
' or if the current user is a technician

if Session("user") = rs("email_name") OR _
	InStr(Session("technicians"), Session("user")) > 0 then
%>
<a href="edit.asp?action=update&email_name=<%=rs("email_name")%>">
<img src="/graphics/button_edit.gif" border=0>
</a>
<% end if %>

<!-- delete button -->

<% if InStr(Session("technicians"), Session("user")) > 0 then %>
<a href="edit.asp?action=delete&email_name=<%=rs("email_name")%>">
<img src="/graphics/button_del.gif" border=0>
</a>
<% end if %>

<!--#include virtual="/header_end.inc"-->

<!-- START TABLE AND RETRIEVE PHOTO -->

<table border=0 width=400>
<tr>
   <td colspan=2><a href="/map/floor_med.asp">
<%
' check to see if a filename exists matching the user's
' e-mail name, otherwise display alien

Set fs = CreateObject("Scripting.FileSystemObject")
if fs.FileExists("d:\internet\www\graphics\people\" & rs("email_name") & ".jpg") then
%>
	<img src="/graphics/people/<%=rs("email_name")%>.jpg" align="left" border=1>
<% else %>
	<img src="/graphics/people/no_picture.jpg" align="left" border=1>
<% end if %>
	</a>
<!-- CONTACT INFORMATION -->

<%
response.write "<font size=4>" _
	& rs("area") & "</font><p><a href='mailto:" _
	& rs("email_name") & "@" & rs("email_site") & "'>" _
	& rs("email_name") & "@" & rs("email_site") & "</a>" _
	& "<br>(208) 364-" & rs("phone")
%>
	</td>
	
<!-- PERSONAL LINKS -->

<% if Not rs("site1_url") = "" then %>
<tr>
<form action="/jump.asp" method="post" target=_top>
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
	<input type=image src="/graphics/button_go.gif" border=0>
	</td>
	
</form>

<% end if %>

<!-- FACULTY FIELDS -------------------------------------->

<% if rs("type") = "faculty" then %>

<!--education -->

<%	if Not rs("degree1_type") = "" then %>
	 
<tr>
   <td colspan="2" <%=light%>>
	<font face="arial"><b>Education</b></font></td>

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

<%
' Fields that are of type memo are treated as objects
' and so never conisdered empty.  Therefore, to check
' for the presence of data find the size of the field.

	if rs("emphasis").ActualSize > 5 then
%>

<tr>
   <td colspan="2" <%=light%>>
	<font face="arial"><b>Emphasis</b></font></td>
<tr>
   <td colspan="2"><%=rs("emphasis")%></td>
	
<%	end if %>

<!-- experience -->

<%	if Not rs("exp1_time") = "" then %>

<tr>
   <td colspan="2" <%=light%>>
	<font face="arial"><b>Experience</b></font></td>

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
   <td colspan="2" <%=light%>>
	<font face="arial"><b>Scholarship</b></font></td>
<tr>
   <td colspan="2"><%=rs("scholarship")%></td>
<%	end if %>

<!-- STAFF FIELDS ---------------------------------------->

<% else %>

<!-- duties -->

<%	if Not rs("duty1") = "" then %>

<tr>
   <td colspan="2" <%=light%>>
	<font face="arial"><b>Duties</b></font></td>
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
   <td colspan="2" <%=light%>>
	<font face="arial"><b>Projects</b></font></td>
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
%>
<tr>
   <td colspan="2" <%=light%>><font face="arial" size=3><b>
	URL:</b><font size=2>
	http://boise.uidaho.edu/person.asp?id=<%=rs("email_name")%></b></font>
	</td>

<%
rs.Close
db.Close
%>

</table>


<!--#include virtual="/footer.inc"-->