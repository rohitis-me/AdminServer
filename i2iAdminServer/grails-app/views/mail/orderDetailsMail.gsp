<%@ page contentType="text/html"%>
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>
<%@ page import="i2i.AdminServer.Constants" %>
<%@ page import="i2i.AdminServer.OrderCollectionCommand" %>

<div>
<h2> Order Details:</h2> 
<g:each in="${orderDetailsList}" status="i" var="orderInstance">
<g:if test="${orderInstance.orderStatus == Constants.ORDER_CANCELLED}">
Following order has been cancelled by Customer. Please stop the dispatch process.
</g:if>
<p> ${i+1}.
Order Name: ${orderInstance.brandName }<br>
Quantity: ${orderInstance.quantity }<br/>
<g:if test="${orderInstance.isEmergencyDeliveryNeeded}">
<i>Emergency Delivery Requested</i><br/>
</g:if>
Delivery Expected by: <g:formatDate date="${orderInstance.estimatedDeliveryTime }" format="${Constants.dateFormat }" />
</p>
</g:each>
<h2>Delivery Address: </h2>
<p>
Name: ${orderDetails.name }
<br/>
Address: 
<br>
${orderDetails.addressLine1 }<br/>
${orderDetails.addressLine2 }<br/>
${orderDetails.circle }<br/>
${orderDetails.city }<br/>
<br/>
<%--<g:if test="${orderDetails.orderStatus != Constants.ORDER_REJECTED}">--%>
<g:if test="${orderDetails.phoneNumber }">
You could call ${orderDetails.name } on ${orderDetails.phoneNumber }
</g:if>
<br>
<g:if test="${orderDetails.emailID }">
Email: ${orderDetails.emailID }
</g:if>
<br>
PLEASE NOTE: The customer expects you to accept the order soon. To accept the order, click <a href="${Constants.envLink+'ordersList' }">here</a><br>
<%--</g:if>--%>
</p>
<p>
<i>Regards,</i><br>
Team i2i Technology
</p>
</div>