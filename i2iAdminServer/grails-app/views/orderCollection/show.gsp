
<%@ page import="i2i.AdminServer.OrderCollection" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orderCollection.label', default: 'OrderCollection')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-orderCollection" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-orderCollection" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list orderCollection">
			
				<g:if test="${orderCollectionInstance?.personId}">
				<li class="fieldcontain">
					<span id="personId-label" class="property-label"><g:message code="orderCollection.personId.label" default="Person Id" /></span>
					
						<span class="property-value" aria-labelledby="personId-label"><g:fieldValue bean="${orderCollectionInstance}" field="personId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderCollectionInstance?.orderRefId}">
				<li class="fieldcontain">
					<span id="orderRefId-label" class="property-label"><g:message code="orderCollection.orderRefId.label" default="Order Ref Id" /></span>
					
						<span class="property-value" aria-labelledby="orderRefId-label"><g:fieldValue bean="${orderCollectionInstance}" field="orderRefId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderCollectionInstance?.offerCode}">
				<li class="fieldcontain">
					<span id="offerCode-label" class="property-label"><g:message code="orderCollection.offerCode.label" default="Offer Code" /></span>
					
						<span class="property-value" aria-labelledby="offerCode-label"><g:fieldValue bean="${orderCollectionInstance}" field="offerCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderCollectionInstance?.attachmentId}">
				<li class="fieldcontain">
					<span id="attachmentId-label" class="property-label"><g:message code="orderCollection.attachmentId.label" default="Attachment Id" /></span>
					
						<span class="property-value" aria-labelledby="attachmentId-label"><g:fieldValue bean="${orderCollectionInstance}" field="attachmentId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderCollectionInstance?.orderCollectionId}">
				<li class="fieldcontain">
					<span id="orderCollectionId-label" class="property-label"><g:message code="orderCollection.orderCollectionId.label" default="Order Collection Id" /></span>
					
						<span class="property-value" aria-labelledby="orderCollectionId-label"><g:fieldValue bean="${orderCollectionInstance}" field="orderCollectionId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:orderCollectionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${orderCollectionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
