<%@ page contentType="text/html"%>
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>

<div>
<p>
Order Name: ${orderDetails.brandName }<br>
Quantity: ${orderDetails.quantity }
</p>
<p>
Order Details: 
<br>
${orderDetails.addressLine1 }<br>
${orderDetails.addressLine2 }<br>
${orderDetails.circle }<br>
${orderDetails.city }<br>
<br>
<g:formatDate date="${orderDetails.estimatedDeliveryTime }" format="h:mm a, dd/MM/yyyy" /><br>
<g:if test="${orderDetails.isEmergencyDeliveryNeeded }">
<i>Emergency</i>
</g:if>
</p>
</div>