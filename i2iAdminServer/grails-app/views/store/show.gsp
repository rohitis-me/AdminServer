
<%@ page import="i2i.AdminServer.Store" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-store" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-store" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list store">
			
				<g:if test="${storeInstance?.storeId}">
				<li class="fieldcontain">
					<span id="storeId-label" class="property-label"><g:message code="store.storeId.label" default="Store Id" /></span>
					
						<span class="property-value" aria-labelledby="storeId-label"><g:fieldValue bean="${storeInstance}" field="storeId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.storeName}">
				<li class="fieldcontain">
					<span id="storeName-label" class="property-label"><g:message code="store.storeName.label" default="Store Name" /></span>
					
						<span class="property-value" aria-labelledby="storeName-label"><g:fieldValue bean="${storeInstance}" field="storeName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.addressLine1}">
				<li class="fieldcontain">
					<span id="addressLine1-label" class="property-label"><g:message code="store.addressLine1.label" default="Address Line1" /></span>
					
						<span class="property-value" aria-labelledby="addressLine1-label"><g:fieldValue bean="${storeInstance}" field="addressLine1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.addressLine2}">
				<li class="fieldcontain">
					<span id="addressLine2-label" class="property-label"><g:message code="store.addressLine2.label" default="Address Line2" /></span>
					
						<span class="property-value" aria-labelledby="addressLine2-label"><g:fieldValue bean="${storeInstance}" field="addressLine2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.circle}">
				<li class="fieldcontain">
					<span id="circle-label" class="property-label"><g:message code="store.circle.label" default="Circle" /></span>
					
						<span class="property-value" aria-labelledby="circle-label"><g:fieldValue bean="${storeInstance}" field="circle"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.city}">
				<li class="fieldcontain">
					<span id="city-label" class="property-label"><g:message code="store.city.label" default="City" /></span>
					
						<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${storeInstance}" field="city"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="store.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${storeInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label"><g:message code="store.latitude.label" default="Latitude" /></span>
					
						<span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${storeInstance}" field="latitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label"><g:message code="store.longitude.label" default="Longitude" /></span>
					
						<span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${storeInstance}" field="longitude"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:storeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${storeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
