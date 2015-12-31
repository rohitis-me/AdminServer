
<%@ page import="i2i.AdminServer.OrderDetailsCommand"%>
<%@ page import="i2i.AdminServer.Constants"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'order.items.list', default: 'Order')}" />
<title><g:message code="title.brand.tag" /> | <g:message message="Order" /></title>
<g:javascript library="jquery"/>
</head>
<body>
<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<br />
<g:if test="${orderDetailsCommandList}">
<g:set var="orderStatus" value="${orderDetailsCommandList[0]?.orderStatus}" />
			<div align="center">
						<h3> <g:message code="cart.items.list"
								default="Order Items" />
						</h3>
			</div>
			<div class="form-horizontal">
			<div class="panel panel-default order-panel">
			<table class="table table-hover table-striped">
				<thead class="bg-default bg-primary">
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
				<tr	class="${(i % 2) == 0 ? 'even' : 'odd'}">
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
		</div>
		</div>
	</g:if>
	
<%--	<br/>--%>
	<div align="center"><h3>Delivery Address</h3></div>
	<table align="center" style="border-top: 0">
		<tr>
			<td style="width: 40%"><span class="label-control"><g:message
						code="orders.personId.label" default="Patient Name:" /></span></td>
			<g:if test="${orderCollCommand?.patientName}">
				<td style="width: 60%"><span class="label-control"><g:fieldValue
							bean="${orderCollCommand}" field="patientName" /></span></td>
			</g:if>
		</tr>
		<tr>
			<td style="width: 40%"><span class="label-control"><g:message
						code="orders.personId.label" default="Doctor Name:" /></span></td>
			<g:if test="${orderCollCommand?.doctorName}">
				<td style="width: 60%"><span class="label-control"><g:fieldValue
							bean="${orderCollCommand}" field="doctorName" /></span></td>
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
<%--			<td><span class="label-control"><g:message--%>
<%--						code="orders.attachment.label" default="Prescription:" /></span></td>--%>
<%--			<g:if test="${attachmentLink!=""}">--%>
<%--				<td><span class="label-control"><a href="${attachmentLink}">Click here to see uploaded prescription</a></span></td>--%>
<%--			</g:if>--%>
<%--		</tr>--%>
		<tr>
			<td><span class="label-control"><g:message
						code="orders.phone.number.label" default="Estimated delivery:" /></span></td>
			<g:if test="${orderDetailsCommandList[0]?.estimatedDeliveryTime}">
				<td><g:formatDate
						date="${orderDetailsCommandList[0]?.estimatedDeliveryTime }"
						format="${Constants.dateFormat }" /></td>
			</g:if>
		</tr>
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
			</div>
		</div>
	</div>
	<br />
</body>
</html>
