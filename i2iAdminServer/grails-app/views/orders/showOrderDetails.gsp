
<%@ page import="i2i.AdminServer.OrderDetailsCommand" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="show-orders" class="content scaffold-show" role="main">
			<ol class="property-list orders">
			
				<g:if test="${orderDetailsCommand?.name}">
				<li class="fieldcontain">
					<span id="personId-label" class="property-label"><g:message code="orders.personId.label" default="Person Name" /></span>
					
						<span class="property-value" aria-labelledby="personId-label"><g:fieldValue bean="${orderDetailsCommand}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderDetailsCommand?.brandName}">
				<li class="fieldcontain">
					<span id="brandId-label" class="property-label"><g:message code="orders.brandId.label" default="Brand Name" /></span>
					
						<span class="property-value" aria-labelledby="brandId-label"><g:fieldValue bean="${orderDetailsCommand}" field="brandName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderDetailsCommand?.storeName}">
				<li class="fieldcontain">
					<span id="storeId-label" class="property-label"><g:message code="orders.storeId.label" default="Store Name" /></span>
					
						<span class="property-value" aria-labelledby="storeId-label"><g:fieldValue bean="${orderDetailsCommand}" field="storeName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderDetailsCommand?.orderStatus}">
				<li class="fieldcontain">
					<span id="orderStatus-label" class="property-label"><g:message code="orders.orderStatus.label" default="Order Status" /></span>
					
						<span class="property-value" aria-labelledby="orderStatus-label"><g:fieldValue bean="${orderDetailsCommand}" field="orderStatus"/></span>
					
				</li>
				</g:if>
				
			</ol>
			<g:form >
			<g:hiddenField name="orderId" value="${orderDetailsCommand.orderId }"/>
				<fieldset class="buttons">
					<g:link class="accept" action="acceptOrder" params="[orderId: orderDetailsCommand.orderId]"><g:message code="order.status.accept.button" default="Accept Order" /></g:link>
					<g:actionSubmit class="reject" action="rejectOrder" value="${message(code: 'order.status.reject.button', default: 'Reject Order')}" onclick="return confirm('${message(code: 'order.status.reject.message')}');" />
				</fieldset>
			</g:form>
		</div>
		
		

	</body>
</html>
