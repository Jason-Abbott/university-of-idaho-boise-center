<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/12/97
-->

<html>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">
<center>

<!--#include file="../authenticate.inc"-->
<%
dim fill, db, rs, form, i, college, college_list

' must use session variable here because the SQL is
' generated by cycling through the form variables
' which can't include employee_type

if Request.QueryString("action") = "add" then
   form = "added"
	Session("type") = Request.QueryString("type")
	college = Request.QueryString("college")

' the fill variable determines whether the form
' should be populated with data
	
   fill = 0
else
   form = "updated"
   fill = 1
   
   Set db = Server.CreateObject("ADODB.Connection")
   db.Open "bc"
   query = "SELECT * FROM employee WHERE email_name = '" & Request.QueryString("email_name") & "'"
   Set rs = db.Execute(query)
	
	Session("type") = rs("type")
	college = rs("college")
end if

' create an array of college choices

college_list = array( _
	"Agriculture", _
	"Engineering", _
	"Education", _
	"Forestry", _
	"Law", _
	"Letters and Sciences", _
	"Other")
%>

<!-- DELETION FORM --------------------------------------->

<% if Request.QueryString("action") = "delete" then %>

<form action="deleted.asp" method="post">

<font size=5>
Press "Delete" if you are sure that you want to delete
<b><%=rs("name_first") & " " & rs("name_last")%></b> of <%=rs("college")%>
from the <%=rs("type")%> database.
<p>
<font color="#ff0000">This action is not reversable.</font></font>

<input type="hidden" name="email_name" value="<%=rs("email_name")%>">
<input type="hidden" name="college" value="<%=rs("college")%>">
<input type="submit" value="delete">
</form>

<!-- MODIFY FORM, COMMON FIELDS -------------------------->

<% else %>

<form action="<%=form%>.asp" method="post">

<table cellspacing=0 cellpadding=3 border=0>

<!-- name -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Name</td>
<tr>
   <td colspan=3 bgcolor="#C0C0C0" align=center><font face="arial" size=1>

<% if Session("type") = "faculty" then %>	
   Title <input type="text" name="title" <%if fill=1 then%>value="<%=rs("title")%>"<%end if%> size=4>
<% end if %>

   First <input type="text" name="name_first" <%if fill=1 then%>value="<%=rs("name_first")%>"<%end if%> size=10>
   Last <input type="text" name="name_last" <%if fill=1 then%>value="<%=rs("name_last")%>"<%end if%> size=10>
   </td>

<!-- contact information -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Contact Information</td>
<tr>
   <td align=center bgcolor="#C0C0C0" colspan=3>
	<font face="arial" size=2>
	(208) 364-<input type="text" name="phone" <%if fill=1 then%>value="<%=rs("phone")%>"<%end if%> size=4>     
   <input type="text" name="email_name" <%if fill=1 then%>value="<%=rs("email_name")%>"<%end if%> size=10>@<input type="text" name="email_site" <%if fill=1 then%>value="<%=rs("email_site")%>"<%end if%> size=25></font></td>

<!-- position -->

<tr>
   <td bgcolor="#800000" align=right>
	<font face="arial" size="2" color="#FFFFFF">Position</td>
   <td bgcolor="#C0C0C0" colspan=2><input type="text" name="position" <%if fill=1 then%>value="<%=rs("position")%>"<%end if%> size=40></td>

<!-- college -->

<tr>
   <td bgcolor="#800000" align=right>
	<font face="arial" size="2" color="#FFFFFF">College</td>
   <td bgcolor="#C0C0C0" colspan=2>
	<select name="college">
<%
	for each i in college_list
		response.write "<option"
		if college = i then
			response.write " selected"
		end if
		response.write ">" & i & VbCrLf
	next
%>
	</select>
	</td>

<!--- FACULTY MODIFY ------------------------------------->

<%	if Session("type") = "faculty" then %>

<!-- discipline -->

<tr>
   <td bgcolor="#800000" align=right>
	<font face="arial" size="2" color="#FFFFFF">Discipline</td>
   <td bgcolor="#C0C0C0" colspan=2><input type="text" name="area" <%if fill=1 then%>value="<%=rs("area")%>"<%end if%> size=40></td>

<!-- education -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Education</td>
<tr>
   <td align=center bgcolor="#C0C0C0"><font face="arial" size=1>Degree(s)</td>
   <td align=center bgcolor="#C0C0C0"><font face="arial" size=1>Location</td>
   <td align=center bgcolor="#C0C0C0"><font face="arial" size=1>Date</td>

<%		for i = 1 to 4 %>

<tr>
   <td align=center bgcolor="#C0C0C0"><b><%=i%></b>
	<input type="text" name="degree<%=i%>_type" <%if fill=1 then%>value="<%=rs("degree"&i&"_type")%>"<%end if%> size=10></td>
   <td align=center bgcolor="#C0C0C0">
	<input type="text" name="degree<%=i%>_place" <%if fill=1 then%>value="<%=rs("degree"&i&"_place")%>"<%end if%> size=40></td>
   <td align=center bgcolor="#C0C0C0">
	<input type="text" name="degree<%=i%>_date" <%if fill=1 then%>value="<%=rs("degree"&i&"_date")%>"<%end if%> size=4></td>

