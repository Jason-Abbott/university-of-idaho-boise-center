<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 03/26/98
-->

<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<html>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<%
dim db, bc, rs, prof, fill, form

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

if Request.QueryString("action") = "add" then
   form = "added"

' the fill variable determines whether the form
' should be populated with data
	
   fill = 0
else
   form = "updated"
   fill = 1
  
	query= "SELECT * FROM courses_engr WHERE course_number = '" _
		& Request.QueryString("course_number") _
		& "' AND discipline = '" & Request.QueryString("discipline") & "'"
	Set rs = db.Execute(query)	
end if
%>

<!-- DELETION FORM --------------------------------------->

<% if Request.QueryString("action") = "delete" then %>

<center>
<form action="engr_course_deleted.asp" method="post">
<font size=5>
Press "Delete" if you are sure that you want to delete
<p>
<b><%=rs("title") & " (" & rs("discipline") & " " & rs("course_number") & ")"%></b>
<p>
from the course listing.
<p>
<font color="#ff0000">This action is not reversable.</font></font>
<p>
<input type="hidden" name="course_number" value="<%=rs("course_number")%>">
<input type="submit" value="delete">
</form>
</center>

<!-- MODIFY FORM ----------------------------------------->

<% else %>

<form action="engr_course_<%=form%>.asp" method="post">

<center>
<table cellspacing=0 cellpadding=3 border=0>
<tr>
   <td colspan=4 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">CRN</font></td>
   <td colspan=6 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Title</font></td>
   <td colspan=2 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Credits</font></td>
<tr>
   <td colspan=4 align=center bgcolor="#c0c0c0">
	<input type="text" name="crn" size=5 <%if fill=1 then%>value="<%=rs("crn")%>"><%end if%></td>
   <td colspan=6 align=center bgcolor="#c0c0c0">
	<input type="text" name="title" size=30 <%if fill=1 then%>value="<%=rs("title")%>"><%end if%></td>
   <td colspan=2 align=center bgcolor="#c0c0c0">
	<input type="text" name="credits" size=1 <%if fill=1 then%>value="<%=rs("credits")%>"><%end if%></td>
<tr>
   <td colspan=4 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Discipline</font></td>
   <td colspan=4 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Number - Section</font></td>
   <td colspan=4 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Instructor*</font></td>
<tr>
   <td colspan=4 align=center bgcolor="#c0c0c0">
	<input type="text" name="discipline" size=5 <%if fill=1 then%>value="<%=rs("discipline")%>"><%end if%></td>
   <td colspan=4 align=center bgcolor="#c0c0c0">
	<input type="text" name="course_number" size=7 <%if fill=1 then%>value="<%=rs("course_number")%>"<%end if%>> - <input type="text" name="section" size=7 <%if fill=1 then%>value="<%=rs("section")%>"<%end if%>></td>
   <td colspan=4 align=center bgcolor="#c0c0c0">
	<select name="instructor"><option value="">Unspecified

<%
query = "SELECT email_name, name_first, name_last, type " _
	& "FROM employee " _
	& "WHERE college='Engineering' AND type='faculty' " _
	& "ORDER BY name_last"
Set prof = db.Execute(query)
Do While Not prof.EOF
	response.write "<option value='" & prof("email_name") & "'>"
	if fill = 1 then
		if prof("email_name") = rs("instructor") then
			response.write "selected"
		end if
	end if
	response.write prof("name_first") & " " & prof("name_last")
prof.MoveNext
Loop
prof.Close
%>
   </select>
   </td>
<tr>
   <td colspan=12 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Current Schedule</font></td>
<tr>
   <td colspan=4 align=right bgcolor="#800000">
	<font face="arial" size=2 color="#ffffff">Dates</font></td>
   <td colspan=8 bgcolor="#c0c0c0">
	<input type="text" name="course_date" <%if fill=1 then%>value="<%=rs("course_date")%>"<%end if%> size=30></td>
<tr>
   <td colspan=4 align=right bgcolor="#800000">
	<font face="arial" size=2 color="#ffffff">Times</font></td>
   <td colspan=8 bgcolor="#c0c0c0">
	<input type="text" name="course_time" <%if fill=1 then%>value="<%=rs("course_time")%>"<%end if%> size=30></td>
<tr>
   <td colspan=12 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Future Schedule</font></td>
<tr>
   <td colspan=4 align=center bgcolor="#eeeeee">
	<font face="arial">1998</font></td>
   <td colspan=4 align=center bgcolor="#c0c0c0">
	<font face="arial">1999</font></td>
   <td colspan=4 align=center bgcolor="#eeeeee">
	<font face="arial">2000</font></td>
<tr>
   <td colspan=2 align=center bgcolor="#eeeeee" width=65>
	<font face="arial" size=1>Spring</font></td>
   <td colspan=2 align=center bgcolor="#eeeeee" width=65>
	<font face="arial" size=1>Fall</font></td>
   <td colspan=2 align=center bgcolor="#c0c0c0" width=65>
	<font face="arial" size=1>Spring</font></td>
   <td colspan=2 align=center bgcolor="#c0c0c0" width=65>
	<font face="arial" size=1>Fall</font></td>
   <td colspan=2 align=center bgcolor="#eeeeee" width=65>
	<font face="arial" size=1>Spring</font></td>
   <td colspan=2 align=center bgcolor="#eeeeee" width=65>
	<font face="arial" size=1>Fall</font></td>
<tr>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>L</font></td>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>V</font></td>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>L</font></td>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>V</font></td>
   <td align=center bgcolor="#c0c0c0">
	<font face="arial" size=1>L</font></td>
   <td align=center bgcolor="#c0c0c0">
	<font face="arial" size=1>V</font></td>
   <td align=center bgcolor="#c0c0c0">
	<font face="arial" size=1>L</font></td>
   <td align=center bgcolor="#c0c0c0">
	<font face="arial" size=1>V</font></td>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>L</font></td>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>V</font></td>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>L</font></td>
   <td align=center bgcolor="#eeeeee">
	<font face="arial" size=1>V</font></td>
<tr>

<% for each x in Application("engineering_dates") %>
   <td bgcolor="#c0c0c0" align=center>
	<input type="checkbox" name="<%=x%>" <%if fill=1 then%><%if rs(x) = "True" then%>checked<%end if%><%end if%>></td>
<% next %>

<tr>
   <td colspan=12 align=center bgcolor="#800000">
	<font face="arial" color="#ffffff">Description</font></td>
<tr>
   <td colspan=12 bgcolor="#c0c0c0" align=center><textarea name="description" cols=45 rows=3><%if fill=1 then%><%=rs("description")%><%end if%></textarea></td>
<tr>
	<td colspan=6 bgcolor="#c0c0c0">
	<font size=1 face="arial">Prerequisites</font>
	<input type="text" name="prerequisites" size=10 <%if fill=1 then%>value="<%=rs("prerequisites")%>"<%end if%>>
   </td>
	<td colspan=6 bgcolor="#c0c0c0" align=right>
	<input type="submit" value="<%=Request.QueryString("action")%>">
   </td>
</table>
</center>

<%
end if

if fill=1 then rs.Close
db.Close
%>

</body>
</html>