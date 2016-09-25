<!--#include virtual="/authenticate.inc"-->
<%
Set bc=Server.CreateObject("MSWC.BrowserType")
if bc.browser = "IE" and bc.version >= 4 then
	response.redirect "menu_javascript.asp"
else
	response.redirect "menu_legacy.asp"
end if
%>