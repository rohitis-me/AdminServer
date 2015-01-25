
<%@ page import="i2i.AdminServer.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			
		</div>
		<div id="list-orders" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			
				
					<tr class="${orderStatus == 1 ? 'active' : 'active'}">
					
						<td><g:message code="order.status.one" default="Order Placed" /></td>
					
					</tr>
					
					<tr class="${orderStatus == 2 ? 'active' : 'inactive'}">
					
						<td><g:message code="order.status.two" default="Order Accepted" /></td>
					
					</tr>
					
					<tr class="${orderStatus == 3 ? 'active' : 'inactive'}">
					
						<td><g:message code="order.status.three" default="Order in transit" /></td>
					
					</tr>
					
					<tr class="${orderStatus == 4 ? 'active' : 'inactive'}">
					
						<td><g:message code="order.status.four" default="Order delivered" /></td>
					
					</tr>
				
			</table>
			<div class="pagination">
				<g:paginate total="${ordersInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
