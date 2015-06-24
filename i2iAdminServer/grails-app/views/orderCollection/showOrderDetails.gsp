
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
	<g:if test="${orderDetailsCommandList}">
	<g:set var="orderStatus" value="${orderDetailsCommandList[0]?.orderStatus}" />
	</g:if>
	<div align="center">
		<p>
			<i> <g:message code="order.status.selectmessage"
					default="Select current order status and click 'Save'." />
			</i>
		</p>
		<g:form>
			<g:hiddenField name="orderCollectionId" value="${orderCollCommand.orderCollectionId}" />
			<g:hiddenField name="storeId" value="${storeId}" />
			<%--			<fieldset class="radiogroup" >			--%>
			<table style="border: 1px solid #DFDFDF;">
				<tr>
					<td style="width: 25%">
					<g:if test="${orderStatus == Constants.ORDER_ACCEPTED}">
							<input type="radio" name="orderstatus" checked="checked" 
								value=${Constants.ORDER_ACCEPTED}>Accept Order </g:if> 
							<g:elseif test="${orderStatus > Constants.ORDER_ACCEPTED || orderStatus == Constants.ORDER_REJECTED}">
							<input type="radio" name="orderstatus" disabled
								value=${Constants.ORDER_ACCEPTED}>Accept Order </g:elseif> 
							<g:else>
							<input type="radio" name="orderstatus"
								value=${Constants.ORDER_ACCEPTED}>Accept Order </g:else></td>
					
					<td style="width: 25%">
					<g:if test="${orderStatus == Constants.ORDER_DISPATCHED}">
							<input type="radio" name="orderstatus" checked="checked" 
								value=${Constants.ORDER_DISPATCHED}>Order Dispatched </g:if> 
														<g:elseif test="${orderStatus > Constants.ORDER_DISPATCHED || orderStatus == Constants.ORDER_REJECTED}"><input type="radio" name="orderstatus" disabled
												value=${Constants.ORDER_DISPATCHED}>Order Dispatched </g:elseif>
						<g:else>
							<input type="radio" name="orderstatus"
								value=${Constants.ORDER_DISPATCHED}>Order Dispatched </g:else></td>
					
					<td style="width: 25%">
					<g:if test="${orderStatus == Constants.ORDER_DELIVERED}">
							<input type="radio" name="orderstatus" checked="checked" 
								value=${Constants.ORDER_DELIVERED}>Order Delivered</g:if> 
														<g:elseif test="${orderStatus > Constants.ORDER_DELIVERED || orderStatus == Constants.ORDER_REJECTED}"><input type="radio" name="orderstatus" disabled
												value=${Constants.ORDER_DELIVERED}>Order Delivered</g:elseif>
						<g:else>
							<input type="radio" name="orderstatus"
								value=${Constants.ORDER_DELIVERED}>Order Delivered</g:else></td>
								
					<g:if test="${orderStatus <= Constants.ORDER_PLACED}">
					<td style="width: 25%"><g:if test="${orderStatus == Constants.ORDER_REJECTED}">
							<input type="radio" name="orderstatus" checked="checked" 
								value=${Constants.ORDER_REJECTED}>Reject Order</g:if> <g:else>
							<input type="radio" name="orderstatus"
								value=${Constants.ORDER_REJECTED}>Reject Order</g:else></td></g:if>
				</tr>
			</table>
			<%--			</fieldset>--%>
			<%--			<br />--%>
			<table style="border: 0;">
				<tr>
					<td><span class="label-control"><g:message
								code="orders.phone.number.label" default="Estimated delivery:" /></span></td>
					<td><g:datePicker precision="minute" 
							name="estimatedDeliveryTime" years="${2015..2016}"
							class="dropdown-control"
							value="${orderDetailsCommandList[0]?.estimatedDeliveryTime}" /></td>
				</tr>
				<tr>
					<td><span class="label-control"><g:message
								code="orders.phone.number.label" default="Reason for Late Delivery:" /></span></td>
					<td><g:textArea class="textbox-control" name="deliveryComment"
							maxlength="100"
							value="${orderCollCommand?.deliveryComment}" /></td>
				</tr>
			</table>

			<g:actionSubmit class="btn btn-default" action="saveOrderStatus"
				value="${message(code: 'order.status.save.button', default: 'Save')}" />
		</g:form>
	</div>

<br/>
<div align="center"><h3>Order Items</h3></div>
<g:if test="${orderDetailsCommandList}">
	<table align="center">
		<thead>
			<tr>
				<th>S.No.</th>
				<th>Brand Name</th>

				<th>Quantity</th>

			</tr>
		</thead>
		<tbody>
			<g:each in="${orderDetailsCommandList}" status="i" var="ordersInstance">
