<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 5/28/98
-->

<!--#include virtual="/header_start.inc"-->
Engineering Course Listing

	</td>
	<td align=right>

<!-- add button -->

<% if Session("user") = "jabbott" OR Session("user") = "denisee" then %>
<a href="engr_course_edit.asp?action=add">
<img src="/graphics/button_add.gif" border=0>
</a>
<% end if %>
<!--#include virtual="/header_end.inc"-->

<center>
<!--#include file="engr_course_form.inc"-->

<p>
<table cellpadding=2 cellspacing=0 border=0>
<tr>
   <td align=center colspan=4 <%=light%>>
	<font face="arial" size="2">
	<b>Degree Programs</b></font></td>
<tr>
   <td align=center><font face="arial" size=2><b>Discipline</b></font></td>
   <td><font face="arial" size=2><b>M.Engr.</b></font></td>
   <td><font face="arial" size=2><b>M.S.</b></font></td>
   <td><font face="arial" size=2><b>Ph.D.</b></font></td>
<tr>
   <td align=right>Agricultural Engineering</td>
	<td align=center>•</td><td align=center>•</td>
	<td align=center>•</td>
<tr>
   <td align=right>Biological Systems Engineering</td>
	<td align=center>•</td>
	<td align=center>•</td><td align=center>•</td>
<tr>
   <td align=right>Civil Engineering</td>
	<td align=center>•</td><td align=center>•</td>
	<td align=center>•</td>
<tr>
   <td align=right>Computer Engineering</td>
	<td align=center>•</td>
	<td align=center>•</td>
<tr>
   <td align=right>Engineering Management</td>
	<td align=center>•</td>
<tr>
   <td align=right>Electrical Engineering</td>
	<td align=center>•</td><td align=center>•</td>
	<td align=center>•</td>
<tr>
   <td align=right>Mechanical Engineering</td>
	<td align=center>•</td>
	<td align=center>•</td>
	<td align=center>•</td>
</table>
</center>
<p>
<font size=5>G</font>raduate degrees are available through the Boise program using
a combination of resident faculty and video courses.  Courses
of study leading to the degrees of Master of Science (M.S.), Master
of Engineering (M.Engr.), and Doctor of Philosophy (Ph.D.) are
offered in civil, electrical and mechanical engineering.  We can
also assist you in earning a University of Idaho graduate degree
in agricultural engineering, biological systems engineering, computer
engineering, or engineering management through the
<a href="http://www.uidaho.edu/evo/" target=_top>College's Engineering
Outreach</a> program.

<!--#include virtual="/footer.inc"-->