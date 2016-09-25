<%
# Copyright 1999 Jason Abbott (jabbott@uidaho.edu)
# Last updated 02/03/99
# ---------------------------------------------------------------
# A 2D array.  If the item is an expanding menu item
# then the four fields are:
# title, -parent name, url [optional], long name, -name

# If the item is a link to content then the four
# fields are:
# title, -parent name, url, long name [optional], frame target

# The hyphens (-) are necessary where specified.  They
# enable the script to differentiate between menu
# items and link items, and read the fields accordingly.

# No particular ordering is required.  The script will order the
# items by parsing parent-child relationships.
# ---------------------------------------------------------------

@item = (
[ "Colleges","-root","/college_intro.asp","Colleges in the Boise Center","-colleges" ],

[ "Programs","-root","/program_intro.asp","Programs at the Boise Center","-programs" ],
[ "TechHelp&#153;","-programs","http://www.techhelp.org","","body" ],
[ "Eco-hydraulics","-programs","/engr/eco-hydraulics.asp","","body" ],
[ "Boise Alumni","-programs","/alumni/alumni_intro.asp","","body" ],
[ "Red River","-programs","/redriver","Red River Meadow Restoration Project","_top" ],
[ "MRC","-programs","/mrc","Microelectronic Research Center","_top" ],
[ "QSC","-programs","/ed/qsc","Quality Schools Consortium","_top" ],
[ "ABE","-programs","/ed/abe/abe_intro.asp","Adult Basic Education","body" ],

[ "Courses","-root","","Courses offered at the Boise Center","-courses" ],
[ "Short Courses","-courses","/courses/short/short_intro.asp","Short Courses","body" ],
[ "Engineering","-courses","/engr/engr_course_intro.asp","","body" ],
[ "Time Sched.","-courses","http://max.csrv.uidaho.edu/schedule.htm","","body" ],
[ "Register","-courses","https://max.csrv.uidaho.edu/PROD/owa/hwgkwbis.P_WWWLogin","","body" ],
# [ "ADED489","-courses","/courses/aded589/default.htm","","_top" ],
[ "CE428/AgE458","-courses","/courses/ce428/overview.asp","","body" ],
[ "CE421","-courses","/courses/ce421/default.html","","_top" ],
[ "CE504","-courses","/courses/ce504/default.html","","_top" ],
[ "EE445","-courses","/uiboise/mrcboise/courses/vlsi445f98.htm","","_top" ],
[ "EE486","-courses","/uiboise/mrcboise/courses/ee486f98.htm","","_top" ],
[ "EE504","-courses","/uiboise/mrcboise/courses/ee504f98.htm","","_top" ],
[ "EE545","-courses","/uiboise/mrcboise/courses/vlsif98545.htm","","_top" ],
[ "ME547","-courses","/courses/jsteciak/ME547/SYLLABUSF98.asp","","_top" ],

[ "People","-root","","Boise Center Employees","-people" ],
[ "Faculty","-people","","Boise Center Faculty","-faculty" ],
[ "Education","-faculty","/employee/list.asp?college=Education&type=faculty","","body" ],
[ "Engineering","-faculty","/employee/list.asp?college=Engineering&type=faculty","","body" ],
[ "Staff","-people","","Boise Center Staff","-staff" ],
[ "Education","-staff","/employee/list.asp?college=Education&type=staff","","body" ],
[ "Engineering","-staff","/employee/list.asp?college=Engineering&type=staff","","body" ],
[ "Agriculture","-staff","/employee/list.asp?college=Agriculture&type=staff","","body" ],
[ "Law","-staff","/employee/list.asp?college=Law&type=staff","","body" ],
[ "Other","-staff","/employee/list.asp?college=Other&type=staff","","body" ],
[ "Full List","-people","/employee/full_list.asp","","body" ],

[ "Education","-colleges","/ed/ed_intro.asp","Education in Boise","-ed" ],
[ "Faculty","-ed","/employee/list.asp?college=Education&type=faculty","Education Faculty","body" ],
[ "Staff","-ed","/employee/list.asp?college=Education&type=staff","Education Staff","body" ],
[ "QSC","-ed","/ed/qsc","Quality Schools Consortium","_top" ],
[ "ABE","-ed","/ed/abe/abe_intro.asp","Adult Basic Education","body" ],

[ "Engineering","-colleges","/engr/engr_intro.asp","Engineering in Boise","-engr" ],
[ "Faculty","-engr","/employee/list.asp?college=Engineering&type=faculty","Engineering Faculty","body" ],
[ "Staff","-engr","/employee/list.asp?college=Engineering&type=staff","Engineering Staff","body" ],
[ "Courses","-engr","/engr/engr_course_intro.asp","Engineering Courses","body" ],
[ "MRC","-engr","/mrc","Microelectronic Research Center","_top" ],
[ "TechHelp&#153;","-engr","http://www.techhelp.org","TechHelp","body" ],
[ "Eco-hydraulics","-engr","/engr/eco-hydraulics.asp","","body" ],
[ "Red River","-engr","/redriver","Red River Meadow Restoration Project","_top" ],
[ "Short Courses","-engr","/courses/short/short_intro.asp","Short Courses","body" ],

[ "Agriculture","-colleges","/ag/ag_intro.asp","Agriculture in Boise","-ag" ],
[ "Staff","-ag","/employee/list.asp?college=Agriculture&type=staff","Agriculture Staff","body" ],
[ "FFA Software","-ag","/ag/ffa_download.asp","Download FFA software","body" ],

[ "Law","-colleges","/employee/list.asp?college=Law&type=staff","Law in Boise","body" ],

[ "Coop. Ext.","-root","/ag/extension/ext_intro.asp","Cooperative Extension System","-coop" ],
[ "Calendar","-coop","/ag/extension/cal/ext_cal.asp","","body" ],
[ "Ada","-coop","/ag/extension/ada","Ada County","_top" ],
[ "Adams","-coop","/ag/extension/adams.asp","Adams County","body" ],
[ "Boise","-coop","/ag/extension/boise.asp","Boise County","body" ],
[ "Canyon","-coop","/ag/extension/canyon.asp","Canyon County","body" ],
[ "Elmore","-coop","/ag/extension/elmore.asp","Elmore County","body" ],
[ "Gem","-coop","/ag/extension/gem.asp","Gem County","body" ],
[ "Owyhee","-coop","/ag/extension/owyhee.asp","Owyhee County","body" ],
[ "Payette","-coop","/ag/extension/payette.asp","Payette County","body" ],
[ "Valley","-coop","/ag/extension/valley/valley.htm","Valley County","body" ],
[ "Washington","-coop","/ag/extension/washington.asp","Washington County","body" ],
[ "Hydrology","-coop","/ag/extension/hydro.asp","USDA HUA Water Quality Project","body" ],
[ "FFA Software","-coop","/ag/ffa_download.asp","Download FFA software","body" ],

[ "Rooms","-root","","Boise Center Rooms","-rooms" ],
[ "Computer Lab","-rooms","/rooms/lab/lab_intro.asp","","body" ],
[ "Classroom 3","-rooms","/rooms/classroom3.asp","Classroom 3/Video Conference 2","body" ],
[ "Video Conf.","-rooms","/rooms/vidconference.asp","Video Conference","body" ],

[ "Links","-root","","Links to related sites","-links" ],
[ "To Moscow","-links","","Moscow Counterparts","-moscow" ],
[ "U.I. Home","-moscow","http://www.uidaho.edu","","_top" ],
[ "Engineering","-moscow","http://www.uidaho.edu/engr","","_top" ],
[ "Education","-moscow","http://www.uidaho.edu/ed","","_top" ],
[ "Agriculture","-moscow","http://www.uidaho.edu/ag","","_top" ],
[ "Coop. Ext.","-moscow","http://www.uidaho.edu/ag/extension","","_top" ],
[ "Alumni Office","-moscow","http://www.uidaho.edu/alumni","","_top" ],
[ "MRC","-moscow","http://www.mrc.uidaho.edu/","Microelectronic Research Center","_top" ],
[ "Media Library","-moscow","http://www.ets.uidaho.edu/dig/libintro.html","","_top" ],
[ "Weather","-moscow","http://www.weather.com/weather/cities/us_wa_pullman.html","","body" ],
[ "In Boise","-links","","Information on Boise","-boise" ],
[ "News","-boise","http://www.ktvb.com/news/story_vw.html","","_top" ],
[ "Weather","-boise","http://www.weather.com/weather/us/cities/ID_Boise.html","","body" ],
[ "City of Boise","-boise","http://www.boise.org","","_top" ],
[ "River Festival","-boise","http://www.boiseriverfestival.org/","","_top" ],
[ "U.I. Home","-links","http://www.uidaho.edu","","_top" ],
[ "Career Services","-links","/ed/career_services.asp","","body" ],
[ "FFA Software","-links","/ag/ffa_download.asp","","body" ],
[ "NEVADA","-links","/engr/nevada.asp","","body" ],
[ "Engr. Outreach","-links","http://www.uidaho.edu/evo","","_top" ],
[ "Grad. Catalog","-links","http://www.uidaho.edu/grad_catalog","","_top" ],
[ "Bookstore","-links","http://www.bookstore.uidaho.edu","","_top" ],
[ "Library","-links","http://www.lib.uidaho.edu","","_top" ],

[ "Calendar","-root","/cal/cal.asp","","body" ],
[ "Contact Us","-root","/contact.asp","phone, FAX, e-mail, address","body" ],
[ "Locate Us","-root","/map/location.asp","Three maps to help you find us","body" ],

);
%>