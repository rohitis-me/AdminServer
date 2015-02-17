
<%@ page import="i2i.AdminServer.OrderDetailsCommand"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'orders.label', default: 'Orders')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<g:render template="/template/navigation" />
	<br />
	<table align="center" style="border-top: 0">
		<tr>
			<td style="width: 30%"><span id="personId-label"
				class="label-control"><g:message code="orders.personId.label"
						default="Person Name" /></span></td>
			<g:if test="${orderDetailsCommand?.name}">
				<td><span class="label-control"
					aria-labelledby="personId-label"><g:fieldValue
							bean="${orderDetailsCommand}" field="name" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span id="brandId-label" class="label-control"><g:message
						code="orders.brandId.label" default="Brand Name" /></span></td>
			<g:if test="${orderDetailsCommand?.brandName}">
				<td><span class="label-control" aria-labelledby="brandId-label"><g:fieldValue
							bean="${orderDetailsCommand}" field="brandName" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span id="storeId-label" class="label-control"><g:message
						code="orders.storeId.label" default="Store Name" /></span></td>
			<g:if test="${orderDetailsCommand?.storeName}">
				<td><span class="label-control" aria-labelledby="storeId-label"><g:fieldValue
							bean="${orderDetailsCommand}" field="storeName" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span id="orderStatus-label" class="label-control"><g:message
						code="orders.orderStatus.label" default="Order Status" /></span></td>
						<g:set var="orderStatus"
							value="${orderDetailsCommand?.orderStatus}" />
				<td><g:if test="${orderStatus == 4 }">
				Order delivered
				</g:if> <g:elseif test="${orderStatus == 3 }">
				Order in transit
				</g:elseif>
						<g:elseif test="${orderStatus == 2 }">
				Order Accepted</g:elseif>
						<g:elseif test="${orderStatus == 1 }">
				Order Placed</g:elseif>
				<g:elseif test="${orderStatus < 1 }">Order rejected</g:elseif></td>
			<%--			<g:if test="${orderDetailsCommand?.orderStatus}">--%>
<%--				<td><span class="label-control"--%>
<%--					aria-labelledby="orderStatus-label"><g:fieldValue--%>
<%--							bean="${orderDetailsCommand}" field="orderStatus" /></span></td>--%>
<%--			</g:if>--%>
		</tr>
	</table>
	<div align="center">
		<g:form>
			<g:hiddenField name="orderId" value="${orderDetailsCommand.orderId }" />

			<g:actionSubmit class="btn btn-default" action="acceptOrder"
				value="${message(code: 'order.status.accept.button', default: 'Accept Order')}" />
			<g:actionSubmit class="btn btn-default" action="rejectOrder"
				value="${message(code: 'order.status.reject.button', default: 'Reject Order')}"
				onclick="return confirm('${message(code: 'order.status.reject.message')}');" />
		</g:form>
	</div>
</body>
</html>
