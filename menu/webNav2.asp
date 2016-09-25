<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 05/12/1999
-->

<html>
<head>
<!--#include file="webNav2_themes.inc"-->
</head>
<body bgcolor="#<%=color(10)%>" text="#<%=color(7)%>" link="#<%=color(8)%>" vlink="#<%=color(8)%>" alink="#<%=color(9)%>">

<table cellspacing=0 cellpadding=0 border=0 width="140">
<tr>
	<td colspan=2><a href="../main_intro.asp" target="body">
	<img src="/graphics/menu_top.gif" width=116 height=27 alt="Home" border="0"></a></td>
<tr>
	<td width="11" valign="top"><a href="../menu_display.asp" target="body">
	<img src="/graphics/menu_side.gif" width=11 height=363 alt="Display full menu in body" border="0"></a></td>
	<td width="129" valign=top>
<font face="Arial, Helvetica" size=2>


<!--#include file="data/webNav2_array.inc"-->
<!--#include file="show_status.inc"-->
<%
' the above include provides the array menuItem
' with these contents:
' 0 id
' 1 name
' 2 description
' 3 parent
' 4 url
' 5 target frame
' 6 hidden
' 7 depth in tree
' 8 number of children

dim expand

' lists expanded folders by index number

if Request.QueryString("expand") <> "" then
	expand = Request.QueryString("expand")
else
	expand = ""
end if

for x = 0 to UBound(menuItem,1)

' display item only if it is not hidden

	if menuItem(x,6) = 0 then
		thisx = x
		response.write "<nobr>"

' insert a blank space for every unit of tree depth		

		for d = 1 to (menuItem(x,7))
			response.write "<img src=""./images/blank_" _
				& style & ".gif"">"
		next
%>
<!--#include file="webNav2_item.inc"-->
<%		
' if there are children then display plus/minus graphic

		if menuItem(x,8) > 0 then
			response.write "<a href=""webNav2.asp?expand="
	 		if InStr(expand, "(" & x & ")") then
				response.write Replace(expand, "(" & x & ")", "") _
					& """ " & showStatus("collapse " & menuItem(x,1)) _
					& "><img src=""./images/minus_"
			else
				response.write expand & "(" & x & ")" _
					& """ " & showStatus("expand " & menuItem(x,1)) _
					& "><img src=""./images/plus_"
				x = x + menuItem(x,8)	
			end if
			response.write style & ".gif"" border=0></a>"
		else
			response.write "<img src=""./images/blank_" _
				& style & ".gif"">"
		end if
		response.write VbCrLf & item & VbCrLf & "<br>" & VbCrLf
		
		if x < UBound(menuItem,1) then
	 		if menuItem(thisx, 7) = 0 AND menuItem(x + 1, 7) > 0 then
				response.write "<font size=1>"
			elseif menuItem(thisx, 7) > 0 AND menuItem(x + 1, 7) = 0 then
				response.write "</font>"
			end if
		end if
	end if
next

if Session("user") <> "guest" then %>
<p>
<center>
<table cellpadding=2 border=0 cellspacing=0>
<tr>
	<td bgcolor="444444"><a href="/help/help_intro.asp"
	target="body"><font face="Arial, Helvetica"
	size=1><b>Computer Help</b></font></a></td>
</table>
<font face="Tahoma, Arial, Helvetica" size=1 color="#333333">
<a href="webNav2_admin.asp" target="body">Admin</a>
</font>
</center>
<% end if %>

	</font>
	</td>
</table>
</body>
</html>