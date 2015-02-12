
<%@ page import="i2i.AdminServer.Orders"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'orders.label', default: 'Orders')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>

	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>

		<div class="ordername" align="center">
			<g:fieldValue class="label-control" bean="${orderDetailsCommand}"
				field="brandName" />
			<span class="label-control"> from </span>
			<g:fieldValue class="label-control" bean="${orderDetailsCommand}"
				field="storeName" />
							<span class="label-control"> to </span>
										<g:fieldValue class="label-control" bean="${orderDetailsCommand}"
				field="name" />
				
		</div>
	<br />
	<h2
		style="text-align: center;">
		Order Status</h2>
	<br />
	<g:set var="orderStatus"
	value="${orderDetailsCommand?.orderStatus}" />

	<table align="center" style="border-top: 0">
		<tbody>
			<tr class="${orderStatus == 1 ? 'even' : 'odd'}">
				<td><g:message code="order.status.one" default="Order Placed" /></td>
				<g:if test="${orderStatus >= 1 }">
				<td>Completed</td>
				</g:if>
				<g:else>
				<td>Pending</td>
				</g:else>
			</tr>
			<tr class="${orderStatus == 2 ? 'even' : 'odd'}">
				<td><g:message code="order.status.two" default="Order Accepted" /></td>
				<g:if test="${orderStatus >= 2 }">
				<td>Completed</td>
				</g:if>
				<g:else>
				<td>Pending</td>
				</g:else>
			</tr>
			<tr class="${orderStatus == 3 ? 'even' : 'odd'}">
				<td><g:message code="order.status.three"
						default="Order in transit" /></td>
				<g:if test="${orderStatus >= 3 }">
				<td>Completed</td>
				</g:if>
				<g:else>
				<td>Pending</td>
				</g:else>
			</tr>
			<tr class="${orderStatus == 4 ? 'even' : 'odd'}">
				<td><g:message code="order.status.four"
						default="Order delivered" /></td>
				<g:if test="${orderStatus >= 4 }">
				<td>Completed</td>
				</g:if>
				<g:else>
				<td>Pending</td>
				</g:else>
			</tr>
		</tbody>
	</table>

	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
</body>
</html>
