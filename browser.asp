<%
Set bc=Server.CreateObject("MSWC.BrowserType")
response.write bc.browser & "<br>"
response.write bc.platform & "<br>"
response.write bc.version & "<br>"
%>