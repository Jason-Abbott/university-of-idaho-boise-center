<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<html>
<head><title>Boise Center Courses</title></head>

<% menu = "none" %>
<!--#INCLUDE VIRTUAL="./header.inc"-->
<tr>
   <td colspan=3>

<font face="arial" size=4 color="<%=lgreen%>">College of Engineering Course Administration</font><br>
<font size=2><i>Unauthorized users will be prosecuted to the full extent of the law</i></font>
<p>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "DELETE FROM courses_engineering WHERE discipline = '" & Request.Form("discipline") & "' AND course_number = '" & Request.Form("course_number") & "'"
Set rs = db.Execute(query)
%>

<%=Request.Form("discipline") & " " & Request.Form("course_number")%> has been
removed from the list of Engineering courses.
<ul>
<li>Return to <a href="./admin/course/engineering_course.asp">Engineering course administration</a>
<li>Return to the <a href="./admin">administration page</a>
</ul>

<!--#INCLUDE VIRTUAL="./footer.asp"-->
