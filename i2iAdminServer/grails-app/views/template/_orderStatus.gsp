	<%@ page import="i2i.AdminServer.Constants"%>
	
	<h2 style="text-align: center;">Order Status</h2>
	<%--	<br />--%>
	<g:set var="orderStatus" value="${orderStatusCommand?.orderStatus}" />

	<table align="center" class="mobileTable"
		style="border: 1px solid #DFDFDF;">
		<tr>
			<td style="width: 25%"><g:if
					test="${orderStatus == Constants.ORDER_PLACED}">
					<input type="radio" name="orderstatus" checked="checked" disabled>
					<label class="label-control" style="font-weight: bold;">Placed</label>
				</g:if> <g:else>
					<input type="radio" name="orderstatus" disabled>
					<label class="label-control" style="font-style: italic;">Placed</label>
				</g:else></td>
			<td style="width: 25%"><g:if
					test="${orderStatus == Constants.ORDER_ACCEPTED}">
					<input type="radio" name="orderstatus" checked="checked" disabled>
					<label style="font-weight: bold;">Accepted</label>
				</g:if> <g:else>
					<input type="radio" name="orderstatus" disabled>
					<label style="font-style: italic;">Accepted</label>
				</g:else></td>
		</tr>
		<tr>
			<td style="width: 25%"><g:if
					test="${orderStatus == Constants.ORDER_DISPATCHED}">
					<input type="radio" name="orderstatus" checked="checked" disabled>
					<label style="font-weight: bold;">Dispatched</label>
				</g:if> <g:else>
					<input type="radio" name="orderstatus" disabled>
					<label style="font-style: italic;">Dispatched</label>
				</g:else></td>
			<td style="width: 25%"><g:if
					test="${orderStatus == Constants.ORDER_DELIVERED}">
					<input type="radio" name="orderstatus" checked="checked" disabled>
					<label style="font-weight: bold;">Delivered</label>
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
					<td><g:fieldValue class="label-control"	bean="${orderStatusCommand}" field="storeName" /> 
<%--							<span--%>
<%--						class="label-control">,</span> <g:fieldValue class="label-control"--%>
<%--							bean="${orderStatusCommand}" field="storeAddressLine1" /><span--%>
<%--						class="label-control">,</span> <g:fieldValue class="label-control"--%>
<%--							bean="${orderStatusCommand}" field="storeAddressLine2" />, <g:fieldValue class="label-control"--%>
<%--							bean="${orderStatusCommand}" field="storeCircle" />, <g:fieldValue class="label-control"--%>
<%--							bean="${orderStatusCommand}" field="storeCity" />--%>
							</td>
				</tr>
				<tr>
				<td><span class="label-control">Seller Contact No: </span>
				</td>
				<td>
				<g:fieldValue class="label-control"
							bean="${orderStatusCommand}" field="storePhoneNumber" /><span
						class="label-control"></span>
				</td>
				</tr>
		</tbody>
	</table>

	<%--        </div>--%>
	<%--    </div>--%>
	<%--</div>--%>



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
