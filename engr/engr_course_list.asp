<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 03/18/98
-->

<html>
<body bgcolor="#FFFFFF" link="#800000" vlink="#800000" alink="#E4C721">

<%
dim combine, query, n, colorlo, colorhi, x, course

combine = ""

if Not Request.Form("discipline") = "All" then
   query = "discipline = '" & Request.Form("discipline") & "'"
   combine = " AND "
end if

if Request.Form("course_number") <> "" then
   query = query & combine & "course_number LIKE '%" & Request.Form("course_number") & "%'"
   combine = " AND "
end if

if Request.Form("title") <> "" then
   query = query & combine & "title LIKE '%" & Request.Form("title") & "%'"
   combine = " AND "
end if

if Request.Form("instructor") <> "Unspecified" then
   query = query & combine & "instructor = '" & Request.Form("instructor") & "'"
   combine = " AND "
end if

if Request.Form("scope") <> "future" then
   query = query & combine & "(" & Request.Form("scope") & "_live = -1 OR " & Request.Form("scope") & "_video = -1)"
end if

if query <> "" then
	query = "SELECT * FROM courses_engr WHERE " & query & " ORDER BY discipline, course_number"
else
	query = "SELECT * FROM courses_engr ORDER BY discipline, course_number"
end if

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)

if rs.EOF = -1 then
%>

<!-- IF NO RECORDS ARE FOUND ----------------------------->

<b><font size="5">N</font>o courses were found matching the criteria you specified.</b>

<%    if Request.Form("instructor") <> "Unspecified" then%>

Please note that our online course list is a work in progress and many courses
are not yet associated with an instructor.  Try your search again without
specificying an instructor.  We apologize for this inconvenience.

<%    end if%>

If you believe that the parameters you've specified are correct then please
call us at (208) 364-4085.  We would be happy to assist you.

<%else%>

<!-- LIST COURSES ---------------------------------------->

<center>
<table cellpadding="2" cellspacing="0" border="0">
<tr>
   <td align="center"><font size="2">
	<i>Click on the course<br>number for more details</i></font></td>
   <td colspan="3" align="center">
	<img src="../graphics/live.gif" width="20" height="19">Live</td>
   <td colspan="3" align="center">
	<img src="../graphics/video.gif" width="21" height="20">
	<a href="http://www.uidaho.edu/evo/" target=_top>Video</a></td>

<tr>
   <td rowspan="2" align="center" bgcolor="#800000" width=200>
	<font face="arial" color="#ffffff"><b>Course</b></font></td>

<%

years = array(1998,1999,2000)
sems = array("Spring","Fall")

for each y in years
	response.write "<td colspan='2' align='center' bgcolor='#800000'>" _
		& "<font face='arial' size='2' color='#ffffff'>" _
		& y & "</font></td>"
next

response.write "<tr>"

n = 1
for each y in years
	for each s in sems
		if n mod 2 <> 0 then
			color = "dddddd"
		else
			color = "cccccc"
		end if

		response.write "<td align='center' bgcolor='#" _
			& color & "' width=35><font face='arial' size='1'>" _
			& s & "</font></td>"
		n = n + 1
	next
next

n = 1
Do While Not rs.EOF
	if n mod 2 <> 0 then
		colorlo = "cccccc"
		colorhi = "dddddd"
	else
		colorlo = "eeeeee"
		colorhi = "ffffff"
	end if
	n = n + 1

	response.write "<tr><td width=200 bgcolor='#" _
		& colorlo & "'><font size='2'><a href='" _
		& "engr_course_detail.asp?course_number=" _
		& rs("course_number") & "&discipline=" _
		& rs("discipline") & "'>" & rs("discipline") _
		& rs("course_number") & "</a></font><br>" _
		& rs("title") & "</td>"

'	for each x in Application("engineering_dates")
'		response.write "<td align='center' width=35 bgcolor='#" _
'			& colorhi & "'>"
'		if rs(x) = "True" then
'			response.write "<img src='/graphics/live.gif'>"
'		else
'			response.write "&nbsp;"
'		end if
'		if
		
