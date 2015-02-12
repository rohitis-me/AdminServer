
<%@ page import="i2i.AdminServer.Store" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-store" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-store" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="storeId" title="${message(code: 'store.storeId.label', default: 'Store Id')}" />
					
						<g:sortableColumn property="storeName" title="${message(code: 'store.storeName.label', default: 'Store Name')}" />
					
						<g:sortableColumn property="addressLine1" title="${message(code: 'store.addressLine1.label', default: 'Address Line1')}" />
					
						<g:sortableColumn property="addressLine2" title="${message(code: 'store.addressLine2.label', default: 'Address Line2')}" />
					
						<g:sortableColumn property="circle" title="${message(code: 'store.circle.label', default: 'Circle')}" />
					
						<g:sortableColumn property="city" title="${message(code: 'store.city.label', default: 'City')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${storeInstanceList}" status="i" var="storeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${storeInstance.id}">${fieldValue(bean: storeInstance, field: "storeId")}</g:link></td>
					
						<td>${fieldValue(bean: storeInstance, field: "storeName")}</td>
					
						<td>${fieldValue(bean: storeInstance, field: "addressLine1")}</td>
					
						<td>${fieldValue(bean: storeInstance, field: "addressLine2")}</td>
					
						<td>${fieldValue(bean: storeInstance, field: "circle")}</td>
					
						<td>${fieldValue(bean: storeInstance, field: "city")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${storeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
