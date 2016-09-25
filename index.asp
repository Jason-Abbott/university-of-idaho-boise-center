<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/11/97
-->

<html>
<body background="./graphics/wood_side.jpg" text="#E4C721" link="#E4C721" vlink="#E4C721" alink="#E4C721" bgcolor="#FFFFFF">

<table width=150 border=0 cellspacing=0 cellpadding=0>

<!--#include file="authenticate.inc"-->
<%
dim topic, subtopic

' cycle through topics defined in header1.asp
' Three dimensional zero-based array (1D,2D,3D)
' 1D contains topics
' 2D contains subtopics
' 3D contains urls

for topic = 0 to UBound(Application("page"),1)
%>

<tr>
	<td align="right" height=20 colspan=2 valign=bottom>
	<a href="<%=Application("page")(topic,0,1)%>" target="center">
	<img src="./graphics/button_<%=Application("page")(topic,0,0)%>.jpg" border=0></a></td>

<%	if Request.QueryString("page") = Application("page")(topic,0,0) then %>

<tr>
	<td width=30>&nbsp;</td>
	<td width=120><font face="arial" size=1>

<%
' cycle through subtopics defined in header1.asp

		for subtopic = 1 to UBound(Application("page"),2)
			if Application("page")(topic,subtopic,0) = "" then exit for
%>

	<a href="<%=Application("page")(topic,subtopic,1)%>" target="body">&#183; <%=Application("page")(topic,subtopic,0)%></a><br>

<%		next %>

	</font></td>
<%
	end if
next

' only show help button to Boise Center employees

if Not Session("user") = "guest" then
%>

<tr>
	<td width=30>&nbsp;</td>
	<td><br><a href="./help/help_intro.html" target="body" alt="Help">
	<img src="./graphics/button_help.gif" border=0></a>
	</td>

<% end if %>

</table>
</body>
</html>