<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 05/13/1999
-->

<!--#include file="webNav2_themes.inc"-->
<SCRIPT LANGUAGE="JavaScript">
<!--
// go through each division and hide children

function init() {
	var allDIVs = document.all.tags("DIV");
	for (i=0; i<allDIVs.length; i++) {
		if (allDIVs(i).className == "child") {
			allDIVs(i).style.display = "none";
		}
	}
}

// cache graphics for fast display

plus = new Image(); plus.src = "./images/plus_<%=style%>.gif";
minus = new Image(); minus.src = "./images/minus_<%=style%>.gif";
blank = new Image(); blank.src = "./images/blank_<%=style%>.gif";

// change style visibility and image

function expandIt(el) {
//	alert(el + "_child");
	whichEl = eval(el + "_child");
//	foo = "document.img_" + el + ".src"
//	alert(foo + "=minus.src");
	if (whichEl.style.display == "none") {
		whichEl.style.display = "block";
		eval("document." + el + "_img.src=minus.src");
	} else {
		whichEl.style.display = "none";
		eval("document." + el + "_img.src=plus.src");
	}
   window.event.cancelBubble = true;
}

onload = init;
//-->
</SCRIPT>
</head>
<body bgcolor="#<%=color(10)%>" text="#<%=color(7)%>" link="#<%=color(8)%>" vlink="#<%=color(8)%>" alink="#<%=color(9)%>">

<table cellspacing=0 cellpadding=0 border=0 width="140">
<tr>
	<td colspan=2><a href="../main_intro.asp" target="body">
	<img src="/graphics/menu_top.gif" width=116 height=27 alt="Home" border="0"></a></td>
<tr>
	<td width="11" valign="TOP"><a href="../menu_display.asp" target="body">
	<img src="/graphics/menu_side.gif" width=11 height=363 alt="Display full menu in body" border="0"></a></td>
	<td width="129" valign=top>
<font face="Arial, Helvetica" size=2>

<div class="root">

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

dim item, divList

for x = 0 to UBound(menuItem,1)
	if menuItem(x,6) = 0 then
		response.write "<nobr>"
		for d = 1 to (menuItem(x,7))
			response.write "<img src=""./images/blank_" _
				& style & ".gif"">"
		next
%>
<!--#include file="webNav2_item.inc"-->
<%
' JavaScript doesn't accept variable names that begin
' with a number so prepend "webNav"

		if menuItem(x,8) > 0 then
			response.write "<a href='#' onClick=" _
				& """expandIt('webNav" & menuItem(x,0) & "'); return true;"">" _
				& "<img name=""webNav" & menuItem(x,0) & "_img"" src=""./images/plus_" _
				& style & ".gif"" border=0></a>" & VbCrLf _
				& item & VbCrLf & "<br>" & VbCrLf & "<div id=""webNav" _
				& menuItem(x,0) & "_child"" class=""child"">" & VbCrLf
				
' figure out where this new division should end
' add the number of children to the current row
				
			divList = divList & "(" & x + menuItem(x,8) & ") "
		else
			response.write "<img src=""./images/blank_" _
				& style & ".gif"">" & VbCrLf & item & "<br>" & VbCrLf
		end if
		
' write closing division tag for all ocurrences of the
' present row in divList
		
		for each z in Filter(Split(divList), "(" & x & ")")
			response.write "</div>" & VbCrLf & VbCrLf
		next
	end if
next
'response.write endDiv
%>
</div>

<% if Session("user") <> "guest" then %>
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