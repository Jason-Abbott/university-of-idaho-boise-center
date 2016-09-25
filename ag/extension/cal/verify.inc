<%
if Session("ext") = "" then
	Session("url") = Request.ServerVariables("URL")
	Session("query") = Request.ServerVariables("QUERY_STRING")
	response.redirect "ext_cal_auth.asp"
end if
%>