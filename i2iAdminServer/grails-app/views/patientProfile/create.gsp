

<%@ page import="i2i.AdminServer.User.PatientProfile" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="mobile">
        <g:set var="entityName" value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
		<div data-role="header" data-position="fixed">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<div data-role="navbar">
				<ul>
					<li><a data-icon="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
					<li><g:link data-icon="grid" data-ajax="false" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				</ul>
			</div>
		</div>
		<div data-role="content">
			<g:if test="${flash.message}">
			<div class="message" role="alert">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${patientProfileInstance}">
			<div class="errors" role="alert">
				<g:renderErrors bean="${patientProfileInstance}" as="list" />
			</div>
			</g:hasErrors>
			<g:form action="save" >
			
				<div data-role="fieldcontain">
					<label for="name"><g:message code="patientProfile.name.label" default="Name" /></label>
					<g:textField name="name" maxlength="100" required="required" value="${patientProfileInstance?.name}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="phoneNumber"><g:message code="patientProfile.phoneNumber.label" default="Phone Number" /></label>
					<g:textField name="phoneNumber" maxlength="100" required="required" value="${patientProfileInstance?.phoneNumber}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="emailID"><g:message code="patientProfile.emailID.label" default="Email ID" /></label>
					<g:textField name="emailID" maxlength="100" value="${patientProfileInstance?.emailID}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="addressLine1"><g:message code="patientProfile.addressLine1.label" default="Address Line1" /></label>
					<g:textField name="addressLine1" maxlength="100" required="required" value="${patientProfileInstance?.addressLine1}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="addressLine2"><g:message code="patientProfile.addressLine2.label" default="Address Line2" /></label>
					<g:textField name="addressLine2" maxlength="100" required="required" value="${patientProfileInstance?.addressLine2}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="circle"><g:message code="patientProfile.circle.label" default="Circle" /></label>
					<g:textField name="circle" maxlength="100" required="required" value="${patientProfileInstance?.circle}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="state"><g:message code="patientProfile.state.label" default="State" /></label>
					<g:textField name="state" maxlength="100" required="required" value="${patientProfileInstance?.state}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="age"><g:message code="patientProfile.age.label" default="Age" /></label>
					<g:field type="number" name="age" value="${fieldValue(bean: patientProfileInstance, field: 'age')}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="country"><g:message code="patientProfile.country.label" default="Country" /></label>
					<g:textField name="country" value="${patientProfileInstance?.country}" />
				</div>
			
				<g:submitButton name="create" data-icon="check" value="${message(code: 'default.button.create.label', default: 'Create')}" />
			</g:form>
		</div>
		<div data-role="footer">
		</div>
    </body>
</html>