<%		next %>

<!-- emphasis -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Emphasis</font></td>
<tr>
   <td colspan=3 align=center bgcolor="#C0C0C0"><textarea name="emphasis" cols=50 rows=4><%if fill=1 then%><%=rs("emphasis")%><%end if%></textarea></td>

<!-- experience -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Experience</font></td>
<tr>
   <td align=center bgcolor="#C0C0C0"><font face="arial" size=1>Time</td>
   <td align=center bgcolor="#C0C0C0"><font face="arial" size=1>Description</td>
   <td bgcolor="#C0C0C0"> </td>

<%		for i = 1 to 4 %>

<tr>
   <td bgcolor="#C0C0C0" colspan=3><b><%=i%></b>
	<input type="text" name="exp<%=i%>_time" <%if fill=1 then%>value="<%=rs("exp"&i&"_time")%>"<%end if%> size=20><br>
   <center><textarea name="exp<%=i%>_desc" cols=50 rows=2><%if fill=1 then%><%=rs("exp"&i&"_desc")%><%end if%></textarea></center></td>

<%		next %>

<!-- scholarship -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Scholarship</font></td>
<tr>
   <td colspan=3 align=center bgcolor="#C0C0C0">
	<textarea name="scholarship" cols=50 rows=4><%if fill=1 then%><%=rs("scholarship")%><%end if%></textarea></td>

<!-- STAFF MODIFY ---------------------------------------->

<%	elseif Session("type") = "staff" then %>

<!-- duties -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Duties</td>

<%		for i = 1 to 6 %>

<tr>
   <td colspan=3 align=center bgcolor="#C0C0C0"><b><%=i%></b>
	<input type="text" name="duty<%=i%>" <%if fill=1 then%>value="<%=rs("duty"&i)%>"<%end if%> size=50></td>

<%		next %>

<!-- projects -->

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Projects</td>

<%		for i = 1 to 6 %>

<tr>
   <td colspan=3 align=center bgcolor="#C0C0C0"><b><%=i%></b>
	<input type="text" name="project<%=i%>" <%if fill=1 then%>value="<%=rs("project"&i)%>"<%end if%> size=50></td>

<% 	next %>

<!-- COMMON FIELDS --------------------------------------->

<% end if %>

<!-- custom links -->

<tr>
   <td colspan=3 align=center bgcolor="#800000">
	<font face="arial" color="#FFFFFF">Custom Links</font></td>

<%		for i = 1 to 6 %>

<tr>
   <td bgcolor="#C0C0C0" colspan=3 align=center><b><%=i%></b>
	<input type="text" name="site<%=i%>_description" <%if fill=1 then%>value="<%=rs("site"&i&"_description")%>"<%end if%> size=15>
   <font face="arial" size=2>http://<input type="text" name="site<%=i%>_url" <%if fill=1 then%>value="<%=rs("site"&i&"_url")%>"<%end if%> size=30></font></td>

<%		next %>

<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF">Leave these as is if unsure
	</font></td>

<!-- room number -->

<tr>
	<td bgcolor="#800000" align=right>
	<font face="arial" color="#FFFFFF" size=2>Room</font></td>
	<td bgcolor="#c0c0c0" colspan=2><font face="arial" size=2>
	<input type="text" name="room" <%if fill=1 then%>value="<%=rs("room")%>"<%end if%> size=2>
	(<a href="./map/floor_med.asp">Here</a> is a map, or use "7th" if on 7th floor)
	</font></td>

<!-- ip address -->

<tr>
	<td bgcolor="#800000" align=right>
	<font face="arial" color="#FFFFFF" size=2>IP</font></td>
	<td bgcolor="#c0c0c0" colspan=2><font face="arial" size=2>
	129.101.93.<input type="text" name="ip" value="
<%
		if fill=1 then
			response.write rs("ip")
		else
			response.write "0"
		end if
%>
	" size=3>
	(You are currently at <%=Request.ServerVariables("REMOTE_ADDR")%>)
	</font></td>

<!-- hardware address -->

<tr>
	<td bgcolor="#800000" align=right>
	<font face="arial" color="#FFFFFF" size=2>MAC</font></td>
	<td bgcolor="#c0c0c0" colspan=2><font face="arial" size=2>
	<input type="text" name="mac" <%if fill=1 then%>value="<%=rs("mac")%>"<%end if%> size=12>
	(Ethernet address)
	</font></td>

<!-- submit button -->

<tr>
	<td bgcolor="#800000" align=right>&nbsp;</td>
	<td bgcolor="#c0c0c0" align=right colspan=2>
	<input type="submit" value="<%=Request.QueryString("action")%>"></td>

<!-- last updated information -->

<%		if fill = 1 then %>
<tr>
	<td colspan=3 bgcolor="#800000" align=center>
	<font color="#ffffff" size=1 face="arial">
	(Last updated <%=rs("update_time")%> from machine <%=rs("update_machine")%>)
	</font></td>
<%		end if %>

</table>
</form>

<% end if %>

</body>
</html>