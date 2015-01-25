
<%@ page import="i2i.AdminServer.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-orders" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list orders">
			
				<g:if test="${ordersInstance?.personId}">
				<li class="fieldcontain">
					<span id="personId-label" class="property-label"><g:message code="orders.personId.label" default="Person Id" /></span>
					
						<span class="property-value" aria-labelledby="personId-label"><g:fieldValue bean="${ordersInstance}" field="personId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ordersInstance?.brandId}">
				<li class="fieldcontain">
					<span id="brandId-label" class="property-label"><g:message code="orders.brandId.label" default="Brand Id" /></span>
					
						<span class="property-value" aria-labelledby="brandId-label"><g:fieldValue bean="${ordersInstance}" field="brandId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ordersInstance?.storeId}">
				<li class="fieldcontain">
					<span id="storeId-label" class="property-label"><g:message code="orders.storeId.label" default="Store Id" /></span>
					
						<span class="property-value" aria-labelledby="storeId-label"><g:fieldValue bean="${ordersInstance}" field="storeId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ordersInstance?.orderStatus}">
				<li class="fieldcontain">
					<span id="orderStatus-label" class="property-label"><g:message code="orders.orderStatus.label" default="Order Status" /></span>
					
						<span class="property-value" aria-labelledby="orderStatus-label"><g:fieldValue bean="${ordersInstance}" field="orderStatus"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:ordersInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${ordersInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
