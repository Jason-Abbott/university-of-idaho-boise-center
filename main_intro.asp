<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 03/31/1999
-->

<!--#include virtual="/header_start.inc"-->
Welcome to the University of Idaho Boise Center
<!--#include virtual="/header_end.inc"-->

<table width="100%" cellspacing="4" cellpadding="0">
<tr>
	<td valign="top" align="center"><hr size="1" color="#000000">
		<font face="Arial, Helvetica" size=2>The University of Idaho Boise (UIB) offers courses from the Colleges of Agriculture, Education, Engineering, and Forestry, Wildlife and Range Sciences.</font><hr size="1" color="#000000">
	</td>
	<td rowspan=2 width="300" align="center" valign="top">
		<img src="graphics/bc_photo_summer.jpg" width=300 height=204 alt="Photo of the Boise Center" border="1">
		<!-- <font face="Arial, Helvetica" size=1 color="#333333">Winter view of our center</font> -->
		<p>
		<center>

<% if Session("user") <> "guest" then %>

		<table width="50%" cellspacing="0">
		<tr>
			<td <%=light%> align="center"><font face="Arial, Helvetica" size=2><b>Fun Stuff</b>
			<hr size="1" color="#FFCC00">
			<a href="/news/halloween97.asp">Halloween 1997<br>
			<a href="/news/halloween98.asp">Halloween 1998</a><br>
			<a href="/news/babyshower.asp">Miki's baby shower</a>
			</td>
		</table>

<% else %>

	<a href="http://www.microsoft.com/ie/logo.asp" target="_top">
	<img src="/graphics/ie4get_animated.gif" border=0></a>

<% end if %>

	</td>
<tr>
	<td valign="bottom" align="center">
	<a href="http://www.uidaho.edu/admissions/application/grad-app/" target="_top">
	<img src="/graphics/button_apply.gif" border=0></a><p>

	<applet code="OCVscroll" codebase="./scroll" align="baseline" height="110" width="110">

<!--OpenCube Copyright Notice Parameter-->
<param name="Notice" value="Smooth Scroll Up II, Copyright (c) 1999, OpenCube Inc.">

<!--Default Settings-->
<param name="bgcolor" value="255,204,0">
<param name="textcolor" value="0,0,0">
<param name="font" value="Helvetica, plain, 10">
<param name="lrmargin" value="5">
<param name="hlcolor" value="255,0,0">
<param name="scrolldelay" value="15">
<param name="loadwhere" value="body">
<param name="halign" value="Center">

<!--Specific Settings-->
<param name="desc0" value="Tips:">
<param name="font0" value="Helvetica,Bold,14">
<param name="sizepause0" value="Start">
<param name="delay0" value="4000">

<param name="desc1" value="To get back to this home page, click on the 'University of Idaho' graphic at the top of the menu.">
<param name="sizepause1" value="End">

<param name="desc2" value="To view the menu in a larger window, click on the 'Boise Center' graphic to the left of the menu.">
<param name="desturl2" value="/menu_display.asp">
<param name="sizepause2" value="End">
<param name="delay2" value="4000">

<param name="desc3" value="Find links to the Moscow campus (and weather) under Links/To Moscow.">
<param name="sizepause3" value="End">
<param name="delay3" value="4000">

<param name="desc4" value="For information on our video conferencing rooms (schedule, size), check out the 'Rooms' link.">
<param name="sizepause4" value="End">
<param name="delay4" value="4000">

</applet>
	
	</td>
</table>

<!--#include virtual="/footer.inc"-->