<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/12/97
-->

<!--#include file="update.inc"-->

<table border=0 cellspacing=0 cellpadding=3>
<tr>
   <td colspan=2 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF"><b><%= rs("name_first")%>'s Duties</b></td>
<tr>
   <td colspan=2 align=center bgcolor="#C0C0C0">

<%	for x = 1 to 6 %>

	<b><%=x%></b>
	<input type="text" name="duty<%=x%>" value="<%=rs("duty"&x)%>" size=50><br>

<%	next %>

	</td>
</table>

<!--#include file="navigate.inc"-->