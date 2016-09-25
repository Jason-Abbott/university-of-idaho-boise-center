<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' Last updated 05/13/1999

' if the cancel button was hit then return the user
' to the administration page

if Request.Form("cancel") = "No" then
	response.redirect "webNav2_admin.asp"
end if
%>
<!--#include file="data/webNav2_data.inc"-->
<%
' otherwise delete menu item(s)

dim query

' delete the selected item and any sub-items
' adCmdText = &H0001

query = "DELETE FROM menu_items WHERE " _
	& "(item_id)=" & Request.Form("item_id") _
	& " OR item_parent=" & Request.Form("item_id")
db.Execute query,,&H0001
db.Close
Set db = nothing

' we need to force regeneration of the menu
' so set the Session array to nothing

Session("menuArray") = ""

' now send the user back to the administration page

response.redirect "webNav2_admin.asp"
%>