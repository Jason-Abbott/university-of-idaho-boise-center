<!-- 
Copyright 1998 Jason Abbott (jabbott@uidaho.edu)
Last updated 03/19/98
-->

<HTML>
<BODY background="./graphics/wood_top.jpg" bgcolor="#FFFFFF" link="#E4C721" vlink="#E4C721" alink="#E4C721">

<table>
<tr>
	<td align="right" valign="bottom" width=110 height=50>
	<a href="./" target=_top><font face="arial" size=1>

<!--#include file="authenticate.inc"-->
<%
' CREATE INDEX ARRAY
' Three dimensional zero-based array (1D,2D,3D)
' 1D contains topics
' 2D contains subtopics
' 3D contains urls

dim page(4,11,1), IP, IPallowed, hits

page(0,0,0)			=	"ed"
	page(0,0,1)		=	"./ed/ed.html"
	page(0,1,0)		=	"Faculty"
		page(0,1,1)	=	"./employee/list.asp?college=Education&type=faculty"
	page(0,2,0)		=	"Staff"
		page(0,2,1)	=	"./employee/list.asp?college=Education&type=staff"
		
page(1,0,0)			=	"engr"
	page(1,0,1)		=	"./engr/engr.html"
	page(1,1,0)		=	"Courses"
		page(1,1,1)	=	"./engr/engr_course_intro.asp"
	page(1,2,0)		=	"Faculty"
		page(1,2,1)	=	"./employee/list.asp?college=Engineering&type=faculty"
	page(1,3,0)		=	"Staff"
		page(1,3,1)	=	"./employee/list.asp?college=Engineering&type=staff"
	page(1,4,0)		=	"Eco-hydraulics"
		page(1,4,1)	=	"./engr/eco-hydraulics.html"
	page(1,5,0)		=	"TechHelp&#153;"
		page(1,5,1)	=	"http://www.techhelp.org"
	page(1,6,0)		=	"Red River"
		page(1,6,1)	=	"./redriver"
		
page(2,0,0)			=	"ag"
	page(2,0,1)		=	"./ag/ag.html"
	page(2,1,0)		=	"Faculty"
		page(2,1,1)	=	"./employee/list.asp?college=Agriculture&type=faculty"
	page(2,2,0)		=	"Staff"
		page(2,2,1)	=	"./employee/list.asp?college=Agriculture&type=staff"
		
page(3,0,0)			=	"coop"
	page(3,0,1)		=	"./ag/extension/ext.html"
	page(3,1,0)		=	"Ada"
		page(3,1,1)	=	"./ag/extension/ada.html"
	page(3,2,0)		=	"Adams"
		page(3,2,1)	=	"./ag/extension/adams.html"
	page(3,3,0)		=	"Boise"
		page(3,3,1)	=	"./ag/extension/boise.html"
	page(3,4,0)		=	"Canyon"
		page(3,4,1)	=	"./ag/extension/canyon.html"
	page(3,5,0)		=	"Elmore"
		page(3,5,1)	=	"./ag/extension/elmore.html"
	page(3,6,0)		=	"Gem"
		page(3,6,1)	=	"./ag/extension/gem.html"
	page(3,7,0)		=	"Owhyee"
		page(3,7,1)	=	"./ag/extension/owyhee.html"
	page(3,8,0)		=	"Payette"
		page(3,8,1)	=	"./ag/extension/payette.html"
	page(3,9,0)		=	"Valley"
		page(3,9,1)	=	"./ag/extension/valley.html"
	page(3,10,0)	=	"Washington"
		page(3,10,1)=	"./ag/extension/washington.html"
	page(3,11,0)	=	"Hydrology"
		page(3,11,1)=	"./ag/extension/hydro.html"
		
page(4,0,0)			=	"other"
	page(4,0,1)		=	"./other/other.html"
	page(4,1,0)		=	"Faculty"
		page(4,1,1)	=	"./employee/list.asp?college=Other&type=faculty"
	page(4,2,0)		=	"Staff"
		page(4,2,1)	=	"./employee/list.asp?college=Other&type=staff"
	page(4,3,0)		=	"Alumni"
		page(4,3,1)	=	"./alumni/alumni_intro.html"
	page(4,4,0)		=	"President"
		page(4,4,1)	=	"http://www.uidaho.edu/~hoover/"
	page(4,5,0)		=	"Booster"
		page(4,5,1)	=	"./booster/booster_intro.html"
	page(4,6,0)		=	"Career Services"
		page(4,6,1)	=	"./other/career_services.html"

' this array is the same for everyone so use application object

Application("page") = page

' DISPLAY PAGE COUNT

Set MyPageCounter = Server.CreateObject("MSWC.PageCounter")
hits = MyPageCounter.Hits
Response.Write "visitor " & hits
%>
	</font></a></td>
	
</table>
</BODY>
</HTML>