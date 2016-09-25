<% @LANGUAGE = PerlScript %>

<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 02/03/99
-->

<html>
<body background="/graphics/back_dark.jpg" link="#443333" vlink="#443333">

<table width="100%" border="0" cellspacing="0" cellpadding="5" bgcolor="#FFCC00">
<tr>
	<td><font face="Arial, Helvetica" size=4>Navigation Menu

<!--#include virtual="/header_end.inc"-->

<font face="Arial, Helvetica">
<ul>

<!--#include file="menu_data.inc"-->

<%

#--------------------------------------------------------------
# This takes the item array from menudata.inc and goes through
# each array item.  It puts them in the right order by, after
# reading in a menu item's name, searching for all items that
# list that same name as a parent.  It then goes through all
# these, repeating the process recursively, spacing the menu
# items according to their depth in the menu tree.  Because
# of the recursion, it can handle menu items to an infinite
# depth, though only about three levels fit well on the screen.
#--------------------------------------------------------------

$depth = 0;
&writeitem("-root");

sub writeitem {
	for $i (0 .. $#item) {
		if ($item[$i][1] eq $_[0]) {		     # if correct level
			$size = 4 - $depth;
			$Response->write("<li><font size=$size>");
			if ($item[$i][4]=~/^-/) {		     # if category
				$Response->write("$item[$i][0]</font>\n<ul>");
				$depth++;
				&writeitem($item[$i][4]);
			} else {                           # this item is a link, not a category
				$Response->write("<a href=\"$item[$i][2]\" target=\"$item[$i][4]\"");
				if ($item[$i][3] ne "") {  # if a long name has been entered
					$Response->write(" onMouseOver=\"status='$item[$i][3]';return true;\" onMouseOut=\"status=''\"");
				}
				$Response->write(">$item[$i][0]</a></font>\n");
			}
		}
	}
	$depth--;
	$Response->write("</ul>");
}

%>

<!--#include virtual="/footer.inc"-->