<%--				<g:set var="orderCollectionId" value="${ordersInstance?.orderCollectionId}"></g:set>--%>
<%--				<g:set var="rowOrderStatus"--%>
<%--							value="${1}" />--%>
<%--				<g:if test="${rowOrderStatus > 0 || orderStatus== 0 }">--%>
				<tr style="cursor: pointer;"
					class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td>
						${i+1}
					</td>
					<td>
						${fieldValue(bean: ordersInstance,  field: "brandName")}
					</td>

					<td>
						${fieldValue(bean: ordersInstance, field: "quantity")}
					</td>
				</tr>
			</g:each>
		</tbody>
	</table>
	</g:if>
	
<%--	<br/>--%>
	<div align="center"><h3>Delivery Address</h3></div>
	<table align="center" style="border-top: 0">
		<tr>
			<td style="width: 40%"><span class="label-control"><g:message
						code="orders.personId.label" default="Person Name:" /></span></td>
			<g:if test="${orderCollCommand?.name}">
				<td style="width: 60%"><span class="label-control"><g:fieldValue
							bean="${orderCollCommand}" field="name" /></span></td>
			</g:if>
		</tr>
<%--		<tr>--%>
<%--			<td><span class="label-control"><g:message--%>
<%--						code="orders.phone.number.label" default="Age:" /></span></td>--%>
<%--			<g:if test="${orderCollCommand?.age}">--%>
<%--				<td><span class="label-control"><g:fieldValue--%>
<%--							bean="${orderCollCommand}" field="age" /></span></td>--%>
<%--			</g:if>--%>
<%--		</tr>--%>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Phone Number:" /></span></td>
			<g:if test="${orderCollCommand?.phoneNumber}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderCollCommand}" field="phoneNumber" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Email id:" /></span></td>
			<g:if test="${orderCollCommand?.emailID}">
				<td><span class="label-control"><g:fieldValue
							bean="${orderCollCommand}" field="emailID" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Address:" /></span></td>
			
			<td><span class="label-control">
				<g:if test="${orderCollCommand?.addressLine1}"><g:fieldValue bean="${orderCollCommand}" field="addressLine1" />, </g:if>
				<g:if test="${orderCollCommand?.addressLine2}"> <g:fieldValue bean="${orderCollCommand}" field="addressLine2" />, </g:if>
				<g:if test="${orderCollCommand?.circle}"><g:fieldValue bean="${orderCollCommand}" field="circle" />,</g:if>
				<g:if test="${orderCollCommand?.city}"><g:fieldValue bean="${orderCollCommand}" field="city" /> </g:if>
			</span></td>
		</tr>
<%--		<tr>--%>
<%--			<td><span id="brandId-label" class="label-control"><g:message--%>
<%--						code="orders.brandId.label" default="Brand Name:" /></span></td>--%>
<%--			<g:if test="${orderCollCommand?.brandName}">--%>
<%--				<td><span class="label-control"><g:fieldValue--%>
<%--							bean="${orderCollCommand}" field="brandName" /></span></td>--%>
<%--			</g:if>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td><span class="label-control"><g:message--%>
<%--						code="orders.phone.number.label" default="Quantity:" /></span></td>--%>
<%--			<g:if test="${orderDetailsCommand?.quantity}">--%>
<%--				<td><span class="label-control"><g:fieldValue--%>
<%--							bean="${orderDetailsCommand}" field="quantity" /></span></td>--%>
<%--			</g:if>--%>
<%--		</tr>--%>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.attachment.label" default="Prescription:" /></span></td>
			<g:if test="${attachmentLink!=""}">
				<td><span class="label-control"><a href="${attachmentLink}">Click here to see uploaded prescription</a></span></td>
			</g:if>
		</tr>
<%--		<tr>--%>
<%--			<td><span class="label-control"><g:message--%>
<%--						code="orders.phone.number.label" default="Estimated delivery:" /></span></td>--%>
<%--			<g:if test="${orderDetailsCommand?.estimatedDeliveryTime}">--%>
<%--				<td><g:formatDate--%>
<%--						date="${orderDetailsCommand.estimatedDeliveryTime }"--%>
<%--						format="${Constants.dateFormat }" /></td>--%>
<%--			</g:if>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td><span class="label-control"><g:message--%>
<%--						code="orders.phone.number.label"--%>
<%--						default="Emergency delivery Needed:" /></span></td>--%>
<%--			<td><span class="label-control"><g:fieldValue--%>
<%--						bean="${orderDetailsCommand}" field="isEmergencyDeliveryNeeded" /></span></td>--%>
<%--		</tr>--%>
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
						code="orders.orderStatus.label" default="Order Status:" /></span></td>
			<td><g:if test="${orderStatus == 4 }">
				Order delivered
				</g:if> <g:elseif test="${orderStatus == 3 }">
				Order in transit
				</g:elseif> <g:elseif test="${orderStatus == 2 }">
				Order Accepted</g:elseif> <g:elseif test="${orderStatus == 1 }">
				Order Placed</g:elseif> <g:elseif test="${orderStatus == 0 }">Order Cancelled</g:elseif>
				<g:elseif test="${orderStatus < 0 }">Order rejected</g:elseif></td>
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
