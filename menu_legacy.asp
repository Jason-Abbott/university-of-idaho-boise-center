<% @LANGUAGE = PerlScript %>

<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 02/03/99
-->

<html>
<body bgcolor="#000000" text="#FFFFFF" link="#FFFFFF" vlink="#FFFFFF" alink="#FFCC00" leftmargin=0 topmargin=0>

<table cellspacing=0 cellpadding=0 border=0 width="140">
<tr>
	<td colspan=2><a href="main_intro.asp" target="body">
	<img src="/graphics/menu_top.gif" width=116 height=27 alt="Home" border="0"></a></td>
<tr>
	<td width="11" valign="TOP"><a href="menu_display.asp" target="body">
	<img src="/graphics/menu_side.gif" width=11 height=363 alt="Display full menu in body" border="0"></a></td>
	<td width="129" valign=top>
<font face="Arial, Helvetica">
<font size=2>

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
# initialize variables

$plus = "<img src='/graphics/plus.gif'>";
$minus = "<img src='/graphics/minus.gif'>";
$blank = "<img src='/graphics/blank.gif'>";
$depth = 0; $i = 0; $font = 2;

# get current menu condition

if ($Request->querystring("menu")->item eq "") {
	$menu = "0" x ($#item + 1);
} else {
	$menu = $Request->QueryString("menu")->item;
}

&writeitem("-root");

sub writeitem {
	for $i (0 .. $#item) {
		if ($item[$i][1] eq $_[0]) {		     # if correct level
			if ($font != 2-$depth) {
				$font = (2-$depth);
				$Response->write("</font><font size=$font>");
			}
			for $y (1 .. $depth) { $Response->write("$blank"); }
			if ($item[$i][4]=~/^-/) {		     # if category
				my $loopmenu = $menu;
				my $usedmenu = "0" x ($#item + 1);
				$link1 = "<a href=\"menu_legacy.asp?menu=";
				$link2 = "onMouseOver=\"status='$item[$i][3]';return true;\" onMouseOut=\"status=''\">$item[$i][0]</a>\n<br>\n\n";
				if (substr($menu,$i,1) && !(substr($usedmenu,$i,1))) {
					substr($loopmenu,$i,1) = 0;
					substr($usedmenu,$i,1) = 1;
					$Response->write("$minus $link1$loopmenu\" $link2");
					$depth++;
					&writeitem($item[$i][4]);
				} else {                        # expand this category
					substr($loopmenu,$i,1) = 1;
					$Response->write("$plus $link1$loopmenu\"");
					if ($item[$i][2] ne "") {    # if a url has been entered
						$Response->write(" onClick=\"parent.frames['body'].location.href='$item[$i][2]';return true;\"");
					}
					$Response->write(" $link2");
				}
			} else {                           # this item is a link, not a category
				$Response->write("$blank <a href=\"$item[$i][2]\" target=\"$item[$i][4]\"");
				if ($item[$i][3] ne "") {  # if a long name has been entered
					$Response->write(" onMouseOver=\"status='$item[$i][3]';return true;\" onMouseOut=\"status=''\"");
				}
				$Response->write(">$item[$i][0]</a>\n<br>\n\n");
				substr($menu,$i,1) = 1;
			}
		}
	}
	$depth--;
}

# display HelpDesk link if not guest

if ($Session->{'user'} ne "guest") {
	$Response->write("<p><center><table cellpadding=2><tr><td bgcolor='444444'><a href='/help/help_intro.asp' target='body'><font face='arial' size=1><b>Computer Help</b></font></a></td></table></center>");
}

%>
	</font>
	</td>
</table>
<p>

</body>
</html>