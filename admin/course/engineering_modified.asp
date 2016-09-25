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
query = "UPDATE courses_engineering SET "
query = query & "discipline = '" & Request.Form("discipline") & "', "
query = query & "course_number = '" & Request.Form("course_number") & "', "
query = query & "instructor = '" & Request.Form("instructor") & "', "
query = query & "title = '" & Request.Form("title") & "', "
query = query & "crn = '" & Request.Form("crn") & "', "
query = query & "section = '" & Request.Form("section") & "', "
query = query & "course_date = '" & Request.Form("course_date") & "', "
query = query & "course_time = '" & Request.Form("course_time") & "', "

for each x in Session("engineering_dates")
   if Request.Form(x) = "on" then
      value = "1"
   else
      value = "0"
   end if
   query = query & x & " = '" & value & "', "
next

if Request.Form("credits") <> "" then
   query = query & "credits = '" & Request.Form("credits") & "', "
end if

query = query & "prerequisites = '" & Request.Form("prerequisites") & "', "
query = query & "description = '" & Request.Form("description") & "'"
query = query & " WHERE discipline = '" & Request.Form("discipline") & "' AND course_number = '" & Request.Form("course_number") & "'"

Set rs = db.Execute(query)
%>

<b>Congratulations</b><p>
The <%=Request.Form("discipline") & " " & Request.Form("course_number")%> record has been updated.
<ul>
<li><a href="./courses/engineering_detail.asp?discipline=<%=Request.Form("discipline")%>&course_number=<%=Request.Form("course_number")%>">View</a> the updated <%=Request.Form("discipline") & " " & Request.Form("course_number")%> listing</a>
<li>Return to <a href="./admin/course/engineering_course.asp">Engineering course administration</a>
<li>Return to the <a href="./admin">administration page</a>
</ul>

<!--#INCLUDE VIRTUAL="./footer.asp"-->
