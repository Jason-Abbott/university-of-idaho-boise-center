<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 03/18/98
-->

<!--#include file="../authenticate.inc"-->

<html>
<body bgcolor="#FFFFFF" link="#800000" vlink="#800000" alink="#E4C721">

<%
dim db, rs, course

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query= "SELECT * FROM courses_engr WHERE " _
	& "course_number = '" & Request.QueryString("course_number") _
	& "' AND discipline = '" & Request.QueryString("discipline") & "'"
Set rs = db.Execute(query)
%>

<center>
<table cellpadding="3" cellspacing="0" border="0">
<tr>
   <td colspan="7" align="center"><font size="5"><%=rs("title")%></font></td>
<tr>
   <td align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">Description</font></td>
   <td align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">Discipline</font></td>
   <td align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">Number</font></td>
   <td align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">Section</font></td>
   <td align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">CRN</font></td>
   <td align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">Credits</font></td>
   <td align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">Instructor</font></td>
<tr>
   <td rowspan="15" valign="top" bgcolor="#C0C0C0">
	<%=rs("description")%></td>
   <td align="center" bgcolor="#C0C0C0">
	<%=rs("discipline")%></td>
   <td align="center" bgcolor="#C0C0C0">
	<%=rs("course_number")%></td>
   <td align="center" bgcolor="#C0C0C0">
	<%=rs("section")%></td>
   <td align="center" bgcolor="#C0C0C0">
	<%=rs("crn")%></td>
   <td align="center" bgcolor="#C0C0C0">
	<b><%=rs("credits")%></b></td>
   <td align="center" bgcolor="#C0C0C0">
	<b><a href="./faculty/faculty_member.asp?email_name=<%=rs("instructor")%>">
	<%=rs("instructor")%></a></b></td>
<tr>
   <td colspan="6" align="center" bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">Schedule</font></td>
<tr>
   <td colspan="6" bgcolor="#c0c0c0">
	<font face="arial" size="2">Current Semester:</font></td>
<tr>
   <td colspan="6" align="center" bgcolor="#c0c0c0">
	<%=rs("course_date")%><br><%=rs("course_time")%></td>
<tr>
   <td colspan="6" bgcolor="#c0c0c0">
	<font face="arial" size="2">Future Semesters:</font></td>
<tr>
   <td colspan="3" align="center" bgcolor="#c0c0c0">
	<u>Live <img src="../graphics/live.gif"></u></td>
	<td colspan="3" align="center" bgcolor="#c0c0c0">
	<u>Video <img src="../graphics/video.gif"></u></td>
<%
for each x in Application("engineering_dates")
'	response.write x & "," & rs(x) & ",<br>"
	if rs(x) = "True" then
		response.write "<tr>"
		course = split(x,"_",-1,1)
		if	course(2) = "live" then
			response.write "<td colspan='3' align='center' bgcolor='#c0c0c0'>" _
				& course(0) & " " & course(1) & "</td>"
		end if
		if course(2) = "video" then
			response.write "<td colspan='3'></td><td colspan='3' align='center' bgcolor='#c0c0c0'>" _
				& course(0) & " " & course(1) & "</td>"
		end if
	end if
next
%>
   </td>
</table>
<p>

<!------ EDIT BUTTON ------>

<% if Not Session("user") = "guest" then %>
<a href="engr_course_edit.asp?action=update&course_number=<%=rs("course_number")%>&discipline=<%=rs("discipline")%>" target="body">
<img src="../graphics/button_edit.jpg" border=0>
</a>
<% end if %>

<!------ DELETE BUTTON ------>

<% if Session("user") = "jabbott" then %>
<a href="engr_course_edit.asp?action=delete&course_number=<%=rs("course_number")%>&discipline=<%=rs("discipline")%>" target="body">
<img src="../graphics/button_del.jpg" border=0>
</a>
<% end if %>

<!------ END BUTTONS ------>

<%
rs.Close
db.Close
%>
</center>
</body>
</html>