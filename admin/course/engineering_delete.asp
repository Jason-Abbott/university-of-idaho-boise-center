<!--#INCLUDE VIRTUAL="./restrict.asp"-->

<html>
<head><title>Boise Center Courses</title></head>

<% menu = "none" %>
<!--#INCLUDE VIRTUAL="./header.inc"-->
<tr>
   <td colspan="3">
   
<font face="arial" size="4" color="<%=lgreen%>">College of Engineering Course Administration</font><br>
<font size="2"><i>Unauthorized users will be prosecuted to the full extent of the law</i></font>

   </td>
</table>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
SQLquery= "SELECT * FROM courses_engineering WHERE course_number = '" & Request.QueryString("course_number") & "' AND discipline = '" & Request.QueryString("discipline") & "'"
Set rs = db.Execute(SQLquery)
%>

<form action="engineering_deleted.asp" method="post">

Press &quot;Delete&quot; if you are sure that you want to erase this course
<p>
<table cellpadding="3" cellspacing="1" border="0">
<tr>
   <td rowspan="2" align="center"><input type="submit" value="Delete"></td>
   <td align="center" bgcolor="<%=grey%>"><font face="arial" size="2&quot;">1997</td>
   <td colspan="2" align="center" bgcolor="<%=grey%>"><font face="arial" size="2&quot;">1998</td>
   <td colspan="2" align="center" bgcolor="<%=grey%>"><font face="arial" size="2&quot;">1999</td>
   <td align="center" bgcolor="<%=grey%>"><font face="arial" size="2&quot;">2000</td>
   <td rowspan="3"><img src="../graphics/live.gif" width="20" height="19">Live<br><img src="../graphics/video.gif" width="21" height="20"><a href="http://www.uidaho.edu/evo/">Video</a>
<tr>
   <td align="center" bgcolor="<%=grey%>"><font face="arial" size="1&quot;">Fall</td>
   <td align="center" bgcolor="<%= lgreen %>"><font face="arial" size="1&quot;">Spring</td>
   <td align="center" bgcolor="<%=grey%>"><font face="arial" size="1&quot;">Fall</td>
   <td align="center" bgcolor="<%= lgreen %>"><font face="arial" size="1&quot;">Spring</td>
   <td align="center" bgcolor="<%=grey%>"><font face="arial" size="1&quot;">Fall</td>
   <td align="center" bgcolor="<%=lgreen%>"><font face="arial" size="1&quot;">Spring</td>
   
<tr>
   <td bgcolor="<%=lgreen%>"><font size="2"><%= rs("discipline") %>&nbsp;<%= rs("course_number") %></font><br><%= rs("title") %></td>
   <td align="center">
<% if rs("fall_1997_live") = "True" then %><img src="../graphics/live.gif" width="20" height="19"><% end if %>
<% if rs("fall_1997_video") = "True" then %><img src="../graphics/video.gif" width="21" height="20"><% end if %>
   </td>
   <td bgcolor="<%=lgreen%>" align="center">
<% if rs("spring_1998_live") = "True" then %><img src="../graphics/live.gif" width="20" height="19"><% end if %>
<% if rs("spring_1998_video") = "True" then %><img src="../graphics/video.gif" width="21" height="20"><% end if %>
   </td>
   <td align="center">
<% if rs("fall_1998_live") = "True" then %><img src="../graphics/live.gif" width="20" height="19"><% end if %>
<% if rs("fall_1998_video") = "True" then %><img src="../graphics/video.gif" width="21" height="20"><% end if %>
   </td>
   <td bgcolor="<%=lgreen%>" align="center">
<% if rs("spring_1999_live") = "True" then %><img src="../graphics/live.gif" width="20" height="19"><% end if %>
<% if rs("spring_1999_video") = "True" then %><img src="../graphics/video.gif" width="21" height="20"><% end if %>
   </td>
   <td align="center">
<% if rs("fall_1999_live") = "True" then %><img src="../graphics/live.gif" width="20" height="19"><% end if %>
<% if rs("fall_1999_video") = "True" then %><img src="../graphics/video.gif" width="21" height="20"><% end if %>
   </td>
   <td bgcolor="<%=lgreen%>" align="center">
<% if rs("spring_2000_live") = "True" then %><img src="../graphics/live.gif" width="20" height="19"><% end if %>
<% if rs("spring_2000_video") = "True" then %><img src="../graphics/video.gif" width="21" height="20"><% end if %>
   </td>
</table>
<p>
<font size="4" color="#ff0000">This action is not reversable</font>

<input type="hidden" name="discipline" value="<%=rs("discipline")%>">
<input type="hidden" name="course_number" value="<%=rs("course_number")%>">

<%
rs.Close
db.Close
%>

</form>
<!--#INCLUDE VIRTUAL="./footer.asp"-->
