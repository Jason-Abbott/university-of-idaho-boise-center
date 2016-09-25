<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<%
course = split(Request.Form("course"))

if Request.Form("action") = "modify" then
   response.redirect "modify.asp?course_number=" & course(2) & "&discipline=" & course(1) & "&section=" & course(0)
elseif Request.Form("action") = "delete" then
   response.redirect "delete.asp?course_number=" & course(2) & "&discipline=" & course(1) & "&section=" & course(0)
end if
%>

<html>
<head><title>Boise Center Courses</title></head>

<% menu = "none" %>
<!--#INCLUDE VIRTUAL="./header.inc"-->
<tr>
   <td colspan=3>
   
<font face="arial" size=4 color="<%=lgreen%>">Course Administration</font><br>
<font size=2><i>Unauthorized users will be prosecuted to the full extent of the law</i></font>
<p>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
'test = "INSERT INTO courses (location, description, course_time, discipline, course_number, section, instructor) VALUES ('Boise Center', '', '', 'ZZ', '999', '94', 'Bob')"
query = "INSERT INTO courses ("

for each x In Request.Form
   query = query & x & ", "
next
query = Left(query, Len(query)-2)
query = query & ") VALUES ("

for each x In Request.Form
   query = query & "'" & Request.Form(x) & "', "
next

query = Left(query, Len(query)-2)
query = query & ")"

Set rs = db.Execute(query)
%>

<%=query%><p>
<%=test%><p>
<p>
<b>Congratulations</b><p>
<%=Request.Form("discipline") & " " & Request.Form("course_number") & "-" & Request.Form("section")%> has been added to the Boise Center course listing.
<ul>

<form action="./courses/engineering_courses.asp" method="post">
<input type="hidden" name="course_number" value="<%=Request.Form("course_number")%>">
<input type="hidden" name="discipline" value="<%=Request.Form("discipline")%>">
<input type="hidden" name="title" value="">

<li><input type="submit" value="View"> the new <%=Request.Form("discipline") & " " & Request.Form("course_number")%> listing</a>
</form>
<li>Return to the <a href="./admin">administration page</a>
</ul>

<!--#INCLUDE VIRTUAL="./footer.asp"-->
