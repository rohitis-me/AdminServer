
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>
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
					
						<g:sortableColumn property="brandName" title="${message(code: 'orders.personId.label', default: 'Brand name')}" />
					
						<g:sortableColumn property="Name" title="${message(code: 'orders.brandId.label', default: 'Name')}" />
					
						<g:sortableColumn property="Address" title="${message(code: 'orders.storeId.label', default: 'Address')}" />
					
						<g:sortableColumn property="orderStatus" title="${message(code: 'orders.orderStatus.label', default: 'Order Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${orderDetailsList}" status="i" var="ordersInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="showOrderDetails" params="[ orderId: ordersInstance.orderId]">${fieldValue(bean: ordersInstance, field: "brandName")}</g:link></td>
					
						<td>${fieldValue(bean: ordersInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: ordersInstance, field: "addressLine1")} <br>
						${fieldValue(bean: ordersInstance, field: "addressLine2")} <br>
						${fieldValue(bean: ordersInstance, field: "circle")} <br>
						${fieldValue(bean: ordersInstance, field: "city")}</td>
					
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
