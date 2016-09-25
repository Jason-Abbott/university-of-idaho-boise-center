<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 02/04/99
-->

<!--#include virtual="/header_start.inc"-->
Boise Center contact information
<!--#include virtual="/header_end.inc"-->

<center>
<table cellpadding=4 cellspacing=0 border=0>
<tr>
	<td align=right><font face="Arial, Helvetica"><b>Mailing address</b></font></td>
	<td>800 Park Boulevard, Suite 200<br>Boise, Idaho  83712
<tr>
	<td align=right><font face="Arial, Helvetica"><b>Telephone</b></font></td>
	<td>(208) 334-2999</td>
<tr>
	<td align=right><font face="Arial, Helvetica"><b>FAX</b></font></td>
	<td>(208) 364-4035</td>
<tr>
	<td align=right><font face="Arial, Helvetica"><b>e-mail</b></font></td>
	<td><a href="mailto:boise@uidaho.edu">boise@uidaho.edu</td>
<tr>
	<td align=right><font face="Arial, Helvetica"><b>web</b></font></td>
	<td><a href="http://boise.uidaho.edu" target=_top>http://boise.uidaho.edu</a></td>
</table>
<p>
<table cellpadding=2 cellspacing=0 border=0>
<tr>
	<td align="center" <%=light%>>
	<font face="Arial, Helvetica"><b>Name</b></font></td>
	<td align="center" <%=light%>>
	<font face="Arial, Helvetica"><b>364-</b></font></td>
	<td align="center" <%=light%>>
	<font face="Arial, Helvetica"><b>e-mail</b></font></td>
<%
query = "SELECT name_first, name_last, email_name, email_site, phone " _
	& "FROM employee ORDER BY name_last"
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)
Do While Not rs.EOF
%>
<tr>
	<td align=right><font size=2>
	<a href="/employee/detail.asp?email_name=<%=rs("email_name")%>">
	<%=rs("name_last") & ", " & rs("name_first")%></a></font></td>
	<td align=center <%=light%>>
	<font face="Arial, Helvetica" size=2><%=rs("phone")%></font></td>
	<td><font size=2>
	<a href="mailto:<%=rs("email_name") & "@" & rs("email_site")%>">
	<%=rs("email_name") & "@" & rs("email_site")%></a></font></td>
<%
	rs.MoveNext
	Loop
rs.Close
%>
<tr>
	<td colspan=3><hr size="1" color="#000000"></td>
<tr>
	<td align=right><font size=2>Classroom 1</font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4011</font></td>
<tr>
	<td align=right><font size=2><a href="/rooms/classroom3.asp">Classroom 3</a></font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4053</font></td>
<tr>
	<td align=right><font size=2><a href="/rooms/lab/lab_intro.asp">Computer Lab</a></font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4009</font></td>
<tr>
	<td align=right><font size=2>Video Lab</font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4052</font></td>
<tr>
	<td align=right><font size=2><a href="/rooms/vidconference.asp">Compressed Video Room</a></font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4007</font></td>
<tr>
	<td align=right><font size=2>Conference Room B</font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4049</font></td>
<tr>
	<td align=right><font size=2>Conference Room C</font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4048</font></td>
<tr>
	<td align=right><font size=2>CE Lab</font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4090</font></td>
<tr>
	<td align=right><font size=2>EE Lab</font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4072</font></td>
<tr>
	<td align=right><font size=2>ME Lab</font></td>
	<td align=right <%=light%>>
	<font face="Arial, Helvetica" size=2>4086</font></td>
</table>

<!--#include virtual="/footer.inc"-->