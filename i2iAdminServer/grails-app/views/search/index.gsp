<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<title><g:message message="i2i-Home page" /></title>
<%--<r:require module="jquery-ui" />--%>
</head>

<body>
<%--	<h2--%>
<%--		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">--%>
<%--		Could not find your medicine? Search here!</h2>--%>
<%--			<p--%>
<%--		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">--%>
<%--		online portal to locate pharmacy selling your medicine.</p>--%>
<%--	<br />--%>
<%--	<br />--%>

	<g:render template="/template/searchBox"></g:render>
	<br/>
		<div style="padding-left: 10%; font-size:x-large;"><p><g:message code="search.intro.message" default="Online portal to find medicines near you"/> </p></div> 
	<br />
</body>
</html>
