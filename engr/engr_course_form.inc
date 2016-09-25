<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 5/28/98
-->

<table cellspacing=0 cellpadding=2 border=0>
<tr>
   <td align=right <%=light%>>
	<font face="arial" size="2">
	<b>Course:</b></font></td>
   <td align=center <%=light%>>
	<font face="arial" size="2">
	<b>Discipline</b></font></td>
   <td align=center <%=light%>>
	<font face="arial" size="2">
	<b>Number</b></font></td>
   <td align=center <%=light%>>
	<font face="arial" size="2">
	<b>Title</b></font></td>
   <td align=center <%=light%>>
	<font face="arial" size="2">
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
Application("years") = array(1998,1999,2000)
Application("sems") = array("Spring","Fall")
Application("media") = array("Live","Video")

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT name_first, name_last, email_name, type " _
	& "FROM employee WHERE college = 'Engineering' " _
	& "AND type = 'faculty' ORDER BY name_last"
Set rs = db.Execute(query)
Do While Not rs.EOF
	response.write "<option value='" & rs("email_name") & "'>" _
		& rs("name_first") & " " & rs("name_last")
rs.MoveNext
Loop
rs.Close
db.Close
%>
   </select>
   </td>
<tr>
   <td bgcolor="#C0C0C0" colspan=4><font face="arial" size=2>
	<input type="radio" name="scope" value="spring_1998">This semester only or <input type="radio" name="scope" value="future" checked>this and future semesters</font></td>
<tr>
	<td colspan=5 align=center><font size=2>
	Press "List" without specifying parameters to see the complete listing of available courses.
	</font></td>
</table>
</form>