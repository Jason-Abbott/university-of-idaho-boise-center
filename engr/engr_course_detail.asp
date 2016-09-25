<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 6/8/98
-->

<!--#include virtual="/header_start.inc"-->
<%
dim db, rs, course

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query= "SELECT * FROM courses_engr WHERE " _
	& "course_number = '" & Request.QueryString("course_number") _
	& "' AND discipline = '" & Request.QueryString("discipline") & "'"
Set rs = db.Execute(query)
response.write rs("title")
%>
	</td>
	<td align=right>

<!-- edit button -->

<% if Not Session("user") = "guest" then %>
<a href="engr_course_edit.asp?action=update&course_number=<%=rs("course_number")%>&discipline=<%=rs("discipline")%>" target="body">
<img src="/graphics/button_edit.gif" border=0>
</a>
<% end if %>

<!-- delete button -->

<%
' Only Denise Engebrecht and technicians are allowed to
' delete courses

if Session("user") = "denisee" OR _
	InStr(Session("technicians"), Session("user")) > 0 then
%>
<a href="engr_course_edit.asp?action=delete&course_number=<%=rs("course_number")%>&discipline=<%=rs("discipline")%>" target="body">
<img src="/graphics/button_del.gif" border=0>
</a>
<% end if %>
<!--#include virtual="/header_end.inc"-->

<center>
<table cellpadding="3" cellspacing="0" border="0">
<tr>
   <td align="center" <%=light%>>
	<font face="arial" size="2">Description</font></td>
   <td align="center" <%=light%>>
	<font face="arial" size="2">Discipline</font></td>
   <td align="center" <%=light%>>
	<font face="arial" size="2">Number</font></td>
   <td align="center" <%=light%>>
	<font face="arial" size="2">Section</font></td>
   <td align="center" <%=light%>>
	<font face="arial" size="2">CRN</font></td>
   <td align="center" <%=light%>>
	<font face="arial" size="2">Credits</font></td>
   <td align="center" <%=light%>>
	<font face="arial" size="2">Instructor</font></td>
<tr>
   <td rowspan="15" valign="top">
	<%=rs("description")%></td>
   <td align="center">
	<%=rs("discipline")%></td>
   <td align="center">
	<%=rs("course_number")%></td>
   <td align="center">
	<%=rs("section")%></td>
   <td align="center">
	<%=rs("crn")%></td>
   <td align="center">
	<%=rs("credits")%></td>
   <td align="center">
	<a href="/employee/detail.asp?email_name=<%=rs("instructor")%>">
	<%=rs("instructor")%></a></td>
<tr>
   <td colspan="6" align="center" <%=light%>>
	<font face="arial" size="2">Schedule</font></td>

<% if rs("course_date") <> "" OR rs("course_time") <> "" then %>
<tr>
   <td colspan="6">
	<font face="arial" size="2">Days and Times:</font></td>
<tr>
   <td colspan="6" align="center">
	<%=rs("course_date")%><br><%=rs("course_time")%></td>
<% end if %>

<tr>
   <td colspan="6">
	<font face="arial" size="2">Semesters:</font></td>
<tr>
   <td colspan="3" align="center" valign="top">
	<u>Live <img src="/graphics/live.gif"></u><br>
<%
for each y in Application("years")
	for each s in Application("sems")
		if rs(s & "_" & y & "_Live") = "True" then
			response.write s & " " & y & "<br>"
		end if
	next
next
%>
	</td>
	<td colspan="3" align="center" valign="top">
	<u>Video <img src="/graphics/video.gif"></u><br>
<%
for each y in Application("years")
	for each s in Application("sems")
		if rs(s & "_" & y & "_Video") = "True" then
			response.write s & " " & y & "<br>"
		end if
	next
next
%>
   </td>
</table>
<p>
<%
rs.Close
db.Close
%>
</center>

<!--#include virtual="/footer.inc"-->