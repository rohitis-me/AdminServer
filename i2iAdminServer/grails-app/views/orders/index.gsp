
<%@ page import="i2i.AdminServer.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-orders" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="personId" title="${message(code: 'orders.personId.label', default: 'Person Id')}" />
					
						<g:sortableColumn property="brandId" title="${message(code: 'orders.brandId.label', default: 'Brand Id')}" />
					
						<g:sortableColumn property="storeId" title="${message(code: 'orders.storeId.label', default: 'Store Id')}" />
					
						<g:sortableColumn property="orderStatus" title="${message(code: 'orders.orderStatus.label', default: 'Order Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${ordersInstanceList}" status="i" var="ordersInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${ordersInstance.id}">${fieldValue(bean: ordersInstance, field: "personId")}</g:link></td>
					
						<td>${fieldValue(bean: ordersInstance, field: "brandId")}</td>
					
						<td>${fieldValue(bean: ordersInstance, field: "storeId")}</td>
					
						<td>${fieldValue(bean: ordersInstance, field: "orderStatus")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ordersInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
