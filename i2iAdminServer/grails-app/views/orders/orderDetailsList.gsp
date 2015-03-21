
<%@ page import="i2i.AdminServer.OrderDetailsCommand"%>
<%@ page import="i2i.AdminServer.Constants"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'orders.label', default: 'Orders')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>

<style>
.orderStatusTab ul {
	width: 60%;
}

.orderStatusTab a {
	color: white;
	border: 1px solid black;
	padding: 0.2em 0.6em;
}

.orderStatusTab a:hover,.orderStatusTab a.current {
	background-color: #333;
}

.orderStatusTab li {
	display: inline;
}
</style>

</head>
<body>
	<g:render template="/template/navigation" />
	<br />

	<%--<ul>--%>
	<%--	<div align="center">--%>
	<div align="center" class="orderStatusTab">
		<ul>
			<g:if test="${orderStatus == -1 }">
				<li><g:link class="current" controller="orders"
						action="showOrderDetailsList">All</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="orders" action="showOrderDetailsList">All</g:link></li>
			</g:else>

			<g:if test="${orderStatus== 1 }">
				<li><g:link class="current" controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_PLACED]">Placed</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_PLACED]">Placed</g:link></li>
			</g:else>

			<g:if test="${orderStatus== 2 }">
				<li><g:link class="current" controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_ACCEPTED]">Accepted</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_ACCEPTED]">Accepted</g:link></li>
			</g:else>
			
			<g:if test="${orderStatus== 3 }">
				<li><g:link class="current" controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_DISPATCHED]">Dispatched</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_DISPATCHED]">Dispatched</g:link></li>
			</g:else>

			<g:if test="${orderStatus== 4 }">
				<li><g:link class="current" controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_DELIVERED]">Delivered</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_DELIVERED]">Delivered</g:link></li>
			</g:else>
			<g:if test="${orderStatus== 0 }">
				<li><g:link class="current" controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_REJECTED]">Rejected</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="orders"
						action="showSortedOrderDetailsList"
						params="[orderStatus:Constants.ORDER_REJECTED]">Rejected</g:link></li>
			</g:else>
		</ul>
	</div>
	<%--	</div>--%>
	<%--	</ul>--%>
	<g:if test="${orderDetailsList}">
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
				<g:set var="orderId" value="${ordersInstance?.orderId}"></g:set>
				<tr style="cursor: pointer;"
					class="${(i % 2) == 0 ? 'even' : 'odd'}"
					onclick='document.location = "<g:createLink controller="orders"
					action="showOrderDetails"
					params="[orderId: orderId, brandName: brandName]"/>" '>

					<td>
						${fieldValue(bean: ordersInstance,  field: "brandName")}
					</td>

					<td>
						${fieldValue(bean: ordersInstance, field: "name")}
					</td>

					<td>
						${fieldValue(bean: ordersInstance, field: "addressLine1")} <br>
						${fieldValue(bean: ordersInstance, field: "addressLine2")} <br>
						${fieldValue(bean: ordersInstance, field: "circle")} <br> ${fieldValue(bean: ordersInstance, field: "city")}
					</td>

					<td><g:set var="orderStatus"
							value="${ordersInstance?.orderStatus}" /> <%--						${fieldValue(bean: ordersInstance, field: "orderStatus")}--%>

						<g:if test="${orderStatus == 4 }">Order Delivered</g:if> <g:elseif
							test="${orderStatus == 3 }">Order Dispatched</g:elseif> <g:elseif
							test="${orderStatus == 2 }">Order Accepted</g:elseif> <g:elseif
							test="${orderStatus == 1 }">Order Placed</g:elseif> <g:elseif
							test="${orderStatus < 1 }">Order Rejected</g:elseif></td>
				</tr>
			</g:each>
		</tbody>
	</table>
	</g:if>
	<g:else>
	<p align="center">No orders!</p>
	</g:else>
	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
</body>
</html>
