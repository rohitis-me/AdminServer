
<%@ page import="i2i.AdminServer.OrderDetailsCommand"%>
<%@ page import="i2i.AdminServer.Constants"%>

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
				<g:set var="orderStatus" value="${orderDetailsCommand?.orderStatus}" />
	
		<div align="center">
		<g:form>
			<g:hiddenField name="orderId" value="${orderDetailsCommand.orderId }" />

			<%--			<fieldset class="radiogroup" >			--%>
			<table style="border: 1px solid #DFDFDF;">
				<tr>
					<td style="width: 25%">
					<g:if test="${orderStatus == 2}">
						<input type="radio" name="orderstatus" checked="checked" disabled value=${Constants.ORDER_ACCEPTED}>Accept Order </g:if>
					<g:elseif test="${orderstatus > 2}">
						<input type="radio" name="orderstatus" disabled
						value=${Constants.ORDER_ACCEPTED}>Accept Order </g:elseif>
					<g:else>
						<input type="radio" name="orderstatus"
						value=${Constants.ORDER_ACCEPTED}>Accept Order </g:else>
					</td>
					<td style="width: 25%">
						<g:if test="${orderStatus == 3}"><input type="radio" name="orderstatus" checked="checked" disabled
						value=${Constants.ORDER_INTRANSIT}>Order in transit </g:if>
						<g:elseif test="${orderStatus > 3}"><input type="radio" name="orderstatus" disabled
						value=${Constants.ORDER_INTRANSIT}>Order in transit </g:elseif>
						<g:else><input type="radio" name="orderstatus"
						value=${Constants.ORDER_INTRANSIT}>Order in transit </g:else>
					</td>
					<td style="width: 25%">
					<g:if test="${orderStatus == 4}"><input type="radio" name="orderstatus" checked="checked" disabled
						value=${Constants.ORDER_DELIVERED}>Order Delivered</g:if>
						<g:elseif test="${orderStatus > 4}"><input type="radio" name="orderstatus" disabled
						value=${Constants.ORDER_DELIVERED}>Order Delivered</g:elseif>
						<g:else><input type="radio" name="orderstatus"
						value=${Constants.ORDER_DELIVERED}>Order Delivered</g:else>
					</td>
					<td style="width: 25%">
					<g:if test="${orderStatus == 0}">
					<input type="radio" name="orderstatus" checked="checked" disabled
						value=${Constants.ORDER_REJECTED}>Reject Order</g:if>
					<g:else>
					<input type="radio" name="orderstatus"
						value=${Constants.ORDER_REJECTED}>Reject Order</g:else>
					</td>
					</tr>
			</table>
			<%--			</fieldset>--%>
<%--			<br />--%>
			<g:actionSubmit class="btn btn-default" action="saveOrderStatus"
				value="${message(code: 'order.status.save.button', default: 'Save')}" />
			<%--			<g:actionSubmit class="btn btn-default" action="acceptOrder"--%>
			<%--				value="${message(code: 'order.status.accept.button', default: 'Accept Order')}" />--%>
			<%--			<g:actionSubmit class="btn btn-default" action="rejectOrder"--%>
			<%--				value="${message(code: 'order.status.reject.button', default: 'Reject Order')}"--%>
			<%--				onclick="return confirm('${message(code: 'order.status.reject.message')}');" />--%>
		</g:form>
	</div>
	
	<table align="center" style="border-top: 0">
		<tr>
			<td style="width: 30%"><span class="label-control"><g:message
						code="orders.personId.label" default="Person Name" /></span></td>
			<g:if test="${orderDetailsCommand?.name}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="name" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Age: " /></span></td>
			<g:if test="${orderDetailsCommand?.age}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="age" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Phone Number: " /></span></td>
			<g:if test="${orderDetailsCommand?.phoneNumber}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="phoneNumber" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Email id: " /></span></td>
			<g:if test="${orderDetailsCommand?.emailID}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="emailID" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Address: " /></span></td>
			<g:if test="${orderDetailsCommand?.addressLine1}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="addressLine1" />, <g:fieldValue
							bean="${orderDetailsCommand}" field="addressLine2" />, <g:fieldValue
							bean="${orderDetailsCommand}" field="circle" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span id="brandId-label" class="label-control"><g:message
						code="orders.brandId.label" default="Brand Name" /></span></td>
			<g:if test="${orderDetailsCommand?.brandName}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="brandName" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Quantity: " /></span></td>
			<g:if test="${orderDetailsCommand?.quantity}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="quantity" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Estimated delivery: " /></span></td>
			<g:if test="${orderDetailsCommand?.estimatedDeliveryTime}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderDetailsCommand}" field="estimatedDeliveryTime" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label"
						default="Emergency delivery Needed: " /></span></td>
			<td><span class="label-control"><g:fieldValue
						bean="${orderDetailsCommand}" field="isEmergencyDeliveryNeeded" /></span></td>
		</tr>
		<%--		<tr>--%>
		<%--			<td><span id="storeId-label" class="label-control"><g:message--%>
		<%--						code="orders.storeId.label" default="Store Name" /></span></td>--%>
		<%--			<g:if test="${orderDetailsCommand?.storeName}">--%>
		<%--				<td><span class="label-control"><g:fieldValue--%>
		<%--							bean="${orderDetailsCommand}" field="storeName" /></span></td>--%>
		<%--			</g:if>--%>
		<%--		</tr>--%>
		<tr>
			<td><span id="orderStatus-label" class="label-control"><g:message
						code="orders.orderStatus.label" default="Order Status" /></span></td>
			<td><g:if test="${orderStatus == 4 }">
				Order delivered
				</g:if> <g:elseif test="${orderStatus == 3 }">
				Order in transit
				</g:elseif> <g:elseif test="${orderStatus == 2 }">
				Order Accepted</g:elseif> <g:elseif test="${orderStatus == 1 }">
				Order Placed</g:elseif> <g:elseif test="${orderStatus < 1 }">Order rejected</g:elseif></td>
			<%--			<g:if test="${orderDetailsCommand?.orderStatus}">--%>
			<%--				<td><span class="label-control"--%>
			<%--					aria-labelledby="orderStatus-label"><g:fieldValue--%>
			<%--							bean="${orderDetailsCommand}" field="orderStatus" /></span></td>--%>
			<%--			</g:if>--%>
		</tr>
	</table>

	<br />
</body>
</html>
