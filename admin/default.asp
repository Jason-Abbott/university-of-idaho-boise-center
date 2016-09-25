<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<html>
<head><title>Web Site Administration</title></head>

<% menu = "none" %>
<!--#INCLUDE VIRTUAL="./header.inc"-->
<tr>
   <td colspan=3>

<font face="arial" size=4 color="<%=lgreen%>">Administration</font><br>
<font size=2><i>Unauthorized users will be prosecuted to the full extent of the law</i></font>
<p>
<center>
<table border=0 cellpadding=3 cellspacing=0>

<!-- EMPLOYEE SECTION -->

<tr>
   <td colspan=3 bgcolor="<%=lgreen%>"><font face="arial">Employees</font></td>
<tr>
   <td bgcolor="<%=grey%>">

<form action="./employee/employee.asp" method="post">
<input type="radio" name="action" value="modify">Modify,
<input type="radio" name="action" value="delete">Delete

   </td>
   <td bgcolor="<%=grey%>">

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT * FROM faculty ORDER BY name_last"
Set rs = db.Execute(query)
%>

<select name="name">

<% Do While Not rs.EOF %>
<option value="<%=rs("email_name") & " faculty"%>"><%=rs("name_first") & " " & rs("name_last") %>
<%
rs.MoveNext
Loop
%>

<%
query = "SELECT * FROM staff ORDER BY name_last"
Set rs = db.Execute(query)
%>

<% Do While Not rs.EOF %>
<option value="<%=rs("email_name") & " staff"%>"><%=rs("name_first") & " " & rs("name_last") %>
<%
rs.MoveNext
Loop
%>

</select>

   </td>
   <td rowspan=2 bgcolor="<%=lgreen%>"><input type="submit" value="OK"></td>
<tr>
   <td align=right bgcolor="<%=grey%>">or <input type="radio" name="action" value="add" checked>Add</td>
   <td bgcolor="<%=grey%>"><select name="employee_type"><option value="staff">Staff member<option value="faculty">Faculty member</select></form></td>

<% rs.Close %>

<!-- COURSE SECTION -->

<tr>
   <td colspan=3 bgcolor="<%=lgreen%>"><font face="arial">Courses</font></td>
<tr>
   <td bgcolor="<%=grey%>" align=right><form action="./course/course.asp" method="post">Edit course listing for</td>
   <td bgcolor="<%=grey%>"><select name="college"><option>Agriculture<option>Education<option>Engineering</select></td>
   <td bgcolor="<%=lgreen%>"><input type="submit" value="OK"></td>
</table>
</center>

<!--#INCLUDE VIRTUAL="./footer.asp"-->
