
<%@ page import="i2i.AdminServer.User.PatientProfile" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="mobile">
        <g:set var="entityName" value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
		<div data-role="header" data-position="fixed">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<div data-role="navbar">
				<ul>
					<li><a data-icon="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
					<li><g:link data-icon="grid" data-ajax="false" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				</ul>
			</div>
		</div>
		<div data-role="content">
			<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
			</g:if>
			<dl>
			
				<dt><g:message code="patientProfile.id.label" default="Id" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="id"/></dd>
				
			
				<dt><g:message code="patientProfile.name.label" default="Name" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="name"/></dd>
				
			
				<dt><g:message code="patientProfile.phoneNumber.label" default="Phone Number" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="phoneNumber"/></dd>
				
			
				<dt><g:message code="patientProfile.emailID.label" default="Email ID" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="emailID"/></dd>
				
			
				<dt><g:message code="patientProfile.addressLine1.label" default="Address Line1" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="addressLine1"/></dd>
				
			
				<dt><g:message code="patientProfile.addressLine2.label" default="Address Line2" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="addressLine2"/></dd>
				
			
				<dt><g:message code="patientProfile.circle.label" default="Circle" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="circle"/></dd>
				
			
				<dt><g:message code="patientProfile.state.label" default="State" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="state"/></dd>
				
			
				<dt><g:message code="patientProfile.age.label" default="Age" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="age"/></dd>
				
			
				<dt><g:message code="patientProfile.country.label" default="Country" /></dt>
				
					<dd><g:fieldValue bean="${patientProfileInstance}" field="country"/></dd>
				
			
			</dl>
			<g:form>
				<g:hiddenField name="id" value="${patientProfileInstance?.id}" />
				<g:actionSubmit data-icon="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
			</g:form>
		</div>
		<div data-role="footer">
		</div>
    </body>
</html>
