<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/29/99
-->

<!--#include virtual="/header_start.inc"-->
Boise Center HelpDesk Request
<!--#include virtual="/header_end.inc"-->

<%

dim query, techs, db, bc, rs, fill

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

query = "SELECT name_last, name_first, email_name, ip " _
	& "FROM employee ORDER BY name_last"

Set rs = db.Execute(query)
%>

<center>
<table bgcolor="#c0c0c0" border=1><tr><td bgcolor="#c0c0c0">

<table border="0" cellspacing="0" cellpadding="2">

<%
if Session("form_errors") <> "" then
	fill = 1
%>
<tr><td colspan=2 align="center"><font face="arial" size=2 color="#ff000">
<b>Items in red need to be entered or corrected</font></b>

<% end if %>

<tr>
	<form action="help_added.asp" method="post">
	<td align=right>
	<font face="arial" size=2>Name</td>
	<td><font face="arial" size=2><select name="submitter">
	<option>Entered below
<% Do While Not rs.EOF %>

	<option value="<%=rs("email_name")%>"<% if rs("email_name") = Session("user") then %> selected<% end if %>><%=rs("name_last") & ", " & rs("name_first")%>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

	</select>
	</td>
<tr>
	<td colspan=2 bgcolor="#c0c0c0" align="center"><hr>
	<font face="Arial" size=2><b>
Fill out the blue section <i>only if</i><br>the request is for someone not in the above list</b></font>
	</td>
<tr>
	<td align=right bgcolor="#c0c0df">
	<font face="arial" size=2
	<% if InStr(Session("form_errors"), "hname_first") then %>
	color="#ff0000"><b>
	<% else %>><% end if %>
	First Name</td>
	<td bgcolor="#c0c0df">
	<input type="text" name="hname_first"
	<%if fill=1 then%>value="<%=Session("hname_first")%>"<%end if%>></td>
<tr>
	<td align=right bgcolor="#c0c0df">
	<font face="arial" size=2
	<% if InStr(Session("form_errors"), "hname_last") then %>
	color="#ff0000"><b>
	<% else %>><% end if %>
	Last Name</td>
	<td bgcolor="#c0c0df">
	<input type="text" name="hname_last"
	<%if fill=1 then%>value="<%=Session("hname_last")%>"<%end if%>></td>
<tr>
	<td align=right bgcolor="#c0c0df">
	<font face="arial" size=2
	<% if InStr(Session("form_errors"), "hemail_name") then %>
	color="#ff0000"><b>
	<% else %>><% end if %>
	e-mail</td>
	<td bgcolor="#c0c0df"><font face="arial" size=2>
	<input type="text" name="hemail_name" size="8"
	<%if fill=1 then%>value="<%=Session("hemail_name")%>"<%end if%>>@<input type="text" name="hemail_site" size="12" value="<%if fill=1 then%><%=Session("hemail_site")%>"<%else%>uidaho.edu<%end if%>"></td>
<tr>
	<td align=right bgcolor="#c0c0df">
	<font face="arial" size=2
	<% if InStr(Session("form_errors"), "hphone") then %>
	color="#ff0000"><b>
	<% else %>><% end if %>
	Phone</td>
	<td bgcolor="#c0c0df">
	<input type="text" name="hphone" value="<%if fill=1 then%><%=Session("hphone")%><%else%>(208) 364-<%end if%>"></td>

<tr>
	<td colspan=2><hr></td>
<tr>
	<td align=right>
	<font face="arial" size=2>Problem with</font></td>
	<td><select name="category">

<!--#include file="help_categories.inc"-->

	</select></td>
<tr>
	<td align="right">
	<font face="arial" size=2>Problem description</font></td>
	<td>&nbsp;</td>
<tr>
	<td colspan=2 align=center>
	<textarea name="description" cols=50 rows=10 wrap="virtual"><%if fill=1 then%><%=Session("description")%><%end if%></textarea></td>
<tr>
	<td align=right>
	<font face="arial" size=2>Must be completed by</font></td>
	<td><input type="text" name="due" size="8" maxlength="10"
	<%if fill=1 then%>value="<%=Session("due")%>"<%end if%>></td>
<tr>
	<td>&nbsp;</td>
	<td><font face="arial" size=1>Enter a date in the format m/d/y or m-d-y<br>
	<i>only</i> if this <i>must</i> be done by that date</font></td>
<tr>
	<td colspan=2 align=center>
	<input type="submit" value="Send Request"></td>
	</form>
</table>

</td></table>
</center>

<% Session("form_errors") = "" %>

<!--#include virtual="/footer.inc"-->