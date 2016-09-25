<!-- 
Copyright 1997 Jason Abbott (jabbott@uidaho.edu)
Last updated 12/11/97
-->

<html>
<body link="#800000" vlink="#800000" alink="#E4C721" bgcolor="#FFFFFF">

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
query = "SELECT * FROM cal_events" _
	& " WHERE (event_id)=" & Request.QueryString("event_id")
Set rs = db.Execute(query)
%>

<form action="cal_deleted.asp" method="post">
<center>
<font size=5>
Press "Delete" if you are sure that you want to delete <b><%=rs("event_title")%></b> from the <%=rs("event_context")%> calendar.
<p>
<font color="#ff0000">This action is not reversable.</font></font>
<p>
<input type="hidden" name="event_id" value="<%=Request.QueryString("event_id")%>">
<input type="hidden" name="month" value="<%=Month(rs("event_start"))%>">
<input type="hidden" name="year" value="<%=Year(rs("event_start"))%>">
<input type="hidden" name="event_context" value="<%=rs("event_context")%>">
<input type="submit" value="delete">
</form>
<%
rs.close
db.close
%>
</center>
</body>
</html>