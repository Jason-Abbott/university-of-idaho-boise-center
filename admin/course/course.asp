<%
if Request.Form("college") = "Engineering" then
   response.redirect("engineering_course.asp")
end if
%>

<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<html>
<head><title>Boise Center <%=Request.Form("college")%> Courses</title></head>

<% menu = "none" %>
<!--#INCLUDE VIRTUAL="./header.inc"-->
<tr>
   <td colspan=3>
   
<font face="arial" size=4 color="<%=lgreen%>">College of <%=Request.Form("college")%> Course Administration</font><br>
<font size=2><i>Unauthorized users will be prosecuted to the full extent of the law</i></font>

   </td>
</table>
<p>

<form action="added.asp" method="post">
<center>
<table cellspacing=0 cellpadding=3 border=0>
<tr>
   <td colspan=3 align=center><font size=4>Update the course listing</font></td>
<tr>
   <td colspan=2 align=center bgcolor="<%=grey%>">

<input type="radio" name="action" value="modify" checked>Modify
or<input type="radio" name="action" value="delete">Delete
<select name="course">

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
SQLquery = "SELECT course_number, discipline, section, crn FROM courses ORDER BY discipline, course_number, section"
Set rs = db.Execute(SQLquery)
Do While Not rs.EOF
%>
<option value="<%=rs("crn")%>"><%=rs("discipline") & " " & rs("course_number") & "-" & rs("section")%>
<%
rs.MoveNext
Loop
rs.Close
%>
   </select>
   </td>
   <td align=center bgcolor="<%=grey%>"><input type="submit" value="OK"></form></td>

<form action="added.asp" method="post">

<tr>
   <td colspan=3 align=center><font size=4><br>Add to the course listing</font></td>
<tr>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">Discipline</font></td>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">Number-Section</font></td>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">Instructor*</font></td>
<tr>
   <td align=center bgcolor="<%=grey%>"><select name="discipline">
      <option>Ed
      <option>Couns
      <option>AdEd
      <option>EdSp
      <option>EdTe
      <option>VocEd
      <option>EdAd
      <option>FCS
      <option>ITED
      </select>
   </td>
   <td align=center bgcolor="<%=grey%>"><input type="text" name="course_number" size=4>-<input type="text" name="section" size=2></td>
   <td align=center bgcolor="<%=grey%>"><select name="instructor"><option value="">Unspecified

<%
SQLquery = "SELECT email_name, name_first, name_last FROM faculty WHERE college = '" & Request.Form("college") & "' ORDER BY name_last"
Set rs = db.Execute(SQLquery)
Do While Not rs.EOF
%>
<option value="<%=rs("email_name")%>"><%=rs("name_first") & " " & rs("name_last")%>
<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

   </select>
   </td>
<tr>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">CRN</font></td>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">Credits</font></td>
   <td rowspan=4 align=center bgcolor="<%=grey%>"><input type="submit" value="OK"><p><input type="reset" value="Clear"></td>
<tr>
   <td align=center bgcolor="<%=grey%>"><input type="text" name="crn" size=5></td>
   <td align=center bgcolor="<%=grey%>"><input type="text" name="credits" size=3></td>
<tr>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">Grad Fee</font></td>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">Undergrad</font></td>
<tr>
   <td align=center bgcolor="<%=grey%>">$<input type="text" name="fee_grad" size=5></td>
   <td align=center bgcolor="<%=grey%>">$<input type="text" name="fee_ugrad" size=5></td>

<tr>
   <td bgcolor="<%=lgreen%>" align=right><font face="arial">Title</font></td>
   <td colspan=2 bgcolor="<%=grey%>"><input type="text" name="title" size=40></td>
<tr>
   <td bgcolor="<%=lgreen%>" align=right><font face="arial">Date(s)</font></td>
   <td colspan=2 bgcolor="<%=grey%>"><input type="text" name="course_date" size=40></td>
<tr>
   <td bgcolor="<%=lgreen%>" align=right><font face="arial">Time(s)</font></td>
   <td colspan=2 bgcolor="<%=grey%>"><input type="text" name="course_time" size=40></td>
<tr>
   <td align=center colspan=2 bgcolor="<%=lgreen%>"><font face="arial">Description</font></td>
   <td align=center bgcolor="<%=lgreen%>"><font face="arial">Location</font></td>
<tr>
   <td align=center colspan=2 bgcolor="<%=grey%>"><textarea name="description" cols=45 rows=3></textarea></td>
   <td valign=top align=center bgcolor="<%=grey%>"><select name="location"><option>Boise Center<option>Idaho Falls<option>Twin Falls</select></td>
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
