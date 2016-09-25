<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/12/97
-->

<!--#include file="update.inc"-->

<table cellspacing=0 cellpadding=3 border=0>
<tr>
   <td bgcolor="#800000" align=center colspan=2>
	<font face="arial" color="#ffffff"><b><%= rs("name_first")%>'s Position</b></font></td>
<tr>
   <td bgcolor="#c0c0c0" align=center colspan=2>
	<input type="text" name="position" value="<%=rs("position")%>"	size=30><br>
	<font face="arial" size=1>Job Title</font>

	<hr>

	<select name="college">
<%
dim college

college = array( _
	"Agriculture", _
	"Engineering", _
	"Education", _
	"Forestry", _
	"Law", _
	"Letters and Sciences", _
	"Other")

for each x in college
	response.write "<option"
	if rs("college") = x then
		response.write " selected"
	end if
	response.write ">" & x & VbCrLf
next
%>
	</select><br>
	<font face="arial" size=1>College</font>

	<hr>

	<input type="text" name="area" value="<%=rs("area")%>" size=30><br>
	<font face="arial" size=1>Department or Discipline</font>
	</td>
</table>

<!--#include file="navigate.inc"-->