
<%@ page import="i2i.AdminServer.User.Feedback" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'feedback.label', default: 'Feedback')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-feedback" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-feedback" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'feedback.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="message" title="${message(code: 'feedback.message.label', default: 'Message')}" />
					
						<g:sortableColumn property="emailID" title="${message(code: 'feedback.emailID.label', default: 'Email ID')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${feedbackInstanceList}" status="i" var="feedbackInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${feedbackInstance.id}">${fieldValue(bean: feedbackInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: feedbackInstance, field: "message")}</td>
					
						<td>${fieldValue(bean: feedbackInstance, field: "emailID")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${feedbackInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
