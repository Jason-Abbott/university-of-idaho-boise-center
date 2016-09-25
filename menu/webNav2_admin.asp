<!--#include file="verify.inc"-->

<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 05/13/1999
-->

<html>
<SCRIPT LANGUAGE="javascript">
<!--

function Validate() {
	var sel = document.adminform.item_list.options[document.adminform.item_list.selectedIndex].value;
	var re = /^0/
	if (sel.search(re) != -1) {
		alert("The \"root\" can only have items added to it")
		document.adminform.item_list.focus();
		return false;
	}
}

//-->
</SCRIPT>
<!--#include file="webNav2_themes.inc"-->
</head>
<body bgcolor="#<%=color(1)%>" link="#<%=color(7)%>" vlink="#<%=color(7)%>" alink="#<%=color(6)%>">

<center>

<!-- framing table -->
<table bgcolor="#<%=color(6)%>" border=0 cellpadding=3 cellspacing=0><tr><td>
<!-- end framing table -->

<table bgcolor="#<%=color(11)%>" border=0 cellpadding=3 cellspacing=0>
<form name="adminform" action="webNav2_edit.asp" method="post">
<tr>
	<td bgcolor="#<%=color(4)%>" colspan=2>
	<font face="Tahoma, Arial, Helvetica" size=4>
	<b>Menu Administration</b></font></td>
<tr>
	<td align="right" valign="top" bgcolor="#<%=color(12)%>">
<input type="submit" name="add" value="Add">
	</td>
	<td><font face="Verdana, Arial, Helvetica" size=2>
	a new item under the one selected</font></td>
<tr>
	<td align="right" valign="top" bgcolor="#<%=color(12)%>">
<input type="submit" name="edit" value="Edit" onClick="return Validate();">
	</td>
	<td><font face="Verdana, Arial, Helvetica" size=2>
	the selected item</font></td>
<tr>
	<td align="right" valign="top" bgcolor="#<%=color(12)%>">
<input type="submit" name="delete" value="Delete" onClick="return Validate();">
	</td>
	<td><font face="Verdana, Arial, Helvetica" size=2>
	the selected item</font></td>
<tr>
	<td align="right" valign="top" bgcolor="#<%=color(12)%>">
<input type="submit" name="organize" value="Organize">
	</td>
	<td><font face="Verdana, Arial, Helvetica" size=2>
	the selected category</font></td>
<tr>
	<td bgcolor="#<%=color(12)%>">&nbsp;</td>
	<td colspan=2 bgcolor="#<%=color(12)%>">
<select name="item_list">

<% Session("menuArray") = "" %>

<!--#include file="data/webNav2_array.inc"-->

<option value="0|<%=UBound(menuItem,1)+1%>|root">[root]
<%
' 0 id
' 1 name
' 2 description
' 3 parent
' 4 url
' 5 target frame
' 6 hidden
' 7 depth in tree
' 8 number of children

for x = 0 to UBound(menuItem,1)
	response.write "<option value=""" _
		& menuItem(x,0) & "|" & menuItem(x,8) & "|" & menuItem(x,1) & """>"

	for d = 0 to menuItem(x,7)
		response.write "&nbsp;&nbsp;&nbsp;"
	next

	if menuItem(x,6) then
		response.write "(" & menuItem(x,1) & ")"
	else
		response.write menuItem(x,1)
	end if
	
	response.write VbCrLf
next	
%>
</select>
	</td>
</table>

<!-- framing table -->
</td></table>
<!-- end framing table -->

</body>
</html>