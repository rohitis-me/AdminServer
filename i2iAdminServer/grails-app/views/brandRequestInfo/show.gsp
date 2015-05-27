
<%@ page import="i2i.AdminServer.User.BrandRequestInfo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'brandRequestInfo.label', default: 'BrandRequestInfo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-brandRequestInfo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-brandRequestInfo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list brandRequestInfo">
			
				<g:if test="${brandRequestInfoInstance?.brandName}">
				<li class="fieldcontain">
					<span id="brandName-label" class="property-label"><g:message code="brandRequestInfo.brandName.label" default="Brand Name" /></span>
					
						<span class="property-value" aria-labelledby="brandName-label"><g:fieldValue bean="${brandRequestInfoInstance}" field="brandName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${brandRequestInfoInstance?.emailID}">
				<li class="fieldcontain">
					<span id="emailID-label" class="property-label"><g:message code="brandRequestInfo.emailID.label" default="Email ID" /></span>
					
						<span class="property-value" aria-labelledby="emailID-label"><g:fieldValue bean="${brandRequestInfoInstance}" field="emailID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${brandRequestInfoInstance?.phoneNumber}">
				<li class="fieldcontain">
					<span id="phoneNumber-label" class="property-label"><g:message code="brandRequestInfo.phoneNumber.label" default="Phone Number" /></span>
					
						<span class="property-value" aria-labelledby="phoneNumber-label"><g:fieldValue bean="${brandRequestInfoInstance}" field="phoneNumber"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:brandRequestInfoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${brandRequestInfoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
