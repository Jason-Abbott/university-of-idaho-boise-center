<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<%
course = split(Request.Form("course"))

if Request.Form("action") = "modify" then
   response.redirect "engineering_modify.asp?course_number=" & course(1) & "&discipline=" & course(0)
elseif Request.Form("action") = "delete" then
   response.redirect "engineering_delete.asp?course_number=" & course(1) & "&discipline=" & course(0)
end if
%>

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
query = "INSERT INTO courses_engineering (discipline, course_number, instructor, title, crn, section, course_date, course_time, "

for each x in Session("engineering_dates")
   query = query & x & ", "
next

query = query & "credits, prerequisites, description) VALUES ("
query = query & "'" & Request.Form("discipline") & "', "
query = query & "'" & Request.Form("course_number") & "', "
query = query & "'" & Request.Form("instructor") & "', "
query = query & "'" & Request.Form("title") & "', "
query = query & "'" & Request.Form("crn") & "', "
query = query & "'" & Request.Form("section") & "', "
query = query & "'" & Request.Form("course_date") & "', "
query = query & "'" & Request.Form("course_time") & "', "

for each x in Session("engineering_dates")
   if Request.Form(x) = "on" then
      value = "1"
   else
      value = "0"
   end if
   query = query & "'" & value & "', "
next

query = query & "'" & Request.Form("credits") & "', "
query = query & "'" & Request.Form("prerequisites") & "', "
query = query & "'" & Request.Form("description") & "')"

Set rs = db.Execute(query)
%>

<b>Congratulations</b><p>
<%=Request.Form("discipline") & " " & Request.Form("course_number")%> has been added to the Boise Center course listing.
<ul>


<li><a href="./courses/engineering_detail.asp?course_number=<%=Request.Form("course_number")%>&discipline=<%=Request.Form("discipline")%>">
View</a> the new <%=Request.Form("discipline") & " " & Request.Form("course_number")%> listing
<li>Return to <a href="./admin/course/engineering_course.asp">Engineering course administration</a>
<li>Return to the <a href="./admin">administration page</a>
</ul>

<!--#INCLUDE VIRTUAL="./footer.asp"-->
