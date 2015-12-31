
<%--<%@ page import="i2i.AdminServer.Store"%>--%>
<%--<%@ page import="i2i.AdminServer.Constants"%>--%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'order.items.list', default: 'Orders')}" />
<title><g:message code="title.brand.tag" /> | <g:message message="Orders" /></title>
<g:javascript library="jquery"/>
</head>
<body>
	<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
<%--			<g:render template="/template/searchBox"></g:render>--%>
<%--			<br />--%>
			<div class="col-md-10 col-md-offset-1">
				<br />
				<g:if test="${orderDetailsList}">
					<div align="center">
						<label> <g:message code="cart.items.list"
								default="Your Orders" />
						</label>
					</div>
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<table class="table table-hover table-striped">
								<thead class="bg-default bg-primary">
									<tr>
										<th>Order Id</th>
										<th>Delivery Address</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
								<g:each in="${orderDetailsList}" status="i" var="order">
								<g:set var="orderCollectionId" value="${order?.orderCollectionId}"></g:set>
								<g:set var="rowOrderStatus" value="${order?.orderStatus}" />
									<tr style="cursor: pointer;"
										class="${(i % 2) == 0 ? 'even' : 'odd'}"
										onclick='document.location = "<g:createLink controller="secUser"
										action="showOrderDetails"
										params="[orderCollectionId: orderCollectionId]"/>" '>
									<td>
										${fieldValue(bean: order,  field: "orderRefId")}
									</td>
											
									<td>
										${fieldValue(bean: order, field: "name")}
										<g:if test="${order?.addressLine1}"><g:fieldValue bean="${order}" field="addressLine1" />, </g:if>
										<g:if test="${order?.addressLine2}"> <g:fieldValue bean="${order}" field="addressLine2" />, </g:if>
										<g:if test="${order?.circle}"><g:fieldValue bean="${order}" field="circle" />, </g:if>
										<g:if test="${order?.city}"><g:fieldValue bean="${order}" field="city" /> </g:if>
									</td>
									<td>
										<g:if test="${rowOrderStatus == 4 }">Order Delivered</g:if> <g:elseif
										test="${rowOrderStatus == 3 }">Order Dispatched</g:elseif> <g:elseif
										test="${rowOrderStatus == 2 }">Order Accepted</g:elseif> <g:elseif
										test="${rowOrderStatus == 1 }">Order Placed</g:elseif> <g:elseif
										test="${rowOrderStatus == 0 }">Order Cancelled</g:elseif>
										<g:elseif
										test="${rowOrderStatus < 0 }">Order Rejected</g:elseif>
									</td>
									</tr>
									</g:each>
								</tbody>
							</table>
							<br/>
						</div>
					</div>
				</g:if>
				<g:else>
					<div align="center">
						<label style="color: red;"> <g:message
								code="order.items.unavailable" default="No Orders." /></label>
					</div>
					<br/>
<%--					<g:form controller="search" action="index"> --%>
<%--								<div class="col-sm-offset-3 col-xs-6 col-sm-3" align="center">--%>
<%--									<button type="submit" class="btn btn-primary btn-block" >--%>
<%--										<i class="glyphicon glyphicon-menu-left"></i> Add Items--%>
<%--									</button>--%>
<%--								</div>--%>
<%--					</g:form>			--%>
				</g:else>

			</div>
		</div>
	</div>
	<br />
<%--	<p id="demo"></p>--%>
	
<%--<g:javascript>--%>
<%--function qtyChangeFunction() {--%>
<%--    var x = document.getElementById("qtySelectBox").value;--%>
<%--    document.getElementById("demo").innerHTML = "You selected: " + x;--%>
<%--    $("#qtyForm").submit()--%>
<%--}--%>
<%--</g:javascript>--%>

</body>
</html>
