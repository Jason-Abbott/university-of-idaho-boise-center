<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/09/98
-->

<table cellspacing=0 cellpadding=2 border=0>
<tr>
   <td align=right bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">
	<b>Course:</b></font></td>
   <td align=center bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">
	<b>Discipline</b></font></td>
   <td align=center bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">
	<b>Number</b></font></td>
   <td align=center bgcolor="#800000">
	<font face="arial" size="2" color="#FFFFFF">
	<b>Title</b></font></td>
   <td align=center bgcolor="#800000"
	><font face="arial" size="2" color="#FFFFFF">
	<b>Instructor</b></font></td>
<tr>
   <td rowspan=2 bgcolor="#C0C0C0">
	<form action="engr_course_list.asp" method="post" target="body">
	<input type="submit" value="List >"></td>
   <td align=center bgcolor="#C0C0C0"><select name="discipline">
      <option>All
      <option value="CE">Civil
      <option value="EE">Electrical
      <option value="ME">Mechanical
      <option value="NE">Nuclear
      </select></td>
   <td align=center bgcolor="#C0C0C0">
	<input type="text" name="course_number" size=5></td>
   <td align=center bgcolor="#C0C0C0">
	<input type="text" name="title"></td>
   <td align=center bgcolor="#C0C0C0">
	<select name="instructor">
	<option>Unspecified
<%
' this application variable is used to used to establish
' the course date scope for all related forms

Application("engineering_dates") = array("spring_1998_live", _
	"spring_1998_video", _
	"fall_1998_live", _
	"fall_1998_video", _
	"spring_1999_live", _
	"spring_1999_video", _
	"fall_1999_live", _
	"fall_1999_video", _
	"spring_2000_live", _
	"spring_2000_video", _
	"fall_2000_live", _
	"fall_2000_video")

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT name_first, name_last, email_name, type " _
	& "FROM employee WHERE college = 'Engineering' " _
	& "AND type = 'faculty' ORDER BY name_last"
Set rs = db.Execute(query)
Do While Not rs.EOF
%>
<option value="<%= rs("email_name") %>"><%= rs("name_first") %> <%= rs("name_last") %>
<%
rs.MoveNext
Loop
rs.Close
db.Close
%>
   </select>
   </td>
<tr>
   <td bgcolor="#C0C0C0" colspan=4><font face="arial" size=2>
	<input type="radio" name="scope" value="fall_1997">This semester only or <input type="radio" name="scope" value="future" checked>this and future semesters</font></td>
<tr>
	<td colspan=5 align=center><font size=2>
	Press "List" without specifying parameters to see the complete listing of available courses.
	</font></td>
</table>
</form>

<!-- ADD BUTTON -->

<% if Not Session("user") = "guest" then %>
<center>
<a href="engr_course_edit.asp?action=add">
<img src="../graphics/button_add.jpg" border=0>
</a>
</center>
<% end if %>

<!-- END BUTTON -->

