
<%@ page import="i2i.AdminServer.OrderDetailsCommand"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="adminLayout">
<g:set var="entityName"
	value="${message(code: 'orders.label', default: 'Orders')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<g:render template="/template/navigation" />

<%--	<nav>--%>
<%--		<ul>--%>
<%--			<li><g:link controller="store" action="showStoreProfile">Profile</g:link></li>--%>
<%--			<li><g:link class="current" controller="orders"--%>
<%--					action="showOrderDetailsList">Orders</g:link></li>--%>
<%--			<li><g:link controller="availability"--%>
<%--					action="showInventoryDetails">Inventory</g:link></li>--%>
<%--		</ul>--%>
<%--	</nav>--%>
	<h2>Orders list</h2>
	<br />
	<table align="center">
		<thead>
			<tr>

				<g:sortableColumn property="brandName"
					title="${message(code: 'orders.personId.label', default: 'Brand name')}" />

				<g:sortableColumn property="Name"
					title="${message(code: 'orders.brandId.label', default: 'Name')}" />

				<g:sortableColumn property="Address"
					title="${message(code: 'orders.storeId.label', default: 'Address')}" />

				<g:sortableColumn property="orderStatus"
					title="${message(code: 'orders.orderStatus.label', default: 'Order Status')}" />

			</tr>
		</thead>
		<tbody>
			<g:each in="${orderDetailsList}" status="i" var="ordersInstance">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

					<td><g:link action="showOrderDetails"
							params="[orderId: ordersInstance.orderId]">
							${fieldValue(bean: ordersInstance, field: "brandName")}
						</g:link></td>

					<td>
						${fieldValue(bean: ordersInstance, field: "name")}
					</td>

					<td>
						${fieldValue(bean: ordersInstance, field: "addressLine1")} <br>
						${fieldValue(bean: ordersInstance, field: "addressLine2")} <br>
						${fieldValue(bean: ordersInstance, field: "circle")} <br> ${fieldValue(bean: ordersInstance, field: "city")}
					</td>

					<td>
						${fieldValue(bean: ordersInstance, field: "orderStatus")}
					</td>

				</tr>
			</g:each>
		</tbody>
	</table>
	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
</body>
</html>
