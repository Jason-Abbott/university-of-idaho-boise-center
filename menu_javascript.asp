<% @LANGUAGE = PerlScript %>

<!-- 
Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
Last updated 01/29/99
-->

<%
#--------------------------------------------------------------
# This takes the item array from menudata.inc and goes through
# each array item.  It puts them in the right order by, after
# reading in a menu item's name, searching for all items that
# list that same name as a parent.  It then goes through all
# these, repeating the process recursively.  Because of the
# recursion, it can handle menu items to an infinite depth,
# though only about three levels fit well on the screen.

# This variation on the original script generates cascading
# style sheets that are manipulated with JavaScript, allowing
# the menu tree to be expanded and collapsed without reloading
# the menu page.  Each level of the menu is in its own
# division and class, a class that the JavaScript will hide
# or show depending on selection.
#--------------------------------------------------------------
# these images are used for the menu controls

$plus = "/graphics/plus.gif";
$minus = "/graphics/minus.gif";
$blank = "/graphics/blank.gif";
$depth = 0;
%>

<script LANGUAGE="JavaScript1.2">
<!--
// go through each division and hide children

function initIt(){
	tempColl = document.all.tags("DIV");
	for (i=0; i<tempColl.length; i++) {
		if (tempColl(i).className == "child") tempColl(i).style.display = "none";
	}
}

// cache graphics for fast display

plus = new Image(); plus.src = "<%=$plus%>";
minus = new Image(); minus.src = "<%=$minus%>";
blank = new Image(); blank.src = "<%=$blank%>";

// change style visibility and image

function expandIt(el) {
	whichEl = eval(el + "_child");
	if (whichEl.style.display == "none") {
		whichEl.style.display = "block";
		eval("document." + el + "_img.src=minus.src");
	} else {
		whichEl.style.display = "none";
		eval("document." + el + "_img.src=plus.src");
	}
   window.event.cancelBubble = true ;
}

onload = initIt;

//-->
</script>

<STYLE TYPE='text/css'>
	.child { font:10px/11px Arial; color:white; display:none }
	.highlight { color:yellow; }
	.root { font:12px/13px Arial; color:white; }
	A:hover { color:#FFCC00; }
</STYLE>

</head>
<body bgcolor="#000000" text="#FFFFFF" link="#FFFFFF" vlink="#FFFFFF" alink="#FFCC00" leftmargin=0 topmargin=0>

<table cellspacing=0 cellpadding=0 border=0 width="140">
<tr>
	<td colspan=2><a href="main_intro.asp" target="body">
	<img src="/graphics/menu_top.gif" width=116 height=27 alt="Home" border="0"></a></td>
<tr>
	<td width="11" valign="top"><a href="menu_display.asp" target="body">
	<img src="/graphics/menu_side.gif" width=11 height=363 alt="Display full menu in body" border="0"></a></td>
	<td width="129" valign=top>

<div CLASS="root">

<!--#include file="menu_data.inc"-->
<%
sub writeitem {
	for $i (0 .. $#item) {
		if ($item[$i][1] eq $_[0]) {		     # if correct level
			for $y (1 .. $depth) { $Response->write("<img src='$blank'>"); }
			$name = $item[$i][4];
			$name=~s/-//;
			if ($item[$i][4]=~/^-/) {		     # if menu category
				$Response->write("<img NAME='");
				$Response->write($name);
				$Response->write("_img' SRC='$plus' BORDER='0'>\n");
				$Response->write("<a href='#' onClick=\"expandIt('$name');");
				if ($item[$i][2] ne "") {    # if a url has been entered
					$Response->write("parent.frames['body'].location.href='$item[$i][2]';");
				}
				$Response->write("return false;\"");
				$Response->write(" onMouseOver=\"status='$item[$i][3]'; return true;\"");
				$Response->write(" onMouseOut=\"status=''\"");

				$Response->write(">\n$item[$i][0]</a><br>\n");
				$Response->write("\n\t<div ID='");
				$Response->write($name);
				$Response->write("_child' CLASS='child'>\n\n");
				$depth++;
				&writeitem($item[$i][4]);
				$Response->write("\n\t</div>\n\n");
			} else {								     # menu item, not category
				$Response->write("<img SRC='$blank'> ");
				$Response->write("<a href='$item[$i][2]' target='$item[$i][4]'");
				if ($item[$i][3] ne "") {       # if a long name has been entered
					$Response->write(" onMouseOver=\"status='$item[$i][3]';return true;\" onMouseOut=\"status=''\"");
				}
				$Response->write(">$item[$i][0]</a>\n<br>\n");
			}
		}
	}
	$depth--;
}
&writeitem("-root");

# display help option if not guest

if ($Session->{'user'} ne "guest") {
	$Response->write("<p><center><table cellpadding=2><tr><td bgcolor='444444'><a href='/help/help_intro.asp' target='body'><font face='arial' size=1><b>Computer Help</b></font></a></td></table></center>");
}
%>
	</div>
	</td>
</table>

</body>
</html>