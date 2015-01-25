
<%@ page import="i2i.AdminServer.BrandDatabase" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'drug.label', default: 'Drug')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-drug" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-drug" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list drug">
			
				<g:if test="${drugInstance?.brandName}">
				<li class="fieldcontain">
					<span id="brandName-label" class="property-label"><g:message code="drug.brandName.label" default="Brand Name" /></span>
					
						<span class="property-value" aria-labelledby="brandName-label"><g:fieldValue bean="${drugInstance}" field="brandName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugInstance?.manufacturer}">
				<li class="fieldcontain">
					<span id="manufacturer-label" class="property-label"><g:message code="drug.manufacturer.label" default="Manufacturer" /></span>
					
						<span class="property-value" aria-labelledby="manufacturer-label"><g:fieldValue bean="${drugInstance}" field="manufacturer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugInstance?.generic}">
				<li class="fieldcontain">
					<span id="generic-label" class="property-label"><g:message code="drug.generic.label" default="Generic" /></span>
					
						<span class="property-value" aria-labelledby="generic-label"><g:fieldValue bean="${drugInstance}" field="generic"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugInstance?.strength}">
				<li class="fieldcontain">
					<span id="strength-label" class="property-label"><g:message code="drug.strength.label" default="Strength" /></span>
					
						<span class="property-value" aria-labelledby="strength-label"><g:fieldValue bean="${drugInstance}" field="strength"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugInstance?.noOfUnits}">
				<li class="fieldcontain">
					<span id="noOfUnits-label" class="property-label"><g:message code="drug.noOfUnits.label" default="No Of Units" /></span>
					
						<span class="property-value" aria-labelledby="noOfUnits-label"><g:fieldValue bean="${drugInstance}" field="noOfUnits"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugInstance?.form}">
				<li class="fieldcontain">
					<span id="form-label" class="property-label"><g:message code="drug.form.label" default="Form" /></span>
					
						<span class="property-value" aria-labelledby="form-label"><g:fieldValue bean="${drugInstance}" field="form"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugInstance?.mrp}">
				<li class="fieldcontain">
					<span id="mrp-label" class="property-label"><g:message code="drug.mrp.label" default="Mrp" /></span>
					
						<span class="property-value" aria-labelledby="mrp-label"><g:fieldValue bean="${drugInstance}" field="mrp"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugInstance?.brandId}">
				<li class="fieldcontain">
					<span id="brandId-label" class="property-label"><g:message code="drug.brandId.label" default="Brand Id" /></span>
					
						<span class="property-value" aria-labelledby="brandId-label"><g:fieldValue bean="${drugInstance}" field="brandId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:drugInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${drugInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
