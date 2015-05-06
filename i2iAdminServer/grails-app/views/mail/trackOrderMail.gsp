<%@ page contentType="text/html"%>
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>
<%@ page import="i2i.AdminServer.Constants" %>

<div>
<p>
<g:if test="${orderDetails.orderStatus == Constants.ORDER_ACCEPTED}">
Your order has been accepted successfully. Please find your order details below,
</g:if>
<g:elseif test="${orderDetails.orderStatus == Constants.ORDER_DELIVERED}">
Your order has been delivered successfully. Please find your order details below,
</g:elseif>
<g:elseif test="${orderDetails.orderStatus == Constants.ORDER_REJECTED}">
Your order has been cancelled successfully. Please find your order details below,
<%--Thanks for ordering at pillocate! Your order has been rejected as stock is not available. Please find your order details below,--%>
</g:elseif>
<g:else>
Thanks for ordering at pillocate! Please find your order details below,
</g:else>
</p>

<p>
Order Name: ${orderDetails.brandName }<br>
Tracking Id: ${orderDetails.trackingId }<br>
Quantity: ${orderDetails.quantity }
<g:if test="${orderDetails.orderStatus > Constants.ORDER_ACCEPTED}">
Expected delivery time: <g:formatDate date="${orderDetails.estimatedDeliveryTime}" format="${Constants.dateFormat }" /> 
</g:if>
</p>

<p>
Name: ${orderDetails.name }
<br/>
Address: 
<br>
${orderDetails.addressLine1 }<br>
${orderDetails.addressLine2 }<br>
${orderDetails.circle }<br>
${orderDetails.city }<br>
<br>
<p>

<g:if test="${storeInstance }">
<h2>
Seller Details
</h2>
Your order has been placed at ${storeInstance.storeName }. Please find contact details below,
<br>
Phone number: ${storeInstance.phoneNumber }
<br>
Address:<br>
${storeInstance.addressLine1 }<br>
${storeInstance.addressLine2 }<br>
${storeInstance.circle }<br>
${storeInstance.city }<br>
</g:if>
</p>
<g:if test="${orderDetails.orderStatus != Constants.ORDER_REJECTED && orderDetails.orderStatus != Constants.ORDER_DELIVERED}">
Track your order status <a href="${Constants.envLink+'orderStatus?trackingId='+orderDetails.trackingId }">here</a><br>
</g:if>

<%--<g:if test="${orderDetails.phoneNumber }">--%>
<%--You could call ${orderDetails.name } on ${orderDetails.phoneNumber }--%>
<%--</g:if>--%>
<%--<br>--%>
<%--<g:if test="${orderDetails.emailID }">--%>
<%--Email: ${orderDetails.emailID }--%>
<%--</g:if>--%>
<%--<br>--%>
<%--Delivery Expected by: <g:formatDate date="${orderDetails.estimatedDeliveryTime }" format="${Constants.dateFormat }" /><br>--%>
<%--<br>--%>
<%--PLEASE NOTE: The customer expects you to accept the order soon. To accept the order, click <a href="${Constants.envLink+'ordersList' }">here</a><br>--%>
<%--</p>--%>
<p>
<i>Regards,</i><br>
Team Pillocate
</p>
</div>