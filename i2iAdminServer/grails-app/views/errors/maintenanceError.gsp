<!DOCTYPE html>
<html>
	<head>
		<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
		<meta name="layout" content="pillocateLayout">
		<g:if env="development"><link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css"></g:if>
	</head>
	<body>
<%--		<g:render template="/template/navigationConsumer" />--%>
<br/>
<br/>
<br/>
			<div align="center">
				<h1><i class="glyphicon glyphicon-warning-sign"></i>Temporarily Down for Maintenance</h1>
				<h2>We are performing scheduled maintenance. We should be back online shortly.</h2>
			</div>
	</body>
</html>
