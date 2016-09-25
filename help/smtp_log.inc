<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/10/97
-->

<font size=4>The information you entered was successfully saved to the HelpDesk database but the server encountered a problem while trying to send e-mail to the technicians.  This is the log:
<hr><pre><font size=2>
<%
dim fs, f
set fs = CreateObject("Scripting.FileSystemObject")
set f = fs.OpenTextFile("c:\Internet\mail\smtp.log", 1)
response.write replace(replace(f.ReadAll, "<", "&lt;"), ">", "&gt;")
%>
</font></pre><hr>
You do not need to resubmit your request.</font>