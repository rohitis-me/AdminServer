
<%@ page import="i2i.AdminServer.Availability" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'availability.label', default: 'Availability')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-availability" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-availability" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list availability">
			
				<g:if test="${availabilityInstance?.storeId}">
				<li class="fieldcontain">
					<span id="storeId-label" class="property-label"><g:message code="availability.storeId.label" default="Store Id" /></span>
					
						<span class="property-value" aria-labelledby="storeId-label"><g:fieldValue bean="${availabilityInstance}" field="storeId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${availabilityInstance?.brandId}">
				<li class="fieldcontain">
					<span id="brandId-label" class="property-label"><g:message code="availability.brandId.label" default="Brand Id" /></span>
					
						<span class="property-value" aria-labelledby="brandId-label"><g:fieldValue bean="${availabilityInstance}" field="brandId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${availabilityInstance?.availabilityIndex}">
				<li class="fieldcontain">
					<span id="availabilityIndex-label" class="property-label"><g:message code="availability.availabilityIndex.label" default="Availability Index" /></span>
					
						<span class="property-value" aria-labelledby="availabilityIndex-label"><g:fieldValue bean="${availabilityInstance}" field="availabilityIndex"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:availabilityInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${availabilityInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
