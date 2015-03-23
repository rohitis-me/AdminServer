<%@ page contentType="text/html"%>
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>
<%@ page import="i2i.AdminServer.Constants" %>

<div>
<p>
Thanks for ordering at pillocate! Please find your order details below,
</p>

<p>
Order Name: ${orderDetails.brandName }<br>
Tracking Id: ${orderDetails.trackingId }<br>
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
Track your order status <a href="${Constants.envLink+'orderStatus?trackingId='+orderDetails.trackingId }">here</a><br>
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