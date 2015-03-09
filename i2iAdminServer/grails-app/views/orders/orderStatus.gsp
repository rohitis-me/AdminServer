
<%@ page import="i2i.AdminServer.Orders"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'order.status.label', default: 'Order Status')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<%--<meta http-equiv="refresh" content="60">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1">--%>
<%--    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">--%>
</head>
<body>
	<g:render template="/template/navigationClient" />

	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>

<%--	<h2 style="text-align: center;">Order Details</h2>--%>
<br/>

<div align="center">
  <div id="accordion">
        <div class="item">
            <h2>Order Details</h2>
            <table align="center" style="border-top: 0;width: 100%">
		<tbody>
			<tr>
				<td><span class="label-control">Order Name: </span></td>
				<td><g:fieldValue class="label-control" bean="${orderStatusCommand}"
			field="brandName" /></td>
			</tr>
			<tr>
				<td><span class="label-control">Expected Delivery: </span></td>
				<td><g:fieldValue class="label-control" bean="${orderStatusCommand}"
			field="estimatedDeliveryTime" /></td>
			</tr>
			<tr>
				<td><span class="label-control">Seller: </span></td>
				<td><g:fieldValue class="label-control" bean="${orderStatusCommand}" field="storeName" />
				<span class="label-control">,</span>
			<g:fieldValue class="label-control" bean="${orderStatusCommand}"
			field="storePhoneNumber" /><span class="label-control">,</span>
				<g:fieldValue class="label-control" bean="${orderStatusCommand}"
			field="storeAddressLine1" /><span class="label-control">,</span><g:fieldValue class="label-control" bean="${orderStatusCommand}"
			field="storeAddressLine2" /></td>
			</tr>
			</tbody>
		</table>
            
        </div>
  
    </div>
</div>

	
	<h2 style="text-align: center;">Order Status</h2>
<%--	<br />--%>
<g:set var="orderStatus" value="${orderStatusCommand?.orderStatus}" />

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

		<div align="center">
		<g:form>
			<g:hiddenField name="orderId" value="${orderStatusCommand.orderId }" />
			<g:actionSubmit class="btn btn-default" action="placeNextOrder"
				value="${message(code: 'order.place.next.button', default: 'Next Order')}"/>
<%--			<input class="btn btn-default" type="button" onClick="history.go(0)" value="Refresh">--%>
			<g:actionSubmit class="btn btn-default" action="cancelOrder"
				value="${message(code: 'order.cancel.order.button', default: 'Cancel Order')}"
				onclick="return confirm('${message(code: 'order.status.reject.message')}');" />
		</g:form>
	</div>

	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
	<br/>
</body>
</html>
