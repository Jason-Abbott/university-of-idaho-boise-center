<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<html>
<head><title>Boise Center Courses</title></head>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
SQLquery= "SELECT * FROM courses_engineering WHERE course_number = '" & Request.QueryString("course_number") & "' AND discipline = '" & Request.QueryString("discipline") & "'"
Set rs = db.Execute(SQLquery)
%>

<form action="engineering_modified.asp" method="post">
<center>
<table cellspacing=0 cellpadding=3 border=0>
<tr>
   <td colspan=4 align=center bgcolor="<%=lgreen%>"><font face="arial">Discipline</font></td>
   <td colspan=4 align=center bgcolor="<%=lgreen%>"><font face="arial">Number - Section</font></td>
   <td colspan=4 align=center bgcolor="<%=lgreen%>"><font face="arial">Instructor*</font></td>
<tr>
   <td colspan=4 align=center bgcolor="<%=grey%>"><input type="text" name="discipline" size=5 value="<%=rs("discipline")%>"></td>
   <td colspan=4 align=center bgcolor="<%=grey%>"><input type="text" name="course_number" size=7 value="<%=rs("course_number")%>"> - <input type="text" name="section" size=7 value="<%=rs("section")%>"></td>
   <td colspan=4 align=center bgcolor="<%=grey%>"><select name="instructor"><option value="">Unspecified

<%
SQLquery = "SELECT email_name, name_first, name_last FROM faculty WHERE college='Engineering' ORDER BY name_last"
Set rs2 = db.Execute(SQLquery)
Do While Not rs2.EOF
%>
<option value="<%=rs2("email_name")%>" <%if rs2("email_name") = rs("instructor") then%>selected<%end if%>><%=rs2("name_first") & " " & rs2("name_last")%>
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
   <td colspan=4 align=center bgcolor="<%=grey%>"><input type="text" name="crn" size=5 value="<%=rs("crn")%>"></td>
   <td colspan=6 align=center bgcolor="<%=grey%>"><input type="text" name="title" size=30 value="<%=rs("title")%>"></td>
   <td colspan=2 align=center bgcolor="<%=grey%>"><input type="text" name="credits" size=1 value="<%=rs("credits")%>"></td>
<tr>
   <td colspan=12 align=center bgcolor="<%=lgreen%>"><font face="arial">Current Schedule</font></td>
<tr>
   <td colspan=4 align=right bgcolor="<%=lgreen%>"><font face="arial" size=2>Dates</font></td>
   <td colspan=8 bgcolor="<%=grey%>"><input type="text" name="course_date" value="<%=rs("course_date")%>" size=30></td>
<tr>
   <td colspan=4 align=right bgcolor="<%=lgreen%>"><font face="arial" size=2>Times</font></td>
   <td colspan=8 bgcolor="<%=grey%>"><input type="text" name="course_time" value="<%=rs("course_time")%>" size=30></td>
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
   <td bgcolor="<%=grey%>" align=center><input type="checkbox" name="<%=x%>" <%if rs(x) = "True" then%>checked<%end if%>></td>
<% next %>

<tr>
   <td colspan=12 align=center bgcolor="<%=lgreen%>"><font face="arial">Description</font></td>
<tr>
   <td colspan=12 bgcolor="<%=grey%>"><center><textarea name="description" cols=35 rows=2><%=rs("description")%></textarea></center><br>
   <font size=1 face="arial">Prerequisites <input type="text" name="prerequisites" size=10 value="<%=rs("prerequisites")%>"></font>
   </td>
</table>

<input type="submit" value="OK"> <input type="reset" value="Clear">
</form>
<p>
<form action="./admin/employee/employee.asp" method="post">
<input type="hidden" name="action" value="add">
<input type="hidden" name="employee_type" value="faculty">
*<input type="submit" value="Add new instructor">
</form>

   </td>
</center>

<%
rs.Close
db.Close
%>

<!--#INCLUDE VIRTUAL="./footer.asp"-->
