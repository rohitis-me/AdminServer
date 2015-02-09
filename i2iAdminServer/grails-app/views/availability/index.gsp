
<%@ page import="i2i.AdminServer.Availability" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'availability.label', default: 'Availability')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-availability" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-availability" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="storeId" title="${message(code: 'availability.storeId.label', default: 'Store Id')}" />
					
						<g:sortableColumn property="brandId" title="${message(code: 'availability.brandId.label', default: 'Brand Id')}" />
					
						<g:sortableColumn property="availabilityIndex" title="${message(code: 'availability.availabilityIndex.label', default: 'Availability Index')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${availabilityInstanceList}" status="i" var="availabilityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${availabilityInstance.id}">${fieldValue(bean: availabilityInstance, field: "storeId")}</g:link></td>
					
						<td>${fieldValue(bean: availabilityInstance, field: "brandId")}</td>
					
						<td>${fieldValue(bean: availabilityInstance, field: "availabilityIndex")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${availabilityInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
