<%@ page contentType="text/html"%>
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>

<div>
<h2> Order Details:</h2> 

<p>
Order Name: ${orderDetails.brandName }<br>
Quantity: ${orderDetails.quantity }
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
<g:if test="${orderDetails.phoneNumber }">
You could call ${orderDetails.name } on ${orderDetails.phoneNumber }
</g:if>
<g:if test="${orderDetails.emailID }">
Email: ${orderDetails.emailID }
</g:if>

<g:formatDate date="${orderDetails.estimatedDeliveryTime }" format="h:mm a, dd/MM/yyyy" /><br>
<g:if test="${orderDetails.isEmergencyDeliveryNeeded }">
<i>Emergency</i>
</g:if>
</p>
</div>