'	course = split(x,"_",-1,1)

'	for each y in years
'		response.write "<td align='center' width=35 bgcolor='#" _
'			& colorhi & "'>"

%>
   <td align="center" width=35 bgcolor="#<%=colorhi%>">  
<% if rs("spring_1998_live") = "True" then %>
	<img src="../graphics/live.gif">
<% else %>&nbsp;<% end if %>
<% if rs("spring_1998_video") = "True" then %>
	<img src="../graphics/video.gif">
<% else %>&nbsp;<% end if %>
   </td>

   <td align="center" width=35 bgcolor="#<%=colorlo%>">
<% if rs("fall_1998_live") = "True" then %>
	<img src="../graphics/live.gif">
<% else %>&nbsp;<% end if %>
<% if rs("fall_1998_video") = "True" then %>
	<img src="../graphics/video.gif">
<% else %>&nbsp;<% end if %>
   </td>

   <td align="center" width=35 bgcolor="#<%=colorhi%>">
<% if rs("spring_1999_live") = "True" then %>
	<img src="../graphics/live.gif">
<% else %>&nbsp;<% end if %>
<% if rs("spring_1999_video") = "True" then %>
	<img src="../graphics/video.gif">
<% else %>&nbsp;<% end if %>
   </td>

   <td align="center" width=35 bgcolor="#<%=colorlo%>">
<% if rs("fall_1999_live") = "True" then %>
	<img src="../graphics/live.gif">
<% else %>&nbsp;<% end if %>
<% if rs("fall_1999_video") = "True" then %>
	<img src="../graphics/video.gif">
<% else %>&nbsp;<% end if %>
   </td>

   <td align="center" width=35 bgcolor="#<%=colorhi%>">
<% if rs("spring_2000_live") = "True" then %>
	<img src="../graphics/live.gif" width="20" height="19">
<% else %>&nbsp;<% end if %>
<% if rs("spring_2000_video") = "True" then %>
	<img src="../graphics/video.gif" width="21" height="20">
<% else %>&nbsp;<% end if %>
   </td>

   <td align="center" width=35 bgcolor="#<%=colorlo%>">
<% if rs("fall_2000_live") = "True" then %>
	<img src="../graphics/live.gif" width="20" height="19">
<% else %>&nbsp;<% end if %>
<% if rs("fall_2000_video") = "True" then %>
	<img src="../graphics/video.gif" width="21" height="20">
<% else %>&nbsp;<% end if %>
   </td>

<%
rs.MoveNext
Loop
end if
rs.Close
db.Close
%>

<tr>
   <td rowspan="2" align="center" bgcolor="#800000" width=200>
	<font face="arial" color="#ffffff"><b>Course</b></font></td>
   <td align="center" bgcolor="#dddddd" width=35>
	<font face="arial" size="1">Spring</font></td>
   <td align="center" bgcolor="#cccccc" width=35>
	<font face="arial" size="1">Fall</font></td>
   <td align="center" bgcolor="#dddddd" width=35>
	<font face="arial" size="1">Spring</font></td>
   <td align="center" bgcolor="#cccccc" width=35>
	<font face="arial" size="1">Fall</font></td>
   <td align="center" bgcolor="#dddddd" width=35>
	<font face="arial" size="1">Spring</font></td>
	<td align="center" bgcolor="#cccccc" width=35>
	<font face="arial" size="1">Fall</font></td>

<tr>
<%
for each y in years
	response.write "<td colspan='2' align='center' bgcolor='#800000'>" _
		& "<font face='arial' size='2' color='#ffffff'>" _
		& y & "</font></td>"
next
%>

<tr>
   <td align="center"><font size="2">
	<i>Click on the course<br>number for more details</i></font></td>
   <td colspan="3" align="center">
	<img src="../graphics/live.gif" width="20" height="19">Live</td>
   <td colspan="3" align="center">
	<img src="../graphics/video.gif" width="21" height="20">
	<a href="http://www.uidaho.edu/evo/" target=_top>Video</a></td>
</table>
</center>
</body>
</html>
