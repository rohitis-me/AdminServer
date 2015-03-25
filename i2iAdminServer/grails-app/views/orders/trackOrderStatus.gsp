
<%@page import="java.lang.invoke.MethodHandleNatives.Constants"%>
<%@ page import="i2i.AdminServer.Orders"%>
<%@ page import="i2i.AdminServer.Constants"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'track.order.status.label', default: 'TrackOrder')}" />
<title><g:message message="Track Order" /></title>
<%--<meta http-equiv="refresh" content="90">--%>
</head>

<body>
	<g:render template="/template/navigationClient" />
	<br />

	<g:form controller="orders" action="showTrackedOrderDetails"
		method="get">
		<div align="center">
			<input name="trackingId" required class="textbox-control"
				placeholder="Enter Order tracking id" style="width: 40%;"
				value="${trackingId}" />
			<%--				<g:hiddenField name="brandId" id="brand_id" value="${brandId}"/>--%>
			<%--				<g:hiddenField name="inventoryId" id="inventory_id" value="${inventoryId}"/>--%>
			<input type="submit" name="searchButton" value="Track order"
				class="btn btn-default" style="width: 20%; height: 33px" />
		</div>
	</g:form>
	
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:if test="${orderStatusCommand }">
		<h2 style="text-align: center;">Order Status</h2>
		<g:set var="orderStatus" value="${orderStatusCommand?.orderStatus}" />
		<table align="center" class="mobileTable"
			style="border: 1px solid #DFDFDF;">
			<tr>
				<td style="width: 25%"><g:if
						test="${orderStatus == Constants.ORDER_PLACED}">
						<input type="radio" name="orderstatus" checked="checked" disabled>
						<label class="label-control" style="font-style: italic;font-weight: bold;">Placed</label>
					</g:if> <g:else>
						<input type="radio" name="orderstatus" disabled>
						<label class="label-control" style="font-style: italic;">Placed</label>
					</g:else></td>
				<td style="width: 25%"><g:if
						test="${orderStatus == Constants.ORDER_ACCEPTED}">
						<input type="radio" name="orderstatus" checked="checked" disabled>
						<label style="font-style: italic;font-weight: bold;">Accepted</label>
					</g:if> <g:else>
						<input type="radio" name="orderstatus" disabled>
						<label style="font-style: italic;">Accepted</label>
					</g:else></td>
			</tr>
			<tr>
				<td style="width: 25%"><g:if
						test="${orderStatus == Constants.ORDER_DISPATCHED}">
						<input type="radio" name="orderstatus" checked="checked" disabled>
						<label style="font-style: italic;font-weight: bold;">Dispatched</label>
					</g:if> <g:else>
						<input type="radio" name="orderstatus" disabled>
						<label style="font-style: italic;">Dispatched</label>
					</g:else></td>
				<td style="width: 25%"><g:if
						test="${orderStatus == Constants.ORDER_DELIVERED}">
						<input type="radio" name="orderstatus" checked="checked" disabled>
						<label style="font-style: italic;font-weight: bold;">Delivered</label>
					</g:if> <g:else>
						<input type="radio" name="orderstatus" disabled>
						<label style="font-style: italic;">Delivered</label>
					</g:else></td>
			</tr>
		</table>

		<h2 align="center">Order Details</h2>
		<table align="center" style="border-top: 0;">
			<tbody>
				<tr>
					<td style="width: 30%"><span class="label-control">Order
							Name: </span></td>
					<td style="width: 70%"><g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="brandName" /></td>
				</tr>
				<tr>
					<td style="width: 30%"><span class="label-control">Tracking Id: </span></td>
					<td style="width: 70%"><g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="trackingId" /></td>
				</tr>
				<tr>
					<td><span class="label-control">Expected Delivery: </span></td>
					<td><g:formatDate
							date="${orderStatusCommand.estimatedDeliveryTime }"
							format="${Constants.dateFormat }" /></td>
				</tr>
				<tr>
					<td><span class="label-control">Seller: </span></td>
					<td><g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="storeName" /> <span
						class="label-control">,</span> <g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="storeAddressLine1" /><span
						class="label-control">,</span> <g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="storeAddressLine2" />, <g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="storeCircle" />, <g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="storeCity" /></td>
				</tr>
				<tr>
				<td><span class="label-control">Store Contact no.: </span>
				</td>
				<td>
				<g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="storePhoneNumber" /><span
						class="label-control"></span>
				</td>
				</tr>
			</tbody>
		</table>

		<div align="center">
			<g:form>
				<g:hiddenField name="orderId" value="${orderStatusCommand.orderId }" />
				<g:actionSubmit class="btn btn-default" action="placeNextOrder"
					value="${message(code: 'order.place.next.button', default: 'Next Order')}" />
				<%--			<input class="btn btn-default" type="button" onClick="history.go(0)" value="Refresh">--%>
				<g:actionSubmit class="btn btn-default" action="cancelOrder"
					value="${message(code: 'order.cancel.order.button', default: 'Cancel Order')}"
					onclick="return confirm('${message(code: 'order.status.reject.message')}');" />
			</g:form>
		</div>
	</g:if>
	<g:elseif test="${trackingId}">
		<br/><div align="center">
			<g:message code="invalid.order.trackingid"
				default="Invalid Tracking ID" />
		</div>
	</g:elseif>

	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
	<br />
</body>
</html>
