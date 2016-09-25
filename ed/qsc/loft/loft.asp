<!--#include virtual="/ed/qsc/qsc_header.inc"-->

<script language="javascript">
<!--//
/*This Script allows people to enter by using a form that asks for a
UserID and Password*/

function pasuser(form) {
	if (form.id.value=="Website") { 
		if (form.pass.value=="Abstraction") {              
			location="page2.asp" 
		} else {
			alert("Invalid Password")
		}
	} else {
			alert("Invalid UserID")
	}
}
//-->
</script>

<table width="100%"><tr><td bgcolor="#2A7FAA" align="center">
<font face="arial" color="#ffffff">
The Leaders' Loft
<font></td></table>

Members of QSC's Quality Leadership Institute gather here for news, ideas, and sharing.

<center>
<table width="75%" cellspacing="0">
<tr>
	<td colspan=3 bgcolor="#2A7FAA" align="center">
	<font face="arial" size=2 color="#ffffff">
	<b>Login is Website, password is Abstraction</b></font>
	</td>
<tr>
<form name="login">
	<td bgcolor="#c0c0c0" align="right">Username:</td>
	<td bgcolor="#c0c0c0"><input name="id" type="text" value="Website"></td>
	<td bgcolor="#c0c0c0" rowspan=2 align="center">
	<input type="button" value="Login" onClick="pasuser(this.form)">
	</td>
<tr>
	<td bgcolor="#c0c0c0" align="right">Password:</td>
	<td bgcolor="#c0c0c0"><input name="pass" type="password"></td>
</table>
</center>
<p>
Your ideas, comments, suggestions, and critques are delightfully received by the <a href="mailto:<%=webmaster%>">QSC Website webmaster.</a>


<!--#include virtual="/ed/qsc/qsc_footer.inc"-->
