
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
		<span id="orderName" class="label-control">Paracetamal</span> <span
			id="Label6" class="label-control"> from </span> <span id="storeName"
			class="label-control">Apollo pharmacy, Adyar, Chennai</span> <span
			id="Label7" class="label-control"> to </span> <span id="userName"
			class="label-control">Chandrashekhar G, Taramani</span>

	</div>
	<br />
	<h2
		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
		Order Status</h2>

	<br />

	<table align="center" style="border-top: 0">
		<tbody>
			<tr class="${orderStatus == 1 ? 'even' : 'odd'}">
				<td><g:message code="order.status.one" default="Order Placed" /></td>
				<td>Completed</td>
			</tr>
			<tr class="${orderStatus == 2 ? 'even' : 'odd'}">
				<td><g:message code="order.status.two" default="Order Accepted" /></td>
				<td>Pending</td>
			</tr>
			<tr class="${orderStatus == 3 ? 'even' : 'odd'}">
				<td><g:message code="order.status.three"
						default="Order in transit" /></td>
				<td>Pending</td>
			</tr>
			<tr class="${orderStatus == 4 ? 'even' : 'odd'}">
				<td><g:message code="order.status.four"
						default="Order delivered" /></td>
				<td>Pending</td>
			</tr>
		</tbody>
	</table>

	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
</body>
</html>
