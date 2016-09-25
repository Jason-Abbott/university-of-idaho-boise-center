<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 5/29/98
-->

<!--#include virtual="/header_start.inc"-->
Engineering Course List

	</td>
	<td align=right>

<!-- add button -->

<%
' Only technicians and Denise Engebrecht are allowed to
' add new courses

if Session("user") = "denisee" OR _
	InStr(Session("technicians"), Session("user")) > 0 then
%>
<a href="engr_course_edit.asp?action=add">
<img src="/graphics/button_add.gif" border=0>
</a>
<% end if %>
<!--#include virtual="/header_end.inc"-->

<%
dim combine, query, n, colorlo, colorhi, x, course, color, i
dim legend, header_yr, header_sem, header_crs

' begin generating SQL query based on form values

combine = ""

if Not Request.Form("discipline") = "All" then
   query = "discipline = '" & Request.Form("discipline") & "'"
   combine = " AND "
end if

if Request.Form("course_number") <> "" then
   query = query & combine & "course_number LIKE '%" _
		& Request.Form("course_number") & "%'"
   combine = " AND "
end if

if Request.Form("title") <> "" then
   query = query & combine & "title LIKE '%" _
		& Request.Form("title") & "%'"
   combine = " AND "
end if

if Request.Form("instructor") <> "Unspecified" then
   query = query & combine & "instructor = '" _
		& Request.Form("instructor") & "'"
   combine = " AND "
end if

if Request.Form("scope") <> "future" then
   query = query & combine & "(" & Request.Form("scope") _
		& "_live = -1 OR " & Request.Form("scope") & "_video = -1)"
end if

if query <> "" then
	query = "SELECT * FROM courses_engr WHERE " & query _
		& " ORDER BY discipline, course_number"
else
	query = "SELECT * FROM courses_engr ORDER BY discipline, course_number"
end if

' run query against database

Set db = Server.CreateObject("ADODB.Connection")
db.Open "bc"
Set rs = db.Execute(query)

if rs.EOF = -1 then

' no records found

	response.write "<b><font size='5'>N</font>o courses were" _
		& " found matching the criteria you specified.</b>"
	if Request.Form("instructor") <> "Unspecified" then

' they searched for instructor, but not implemented

		response.write "Please note that our online course list" _
			& " is a work in progress and many courses are not" _
			& " yet associated with an instructor.  Try your search" _
			& " again without specificying an instructor.  We" _
			& " apologize for this inconvenience."
	end if
	
	response.write "If you believe that the parameters you've" _
		& " specified are correct then please call us at" _
		& " (208) 364-4085.  We would be happy to assist you."
else

' records were found so begin generating page
' generate repeatable value for legend

	legend = VbCrLf & "<tr>" & VbCrLf _
		& "<td align='center'><font size='2'>" _
		& "<i>Click on the course<br>number for more details</i>" _
		& "</font></td>" & VbCrLf & "<td colspan='3' align='center'>" _
		& "<img src='/graphics/live.gif' width='20' height='19'>" _
		& " Live</td>" & VbCrLf & "<td colspan='3' align='center'>" _
		& "<img src='/graphics/video.gif' width='21' height='20'>" _
		& " <a href='http://www.uidaho.edu/evo/'>Video</a></td>"
		
' generate repeatable value for course header

	header_crs = VbCrLf & "<tr>" & VbCrLf _
		& "<td rowspan='2' align='center' " _
		& light & " width=200>" _
		& "<font face='arial'><b>Course</b></font></td>"

' generate repeatable value for year header

	for each y in Application("years")
		header_yr = header_yr & VbCrLf & "<td colspan='2' align='center'" _
			& light & "><font face='arial' size='2'>" _
			& y & "</font></td>"
	next

' generate repeatable value for semester header
' create alternating colors for columns

	n = 1
	for each y in Application("years")
		for each s in Application("sems")
			if n mod 2 <> 0 then
				color = "dddddd"
			else
				color = "cccccc"
			end if

			header_sem = header_sem & "<td align='center' bgcolor='#" _
				& color & "' width=35><font face='arial' size='1'>" _
				& s & "</font></td>" & VbCrLf
			n = n + 1
		next
	next

' write full table heading

	response.write "<center><table cellpadding='2'" _
		& " cellspacing='0' border='0'>" & legend _
		& header_crs & header_yr & VbCrLf & "<tr>" _
		& VbCrLf & header_sem

' begin listing courses
' create alternating colors for columns

	n = 1
	Do While Not rs.EOF
		if n mod 2 <> 0 then
			color = "cccccc"
		else
			color = "eeeeee"
		end if

' write course name and number

		response.write VbCrLf & "<tr>" & VbCrLf _
			& "<td width=200 bgcolor='#" _
			& color & "'><font size='2'><a href='" _
			& "engr_course_detail.asp?course_number=" _
			& rs("course_number") & "&discipline=" _
			& rs("discipline") & "'>" & rs("discipline") _
			& rs("course_number") & "</a></font><br>" _
			& rs("title") & "</td>"

' generate icons for live and video

		i = 2		
		for each y in Application("years")
			for each s in Application("sems")

' alternate color within color

				if n mod 2 <> 0 then
					if i mod 2 <> 0 then
						color = "cccccc"
					else
						color = "dddddd"
					end if
				else
					if i mod 2 <> 0 then
						color = "eeeeee"
					else
						color = "ffffff"
					end if

				end if
			
				response.write "<td align='center' width=35 bgcolor='#" _
				& color & "'>"
				for each m in Application("media")
					if rs(s & "_" & y & "_" & m) = "True" then
						response.write "<img src='/graphics/" & m & ".gif'>"
					else
						response.write "&nbsp;"
					end if
				next
				response.write "</td>" & VbCrLf
			i = i + 1
			next
		next

		rs.MoveNext
		n = n + 1
	Loop
	rs.Close
	db.Close
	
' write full table heading again, then end

	response.write header_crs & header_sem & "<tr>" _
		& header_yr & legend & VbCrLf & "</table></center>"
end if
%>

<!--#include virtual="/footer.inc"-->