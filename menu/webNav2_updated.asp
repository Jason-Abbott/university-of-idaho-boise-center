<!--#include file="data/webNav2_data.inc"-->
<%
' Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
' updated 05/13/1999

' if cancel is hit then send back to admin page

if Request.Form("cancel") = "Cancel" then
	response.redirect "webNav2_admin.asp"
end if

' if called by the organization form ...

if Request.Form("list") <> "" then
	dim itemList, query
	
	itemList = Request.Form("list")
	itemList = Left(itemList, Len(itemList) - 1)
	itemList = Split(itemList, ",")
	for x = 0 to UBound(itemList)
		query = "UPDATE menu_items SET " _
			& "item_order = " & x _
			& " WHERE (item_id)=" & itemList(x)
'		response.write query
		db.Execute query,,&H0001
	next
	db.Close
	Set db = nothing
	Session("menuArray") = ""
	response.redirect "webNav2_admin.asp"
else

' otherwise update the database with the form
' information

	dim itemHidden

	if Request.Form("item_hide") = "on" then
		itemHidden = 1
	else
		itemHidden = 0
	end if

	if Request.Form("item_id") <> 0 then

' if there is an existing item ID then we must be updating
' an existing record	
	
' if the item name was changed then we need to
' update all the child items to point to the
' correct parent name

'		if Request.Form("old_name") <> Request.Form("item_name") then
'			query = "UPDATE menu_items SET " _
'				& "item_parent = '" _
'				& Request.Form("item_name") _
'				& "' WHERE item_parent = '" _
'				& Request.Form("old_name") & "'"
'			db.Execute query,,&H0001
'		end if

		query = "UPDATE menu_items SET " _
			& "item_name = '" _
			& Request.Form("item_name") & "', " _
			& "item_description = '" _
			& Request.Form("item_description") & "', " _
			& "item_parent = '" _
			& Request.Form("item_parent") & "', " _
			& "item_url = '" _
			& Request.Form("item_url") & "', " _
			& "item_target = '" _
			& Request.Form("item_target") & "', " _
			& "item_hide = '" _
			& itemHidden & "' " _
			& "WHERE (item_id)=" _
			& Request.Form("item_id")
	else

' otherwise create a new record

		query = "INSERT INTO menu_items (" _
			& "item_name, "_
			& "item_description, " _
			& "item_parent, " _
			& "item_url, " _
			& "item_target" _
			& ") VALUES ('" _
			& Request.Form("item_name") & "', '" _
			& Request.Form("item_description") & "', '" _
			& Request.Form("item_parent") & "', '" _
			& Request.Form("item_url") & "', '" _
			& Request.Form("item_target") & "')"
	end if

' adCmdText = &H0001

	db.Execute query,,&H0001
	db.Close
	Set db = nothing

	Session("menuArray") = ""

	if Request.Form("save") = "Save" then
		response.redirect "webNav2_admin.asp"
	else
		response.redirect "webNav2_edit.asp?parent=" & Request.Form("item_parent")
	end if
end if
%>