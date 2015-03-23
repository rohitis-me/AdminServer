<!DOCTYPE html>
<html>
	<head>
		<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
		<meta name="layout" content="searchLayout">
		<g:if env="development"><link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css"></g:if>
	</head>
	<body>
<%--		<g:if env="development">--%>
<%--			<g:renderException exception="${exception}" />--%>
<%--		</g:if>--%>
			<ul class="errors">
				<li>Oops... you seem to have navigated to an invalid link!</li>
			</ul>
	</body>
</html>
