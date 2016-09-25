<table border=0 cellspacing=0 cellpadding=2 width=150>
<tr>
	<td>&nbsp;</td><td>&nbsp;</td>
	<td rowspan=2 align=right valign=bottom>
	<input type="submit" value="Next >">
	</td>
	<input type="hidden" name="email_name" value="<%=Request.Form("email_name")%>">
	</form>
	
<tr>

<% if links.GetListIndex(linkfile) > 1 then %>

	<form action="<%=links.GetPreviousURL(linkfile)%>" method="post">
	<td valign=bottom><input type="submit" value="< Prev"></td>
	<input type="hidden" name="email_name" value="<%=Request.Form("email_name")%>">
	</form>	

<% else %>
	<td>&nbsp;</td>
<% end if %>
	
	<form action="detail.asp?email_name=<%=Request.Form("email_name")%>" method="post">
	<td valign=bottom><input type="submit" value="Cancel"></td>
	</form>	
	
</table>

<%
rs.Close
db.Close
%>

</body>
</html>