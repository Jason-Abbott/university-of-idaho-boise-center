<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/29/99
-->

<!--#include virtual="/header_start.inc"-->
Boise Center HelpDesk Search
<!--#include virtual="/header_end.inc"-->

<%
dim db, rs, query

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"

query = "SELECT name_last, name_first, email_name, ip " _
	& "FROM employee ORDER BY name_last"

Set rs = db.Execute(query)
%>

<center>
<table border=1 cellspacing="0" cellpadding="2" width="100%">
<tr>
	<form action="help_list.asp" method="post">
	<td <%=light%>><font face="arial"><font size="4" color="#0000FF">Do a quick search</font>
	<hr size="1" color="#000000">
	<font size=2>Find all the requests that are still being worked on ("open" or "pending")<br>
	<input type="submit" value="List all current requests">
	<input type="hidden" name="email_name" value="(list all)">
	<input type="hidden" name="category" value="(list all)">
	<input type="hidden" name="open" value="on">
	<input type="hidden" name="pending" value="on">
	</form>
<p>
	<form action="help_list.asp" method="post">
	Or find all the requests, open or closed, that were submitted or updated within a specified period of time<br>
	<input type="submit" value="List requests from last">
	<input type="text" name="weeks" size="2" value="1"> week(s)</font>
	</td>
	<input type="hidden" name="email_name" value="(list all)">
	<input type="hidden" name="category" value="(list all)">
	<input type="hidden" name="open" value="on">
	<input type="hidden" name="pending" value="on">
	<input type="hidden" name="closed" value="on"></td>
	</form>
</table>
<p>
<table border=1 cellspacing=0 cellpadding=2 width="100%">
<tr>
	<td <%=light%>>
	<table border=0 cellspacing=0 cellpadding=2 width="100%">
	<tr>
		<td colspan=2><font face="arial"><font size="4" color="#0000FF">Or a more detailed search</font>
		<hr size="1" color="#000000">
		<font size=2>Enter criteria for as many of these categories as you wish</font>
		</td>
	</table>
<p>
	<table border=0 cellspacing=0 cellpadding=2 width="100%">
		<form action="help_list.asp" method="post">
	<tr>
		<td align="right" valign="top"><font face="arial" size=2>Name</font></td>
		<td valign=top><select name="email_name">
		<option>(list all)

<% Do While Not rs.EOF %>

		<option value="<%=rs("email_name")%>"<% if Session("user") = rs("email_name") then %> selected<% end if %>><%=rs("name_first") & " " & rs("name_last")%>

<%
rs.MoveNext
Loop
rs.Close
db.Close
%>

		</select><br>
		<font face="arial" size=1>Who submitted the request?</font>
		</td>
	<tr>
		<td align=right valign=top>
		<font face="arial" size=2>Problem with</font></td>
		<td  valign=top><select name="category">
		<option>(list all)

<!--#include file="help_categories.inc"-->

		</select><br>
		<font face="arial" size=1>How was it categorized?</font></td>
	<tr>
		<td align=right  valign=top>
		<font face="arial" size=2>Description</font></td>
		<td valign=top>
		<input type="text" name="description"><br>
		<font face="arial" size=1>What key word was used to describe it?</font></td>
	<tr>
		<td align=right valign=top>
		<font face="arial" size=2>Status</font></td>
		<td valign=top><font face="arial" size=2>
		<input type="checkbox" name="open" checked>Open
		<input type="checkbox" name="pending" checked>Pending
		<input type="checkbox" name="closed" checked>Closed
		</font><br>
		<font face="arial" size=1>What is the status?</font></td>
	<tr>
		<td colspan=2><input type="submit" value="Find"></td>
		</form>
	</table>
	</td>
</table>
</center>

<!--#include virtual="/footer.inc"-->