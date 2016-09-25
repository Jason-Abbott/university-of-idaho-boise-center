<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/27/99
-->

<!--#include virtual="/header_start.inc"-->
Boise Center HelpDesk
<!--#include virtual="/header_end.inc"-->

<center>
<table border=1 cellspacing=0 cellpadding=2 width="100%">
<tr>
	<form action="/jump.asp" method="post">
	<td <%=light%>><font face="arial"><font size="4" color="#0000ff">Check here first</font>
	<hr size="1" color="#000000">
<font size=2>The quickest assistance is often that which you can provide yourself.  Take a moment to examine the following list of tasks that you can accomplish on your own:</font>
<br>
	<input type="submit" value="I want to">
	<select name="url">
	<option value="ets.uidaho.edu/vidres/emailreq.html">
	reserve a compressed video room
	<option value="www.uidaho.edu/helpdesk/outages/">
	view current network outages
	<option value="www.bookstore.uidaho.edu/computers/license/order/step1.asp">
	order a site-license
	<option value="www.bookstore.uidaho.edu/computers/prices/license.asp">
	view site-license pricing
	<option value="www.uidaho.edu/csrv/hpteam/Major_domo/index.htm">
	create a mailing list for my class
	<option value="www.micron.net/snt/info/">
	learn about Surf-n-Toss
	<option value="support.microsoft.com/support">
	get help with a Microsoft product
	<option value="www.corel.com/support/index.htm">
	get help with a Corel product (e.g. WordPerfect)
	<option value="www.hp.com/cpso-support/wwhome/print.html">
	get help with and drivers for an HP Printer
	<option value="www.microsoft.com/ie/ie40/download/ie4.htm">
	download a new version of Internet Explorer
	<option value="www.netscape.com/download/client_download.html?communicator4.04">
	download a new version of Netscape
	<option value="coe-ux1.idbsu.edu/dln/gateway.htm">
	contact someone about compressed video
	</select>
	</td>
	</form>
</table>
<p>
<table border=1 cellspacing=0 cellpadding=2 width="100%">
<tr>
	<form action="help_request.asp" method="post">
	<td <%=light%>><font face="arial"><font size="4" color="#0000FF">Then, if still needed, request assistance</font>
	<hr size="1" color="#000000">
<font size=2>If your need is not addressed in the list, feel free to submit a request for assistance from the Boise Center technicians.  If you know the technicians to be unavailable you may also wish to visit the University of Idaho's <a href="http://www.uidaho.edu/helpdesk/" target=_top>main HelpDesk</a>.</font><br>
	<input type="submit" value="Enter Request">
	</td>
	</form>
</table>
<p>
<table border=1 cellspacing=0 cellpadding=2 width="100%">
<tr>
	<form action="help_search.asp" method="post">
	<td <%=light%>><font face="arial"><font size="4" color="#0000FF">Or check the status of an existing request</font>
	<hr size="1" color="#000000">
<font size=2>You may also view the status of or solutions to previously submitted requests.  It's important to remember that our prioritization must be dynamic.  A failed server, for example, will take priority over previously submitted individual requests.</font><br>
	<input type="submit" value="Search past requests">
	</td>
	</form>
</table>
</center>

<!--#include virtual="/footer.inc"-->