<%@ page contentType="text/html"%>
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>
<%@ page import="i2i.AdminServer.Constants" %>
<%@ page import="i2i.AdminServer.OrderCollectionCommand" %>

<div>
<g:each in="${orderDetailsList}" status="i" var="orderInstance">
<p>
<g:if test="${orderInstance.orderStatus == Constants.ORDER_ACCEPTED && i==0}">
Your order has been accepted successfully. Please find your order details below,
</g:if>
<g:elseif test="${orderInstance.orderStatus == Constants.ORDER_DELIVERED && i==0}">
Your order has been delivered successfully. Please find your order details below,
</g:elseif>
<g:elseif test="${orderInstance.orderStatus == Constants.ORDER_CANCELLED && i==0}">
Your order has been cancelled successfully. Please find your order details below,
</g:elseif>
<g:elseif test="${orderInstance.orderStatus == Constants.ORDER_REJECTED && i==0}">
Thanks for ordering at pillocate! Your order has been rejected as stock is not available. 
We will Notify As soon as stock is available. Please find your order details below,
</g:elseif>
<g:elseif test="${i==0}">
Thanks for ordering at pillocate! Please find your order details below,
</g:elseif>
</p>
<p> ${i+1}.
Order Name: ${orderInstance.brandName }<br>
<%--Tracking Id: ${orderInstance.trackingId }<br>--%>
Quantity: ${orderInstance.quantity }
<g:if test="${orderInstance.orderStatus > Constants.ORDER_ACCEPTED}">
Expected delivery time: <g:formatDate date="${orderInstance.estimatedDeliveryTime}" format="${Constants.dateFormat }" /> 
</g:if>
</p>
</g:each>
Order Tracking Id: ${orderDetails.orderRefId}
<br/>
<g:if test="${orderDetailsList[0].orderStatus == Constants.ORDER_PLACED}">
<p>
You will receive a confirmation call from Pillocate within 15 min to confirm the price and discount you will receive.
</p>
</g:if>
<br/>
<h2>Delivery Address:</h2>
<p>
${orderDetails.name }<br>
${orderDetails.addressLine1 }<br>
<g:if test="${orderDetails.addressLine2}">${orderDetails.addressLine2 }<br></g:if>
${orderDetails.circle }<br>
${orderDetails.city }<br>
<br>


<g:if test="${orderDetailsList[0].orderStatus != Constants.ORDER_CANCELLED}"><p>
<%--<g:if test="${storeInstance && storeInstance?.phoneNumber}">--%>
<%--<h2>Seller Details</h2>--%>
<%--Please contact seller at ${storeInstance.phoneNumber }--%>
<%--</g:if>--%>

<%--<br>--%>
Track your order status <a href="${Constants.envLink+'ordersStatus?trackingId='+orderDetails.orderRefId }">here</a><br>
</g:if>
</p>
<p>
<i>Regards,</i><br>
Team Pillocate
</p>
</div>