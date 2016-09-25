<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 5/29/98
-->

<!--#include virtual="/header_start.inc"-->
<!--#include virtual="/restrict.asp"-->
<%
dim db, bc, rs, prof, fill, form

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

if Request.QueryString("action") = "add" then
   form = "added"

' the fill variable determines whether the form
' should be populated with data
	
   fill = 0
	title = "Add Engineering Course"
else
   form = "updated"
   fill = 1
  
	query= "SELECT * FROM courses_engr WHERE course_number = '" _
		& Request.QueryString("course_number") _
		& "' AND discipline = '" & Request.QueryString("discipline") & "'"
	Set rs = db.Execute(query)
	title = Request.QueryString("action") & " " & rs("title")
end if

response.write title
%>

<!--#include virtual="/header_end.inc"-->

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

<% else %>

<!-- MODIFY FORM ----------------------------------------->

<form action="engr_course_<%=form%>.asp" method="post">
<center>
<table cellspacing=0 cellpadding=3 border=0 width=400>
<tr>
   <td colspan=4 align=center <%=light%>>
	<font face="arial"><b>CRN</b></font></td>
   <td colspan=6 align=center <%=light%>>
	<font face="arial"><b>Title</b></font></td>
   <td colspan=2 align=center <%=light%>>
	<font face="arial"><b>Credits</b></font></td>
<tr>
   <td colspan=4 align=center bgcolor="#c0c0c0">
	<input type="text" name="crn" size=5 <%if fill=1 then%>value="<%=rs("crn")%>"<%end if%>></td>
   <td colspan=6 align=center bgcolor="#c0c0c0">
	<input type="text" name="title" size=30 <%if fill=1 then%>value="<%=rs("title")%>"<%end if%>></td>
   <td colspan=2 align=center bgcolor="#c0c0c0">
	<input type="text" name="credits" size=1 <%if fill=1 then%>value="<%=rs("credits")%>"<%end if%>></td>
<tr>
   <td colspan=4 align=center <%=light%>>
	<font face="arial"><b>Discipline</b></font></td>
   <td colspan=4 align=center <%=light%>>
	<font face="arial"><b>Number - Section</b></font></td>
   <td colspan=4 align=center <%=light%>>
	<font face="arial"><b>Instructor*</b></font></td>
<tr>
   <td colspan=4 align=center bgcolor="#c0c0c0">
	<input type="text" name="discipline" size=5 <%if fill=1 then%>value="<%=rs("discipline")%>"<%end if%>></td>
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
   <td colspan=12 align=center <%=light%>>
	<font face="arial"><b>Current Schedule</b></font></td>
<tr>
   <td colspan=3 align=right <%=light%>>
	<font face="arial" size=2><b>Dates</b></font></td>
   <td colspan=9 bgcolor="#c0c0c0">
	<input type="text" name="course_date" <%if fill=1 then%>value="<%=rs("course_date")%>"<%end if%> size=30></td>
<tr>
   <td colspan=3 align=right <%=light%>>
	<font face="arial" size=2><b>Times</b></font></td>
   <td colspan=9 bgcolor="#c0c0c0">
	<input type="text" name="course_time" <%if fill=1 then%>value="<%=rs("course_time")%>"<%end if%> size=30></td>
<tr>
   <td colspan=12 align=center <%=light%>>
	<font face="arial"><b>Future Schedule</b></font></td>
<tr>
<%
' write years

	n = 1
	for each y in Application("years")
		if n mod 2 <> 0 then
			color = "c0c0c0"
		else
			color = "dddddd"
		end if
		response.write "<td colspan='4' align='center'" _
			& " bgcolor='#" & color & "'>" _
			& "<font face='arial'>" & y & "</font></td>" & VbCrLf
		n = n + 1
	next

' write semesters

	response.write "<tr>"
	
	n = 1
	for each y in Application("years")
		if n mod 2 <> 0 then
			color = "c0c0c0"
		else
			color = "dddddd"
		end if
		for each s in Application("sems")
			response.write "<td colspan='2' align='center'" _
				& " bgcolor='#" & color & "'>" _
				& "<font face='arial' size=2>" & s & "</font></td>" & VbCrLf
		next
		n = n + 1
	next

	response.write "<tr>"

' write media types

	n = 1
	for each y in Application("years")
		if n mod 2 <> 0 then
			color = "c0c0c0"
		else
			color = "dddddd"
		end if
		for each s in Application("sems")
			for each m in Application("media")
				response.write "<td align='center'" _
					& " bgcolor='#" & color & "' width='8.3333333%'>" _
					& "<font face='arial' size=1>" & m & "</font><br>" _
					& "<input type='checkbox' name='" _
					& s & "_" & y & "_" & m & "'"
				if fill = 1 then
					if rs(s & "_" & y & "_" & m) = "True" then
						response.write " checked"
					end if
				end if
				response.write "></td>" & VbCrLf
			next
		next
		n = n + 1
	next
%>

<tr>
   <td colspan=12 align=center <%=light%>>
	<font face="arial"><b>Description</b></font></td>
<tr>
   <td colspan=12 bgcolor="#c0c0c0" align=center><textarea name="description" cols=45 rows=3 wrap="virtual"><%if fill=1 then%><%=rs("description")%><%end if%></textarea></td>
<tr>
	<td colspan=6 bgcolor="#c0c0c0">
	<font size=1 face="arial">Prerequisites</font>
	<input type="text" name="prerequisites" size=10 <%if fill=1 then%>value="<%=rs("prerequisites")%>"<%end if%>>
   </td>
	<td colspan=6 bgcolor="#c0c0c0" align=right>
	<input type="submit" value="<%=Request.QueryString("action")%>">
   </td>
<tr>
	<td colspan=12><font size=2>
*If the professor who teaches this class is employed at the Boise Center but not listed here you will first need to <a href="/employee/edit.asp?action=add&type=faculty&college=Engineering">add them to the database of Boise Center employees</a>.
	</td>
</table>
</center>

<%
end if

if fill=1 then rs.Close
db.Close
%>

<!--#include virtual="/footer.inc"-->