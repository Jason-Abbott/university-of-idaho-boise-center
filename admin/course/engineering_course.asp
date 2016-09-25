<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<html>
<head><title>Boise Center Engineering Courses</title></head>

<% menu = "none" %>
<!--#INCLUDE VIRTUAL="./header.inc"-->
<tr>
   <td colspan=3>
   
<font face="arial" size=4 color="<%=lgreen%>">College of Engineering Course Administration</font><br>
<font size=2><i>Unauthorized users will be prosecuted to the full extent of the law</i></font>

   </td>
</table>
<p>

<form action="engineering_added.asp" method="post">
<center>
<table cellspacing=0 cellpadding=3 border=0>
<tr>
   <td colspan=12 align=center><font size=4>Update the course listing</font></td>
<tr>
   <td colspan=12 align=center valign=center bgcolor="<%=grey%>">

<input type="radio" name="action" value="modify" checked>Modify
or<input type="radio" name="action" value="delete">Delete
<select name="course">

<%
Session("engineering_dates") = array("fall_1997_live", "fall_1997_video", "spring_1998_live", "spring_1998_video", "fall_1998_live", "fall_1998_video", "spring_1999_live", "spring_1999_video", "fall_1999_live", "fall_1999_video", "spring_2000_live", "spring_2000_video")
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
SQLquery = "SELECT course_number, discipline FROM courses_engineering ORDER BY discipline, course_number"
Set rs = db.Execute(SQLquery)
Do While Not rs.EOF
%>
<option value="<%=rs("discipline") & " " & rs("course_number")%>"><%=rs("discipline") & " " & rs("course_number")%>
<%
rs.MoveNext
Loop
rs.Close
%>
   </select> <input type="submit" value="OK"></form>
   </td>
<form action="engineering_added.asp" method="post">
<form action="engineering_added.asp" method="post">
<tr>
   <td colspan=12 align=center><font size=4>Add to the course listing</font></td>
<tr>
   <td colspan=4 align=center bgcolor="<%=lgreen%>"><font face="arial">Discipline</font></td>
   <td colspan=4 align=center bgcolor="<%=lgreen%>"><font face="arial">Number - Section</font></td>
   <td colspan=4 align=center bgcolor="<%=lgreen%>"><font face="arial">Instructor*</font></td>
<tr>
   <td colspan=4 align=center bgcolor="<%=grey%>"><input type="text" name="discipline" size=5></td>
   <td colspan=4 align=center bgcolor="<%=grey%>"><input type="text" name="course_number" size=7> - <input type="text" name="section" size=7></td>
   <td colspan=4 align=center bgcolor="<%=grey%>"><select name="instructor"><option value="">Unspecified

<%
SQLquery = "SELECT email_name, name_first, name_last FROM faculty WHERE college='Engineering' ORDER BY name_last"
Set rs2 = db.Execute(SQLquery)
Do While Not rs2.EOF
%>
<option value="<%=rs2("email_name")%>"><%=rs2("name_first") & " " & rs2("name_last")%>
<%
rs2.MoveNext
Loop
rs2.Close
%>
   </select>
   </td>
<tr>
   <td colspan=4 align=center bgcolor="<%=lgreen%>"><font face="arial">CRN</font></td>
   <td colspan=6 align=center bgcolor="<%=lgreen%>"><font face="arial">Title</font></td>
   <td colspan=2 align=center bgcolor="<%=lgreen%>"><font face="arial">Credits</font></td>
<tr>
   <td colspan=4 align=center bgcolor="<%=grey%>"><input type="text" name="crn" size=5></td>
   <td colspan=6 align=center bgcolor="<%=grey%>"><input type="text" name="title" size=30></td>
   <td colspan=2 align=center bgcolor="<%=grey%>"><input type="text" name="credits" size=1></td>
<tr>
   <td colspan=12 align=center bgcolor="<%=lgreen%>"><font face="arial">Current Schedule</font></td>
<tr>
   <td colspan=4 align=right bgcolor="<%=lgreen%>"><font face="arial" size=2>Dates</font></td>
   <td colspan=8 bgcolor="<%=grey%>"><input type="text" name="course_date" size=30></td>
<tr>
   <td colspan=4 align=right bgcolor="<%=lgreen%>"><font face="arial" size=2>Times</font></td>
   <td colspan=8 bgcolor="<%=grey%>"><input type="text" name="course_time" size=30></td>
<tr>
   <td colspan=12 align=center bgcolor="<%=lgreen%>"><font face="arial">Future Schedule</font></td>
<tr>
   <td colspan=2 align=center bgcolor="<%=grey%>"><font face="arial">1997</font></td>
   <td colspan=4 align=center><font face="arial">1998</font></td>
   <td colspan=4 align=center bgcolor="<%=grey%>"><font face="arial">1999</font></td>
   <td colspan=2 align=center><font face="arial">2000</font></td>
<tr>
   <td colspan=2 align=center bgcolor="<%=grey%>"><font face="arial" size=1>Fall</font></td>
   <td colspan=2 align=center><font face="arial" size=1>Spring</font></td>
   <td colspan=2 align=center><font face="arial" size=1>Fall</font></td>
   <td colspan=2 align=center bgcolor="<%=grey%>"><font face="arial" size=1>Spring</font></td>
   <td colspan=2 align=center bgcolor="<%=grey%>"><font face="arial" size=1>Fall</font></td>
   <td colspan=2 align=center><font face="arial" size=1>Spring</font></td>
<tr>
   <td align=center bgcolor="<%=grey%>"><font face="arial" size=1>L</font></td>
   <td align=center bgcolor="<%=grey%>"><font face="arial" size=1>V</font></td>
   <td align=center><font face="arial" size=1>L</font></td>
   <td align=center><font face="arial" size=1>V</font></td>
   <td align=center><font face="arial" size=1>L</font></td>
   <td align=center><font face="arial" size=1>V</font></td>
   <td align=center bgcolor="<%=grey%>"><font face="arial" size=1>L</font></td>
   <td align=center bgcolor="<%=grey%>"><font face="arial" size=1>V</font></td>
   <td align=center bgcolor="<%=grey%>"><font face="arial" size=1>L</font></td>
   <td align=center bgcolor="<%=grey%>"><font face="arial" size=1>V</font></td>
   <td align=center><font face="arial" size=1>L</font></td>
   <td align=center><font face="arial" size=1>V</font></td>
<tr>

<% for each x in Session("engineering_dates") %>
   <td bgcolor="<%=grey%>" align=center><input type="checkbox" name="<%=x%>"></td>
<% next %>

<tr>
   <td colspan=12 align=center bgcolor="<%=lgreen%>"><font face="arial">Description</font></td>
<tr>
   <td colspan=12 bgcolor="<%=grey%>"><center><textarea name="description" cols=35 rows=2></textarea></center><br>
   <font size=1 face="arial">Prerequisites <input type="text" name="prerequisites" size=10></font><input type="submit" value="OK"> <input type="reset" value="Clear">
   </td>
</table>
</form>
<p>
<font size=2>
*If the course you're adding is taught by a professor<br>
who isn't listed you will have to return to the<br>
<a href="./admin">main administration page</a> and add them under<br>
the "employees" section.
</font>
   </td>
</center>


<!--#INCLUDE VIRTUAL="./footer.asp"-->
