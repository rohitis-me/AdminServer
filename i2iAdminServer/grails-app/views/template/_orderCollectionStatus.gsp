<%@ page import="i2i.AdminServer.Constants"%>

	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<g:if test="${orderDetailsList}">
					<div align="center">
						<label> <g:message code="order.items.list"
								default="Find your Order items here." />
						</label>
					</div>
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
						<div class="panel-heading">Order Details</div>
					<div class="panel-body">
						<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Tracking Id :</label>
									<div class="col-sm-8">
										<label class="order-info">${trackingId}</label>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Delivery
										Address :</label>
									<div class="col-sm-8">
										<label class="order-info">${patient.name }<br/>
${patient.addressLine1 },
<g:if test="${patient.addressLine2}">${patient.addressLine2}, </g:if>
${patient.circle },
${patient.city }</label>
									</div>
								</div>
					</div>
							<table class="table table-hover table-striped">
								<thead class="bg-default bg-primary">
									<tr>
										<th>Order</th>
										<th>Status</th>
										<th>Expected Delivery</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<g:each in="${orderDetailsList}" status="i" var="orderInstance">
<%--										<g:set var="quantity" value="${itemInstance['qty']}" />--%>
<%--										<g:set var="inventoryId" value="${itemInstance['iId']}" />--%>
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										<g:set var="orderStatus" value="${orderInstance.orderStatus}" />
											<td>
												Name: ${orderInstance.brandName}<br/>
												Qty: ${orderInstance.quantity}
											</td>
											<td>
											<g:if test="${orderStatus == Constants.ORDER_PLACED}">
											Placed (Yet to be accepted)
											</g:if>
											<g:if test="${orderStatus == Constants.ORDER_ACCEPTED}">
											Accepted (Yet to be Dispatched)
											</g:if>
											<g:if test="${orderStatus == Constants.ORDER_DISPATCHED}">
											Dispatched (Yet to be Delivered)
											</g:if>
											<g:if test="${orderStatus == Constants.ORDER_DELIVERED}">
											Delivered
											</g:if>
											<g:if test="${orderStatus == Constants.ORDER_REJECTED}">
											Order Cancelled
											</g:if>
											
											</td>
											<td>
											<g:if test="${orderStatus != Constants.ORDER_REJECTED && orderStatus != Constants.ORDER_DELIVERED}">
											<g:formatDate
										date="${orderInstance.estimatedDeliveryTime }"
										format="${Constants.dateFormat }" /> 
										</g:if>
												</td>
											<td>
											<g:if test="${orderStatus == Constants.ORDER_PLACED || orderStatus == Constants.ORDER_ACCEPTED}">
											<g:form action="cancelOrder" params='[orderId: orderInstance.orderId, trackingId:trackingId, offerCode:offerCode]'>
												<button type="submit" class="btn btn-danger btn-block" onclick="return confirm('${message(code: 'order.status.reject.message')}');">
												<i class="glyphicon glyphicon-remove"></i> Cancel Order </button>
												</g:form>
												</g:if>
											</td>
										</tr>
									</g:each>
								</tbody>
							</table>
							<br />
							<g:form>
							<div class="panel-footer clearfix">
							<div class="row">
								<div class="col-sm-offset-3 col-xs-6 col-sm-3">
									<button type="submit" class="btn btn-primary btn-block"
										name="_action_placeNextOrder">
										<i class="glyphicon glyphicon-menu-right"></i>
										${message(code: 'order.place.next.button', default: 'Next Order')}
									</button>
								</div>
								</div>
							</div>
							</g:form>
						</div>
					</div>
				</g:if>
<%--				<g:else>--%>
<%--					<div align="center">--%>
<%--						<label style="color: red;"> <g:message--%>
<%--								code="cart.items.unavailable" default="There are no items in this cart." /></label>--%>
<%--					</div>--%>
<%--					<br/>--%>
<%--					<g:form controller="search" action="index"> --%>
<%--								<div class="col-sm-offset-3 col-xs-6 col-sm-3" align="center">--%>
<%--									<button type="submit" class="btn btn-primary btn-block" >--%>
<%--										<i class="glyphicon glyphicon-menu-left"></i> Add Items--%>
<%--									</button>--%>
<%--								</div>--%>
<%--					</g:form>			--%>
<%--				</g:else>--%>

			</div>
		</div>
	</div>
