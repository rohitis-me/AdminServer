<!DOCTYPE html>
<html>
	<head>
		<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
		<meta name="layout" content="pillocateLayout">
		<g:if env="development"><link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css"></g:if>
	</head>
	<body>
		<g:render template="/template/navigationConsumer" />
<%--		<g:if env="development">--%>
<%--			<g:renderException exception="${exception}" />--%>
<%--		</g:if>--%>
			<div align="center">
				<p>Oops... you seem to have navigated to an invalid link!</p>
			</div>
	</body>
</html>
