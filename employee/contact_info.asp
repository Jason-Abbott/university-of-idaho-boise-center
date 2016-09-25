<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/12/97
-->

<!--#include file="update.inc"-->

<table cellspacing=0 cellpadding=3 border=0>
<tr>
   <td colspan=3 bgcolor="#800000" align=center>
	<font face="arial" color="#FFFFFF"><b>Contact Information</b></font></td>
<tr>
	<td bgcolor="#c0c0c0" align=center>
	<input type="text" name="title" value="<%=rs("title")%>" size=3>
	<br>
	<font face="arial" size=1>Title</font>
	</td>

   <td bgcolor="#C0C0C0" align=center>
   <input type="text" name="name_first" value="<%=rs("name_first")%>" size=10>
	<br>
	<font face="arial" size=1>First Name</font>
	</td>

   <td bgcolor="#C0C0C0" align=center>
   <input type="text" name="name_last" value="<%=rs("name_last")%>" size=10>
	<br>
	<font face="arial" size=1>Last Name</font>
	</td>

<!-- contact information -->

<tr>
   <td align=center bgcolor="#c0c0c0" colspan=3>
	<hr>
	<font face="arial" size=2>
	(208) 364-<input type="text" name="phone" value="<%=rs("phone")%>" size=4>
	</font>
	<br>
	<font face="arial" size=1>Telephone</font>

	<hr>

   <input type="text" name="email_name" value="<%=rs("email_name")%>" size=8>
	@<input type="text" name="email_site" value="<%=rs("email_site")%>" size=20><br>
	<font face="arial" size=1>e-mail address</font>
	</td>
</table>

<!--#include file="navigate.inc"-->