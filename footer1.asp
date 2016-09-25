<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 11/3/97
-->

<HTML>
<BODY background="./graphics/wood_bottom.jpg" bgcolor="#FFFFFF" vlink="#E4C721" alink="#E4C721" link="#E4C721">

<table>
<tr>
	<td width=300 height=37 align="center" valign="bottom">
	<font face="arial" color="#E4C721" size=2>
	<a href="./cal/cal.asp" target="body">
	<%= WeekDayName(weekday(date)) %>,
	<%= MonthName(month(date)) %> <%= day(date) %>,
	<%= year(date) %>
	</a></font>
	</td>
</table>

</BODY>
</HTML>