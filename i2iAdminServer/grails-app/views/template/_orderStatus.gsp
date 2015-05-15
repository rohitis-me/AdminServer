<%@ page import="i2i.AdminServer.Constants"%>

<g:set var="orderStatus" value="${orderStatusCommand?.orderStatus}" />
<div class="container">
	<div class="row">
		<div class="col-md-10 col-md-offset-1">
			<div class="form-horizontal">
				<div class="panel panel-default order-panel">
					<div class="panel-heading">Order Status</div>
					<div class="panel-body">

						<table align="center" style="width: 100%">
							<tr>
								<td style="width: 25%"><g:if
										test="${orderStatus == Constants.ORDER_PLACED}">
										<input type="radio" name="orderstatus" checked="checked"
											disabled>
										<label style="font-weight: bold;">Placed</label>
									</g:if> <g:else>
										<input type="radio" name="orderstatus" disabled>
										<label style="font-weight: normal;">Placed</label>
									</g:else></td>
								<td style="width: 25%"><g:if
										test="${orderStatus == Constants.ORDER_ACCEPTED}">
										<input type="radio" name="orderstatus" checked="checked"
											disabled>
										<label style="font-weight: bold;">Accepted</label>
									</g:if> <g:else>
										<input type="radio" name="orderstatus" disabled>
										<label style="font-weight: normal;">Accepted</label>
									</g:else></td>
							</tr>
							<tr>
								<td style="width: 25%"><g:if
										test="${orderStatus == Constants.ORDER_DISPATCHED}">
										<input type="radio" name="orderstatus" checked="checked"
											disabled>
										<label style="font-weight: bold;">Dispatched</label>
									</g:if> <g:else>
										<input type="radio" name="orderstatus" disabled>
										<label style="font-weight: normal;">Dispatched</label>
									</g:else></td>
								<td style="width: 25%"><g:if
										test="${orderStatus == Constants.ORDER_DELIVERED}">
										<input type="radio" name="orderstatus" checked="checked"
											disabled>
										<label style="font-weight: bold;">Delivered</label>
									</g:if> <g:else>
										<input type="radio" name="orderstatus" disabled>
										<label style="font-weight: normal;">Delivered</label>
									</g:else></td>
							</tr>
						</table>

					</div>
					<div class="bg-default bg-primary">Order Details</div>
					<table class="table table-hover table-striped">
						<tbody>
							<tr>
								<td><span class="label-control">Order Name: </span></td>
								<td><g:fieldValue class="label-control"
										bean="${orderStatusCommand}" field="brandName" /></td>
							</tr>
							<tr>
								<td><span class="label-control">Tracking Id: </span></td>
								<td><g:fieldValue class="label-control"
										bean="${orderStatusCommand}" field="trackingId" /></td>
							</tr>
							<tr>
								<td><span class="label-control">Expected Delivery: </span></td>
								<td><g:formatDate
										date="${orderStatusCommand.estimatedDeliveryTime }"
										format="${Constants.dateFormat }" /> 
								<g:if test="${orderStatus == Constants.ORDER_PLACED}">
								<g:message code="orderStatus.estimateddeliverytime.accept.pending" default="(approximate)"/>
								</g:if>
								</td>
							</tr>
							<tr>
								<td><span class="label-control">Seller: </span></td>
								<td><g:fieldValue class="label-control"
										bean="${orderStatusCommand}" field="storeName" /> <%--							<span--%>
									<%--						class="label-control">,</span> <g:fieldValue class="label-control"--%>
									<%--							bean="${orderStatusCommand}" field="storeAddressLine1" /><span--%>
									<%--						class="label-control">,</span> <g:fieldValue class="label-control"--%>
									<%--							bean="${orderStatusCommand}" field="storeAddressLine2" />, <g:fieldValue class="label-control"--%>
									<%--							bean="${orderStatusCommand}" field="storeCircle" />, <g:fieldValue class="label-control"--%>
									<%--							bean="${orderStatusCommand}" field="storeCity" />--%>
								</td>
							</tr>
							<tr>
								<td><span class="label-control">Seller Contact No: </span></td>
								<td><g:fieldValue class="label-control"
										bean="${orderStatusCommand}" field="storePhoneNumber" /><span
									class="label-control"></span></td>
							</tr>
						</tbody>
					</table>
					<g:form>
						<g:hiddenField name="orderId"
							value="${orderStatusCommand.orderId }" />
						<div class="panel-footer clearfix">
							<div class="row">
								<div class="col-sm-offset-3 col-xs-6 col-sm-3">
									<button type="submit" class="btn btn-success btn-block"
										name="_action_placeNextOrder">
										<i class="glyphicon glyphicon-menu-right"></i>
										${message(code: 'order.place.next.button', default: 'Next Order')}
									</button>
								</div>
								<g:if test="${orderStatus != Constants.ORDER_DISPATCHED && orderStatus != Constants.ORDER_DELIVERED}">
								<div class="col-xs-6 col-sm-3">
									<button type="submit" class="btn btn-danger btn-block"
										name="_action_cancelOrder"
										onclick="return confirm('${message(code: 'order.status.reject.message')}');">
										<i class="glyphicon glyphicon-remove"></i>
										${message(code: 'order.cancel.order.button', default: 'Cancel Order')}
									</button>
								</div>
								</g:if>
							</div>
						</div>
					</g:form>
				</div>
			</div>
		</div>
	</div>
</div>

