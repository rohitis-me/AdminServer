<%@ page contentType="text/html"%>
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>
<%@ page import="i2i.AdminServer.Constants" %>

<div>
<g:if test="${orderDetails.orderStatus == Constants.ORDER_REJECTED}">
Following order has been cancelled by Customer. Please stop the dispatch process.
</g:if>
<br/>
<h2> Order Details:</h2> 
<p>
Order Name: ${orderDetails.brandName }<br>
Quantity: ${orderDetails.quantity }
</p>
<g:if test="${orderDetails.isEmergencyDeliveryNeeded }">
<i>Emergency Delivery Requested</i>
</g:if>
<p>
Name: ${orderCollCommand.name }
<br/>
Address: 
<br>
${orderCollCommand.addressLine1 }<br/>
${orderCollCommand.addressLine2 }<br/>
${orderCollCommand.circle }<br/>
${orderCollCommand.city }<br/>
<br/>
<g:if test="${orderDetails.orderStatus != Constants.ORDER_REJECTED}">
<g:if test="${orderCollCommand.phoneNumber }">
You could call ${orderDetails.name } on ${orderDetails.phoneNumber }
</g:if>
<br>
<g:if test="${orderCollCommand.emailID }">
Email: ${orderCollCommand.emailID }
</g:if>
<br>
Delivery Expected by: <g:formatDate date="${orderDetails.estimatedDeliveryTime }" format="${Constants.dateFormat }" /><br>
<br>
PLEASE NOTE: The customer expects you to accept the order soon. To accept the order, click <a href="${Constants.envLink+'ordersList' }">here</a><br>
</g:if>
</p>
<p>
<i>Regards,</i><br>
Team i2i Technology
</p>
</div>