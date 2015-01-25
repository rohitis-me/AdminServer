

<%@ page import="i2i.AdminServer.User.PatientProfile" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
		<div data-role="header" data-position="fixed">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<div data-role="navbar">
			</div>
		</div>
		<div data-role="content">
			<g:if test="${flash.message}">
			<div class="message" role="alert">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${orderDetails}">
			<div class="errors" role="alert">
				<g:renderErrors bean="${orderDetails}" as="list" />
			</div>
			</g:hasErrors>
			
			<dl>
			
				<dt><g:message code="orderDetails.brandname.label" default="Order name" /></dt>
				
					<dd><g:fieldValue bean="${orderDetails}" field="brandName"/></dd>
				
			
				<dt><g:message code="orderDetails.store.label" default="Store" /></dt>
				
					<dd><g:fieldValue bean="${orderDetails}" field="storeName"/></dd>
				
			
			</dl>
			
			<g:form action="saveOrder" >
			
			<g:hiddenField name="brandId" value="${orderDetails?.brandId }"/>
			<g:hiddenField name="storeId" value="${orderDetails?.storeId }"/>
			
				<div data-role="fieldcontain">
					<label for="name"><g:message code="patientProfile.name.label" default="Name" /></label>
					<g:textField name="name" maxlength="100" required="required" value="${orderDetails?.name}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="phoneNumber"><g:message code="patientProfile.phoneNumber.label" default="Phone Number" /></label>
					<g:textField name="phoneNumber" maxlength="100" required="required" value="${orderDetails?.phoneNumber}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="emailID"><g:message code="patientProfile.emailID.label" default="Email ID" /></label>
					<g:textField name="emailID" maxlength="100" value="${orderDetails?.emailID}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="age"><g:message code="patientProfile.age.label" default="Age" /></label>
					<g:field type="number" name="age" value="${fieldValue(bean: orderDetails, field: 'age')}" />
				</div>
				
				<div data-role="fieldcontain">
					<label for="addressLine1"><g:message code="patientProfile.addressLine1.label" default="Address Line1" /></label>
					<g:textField name="addressLine1" maxlength="100" required="required" value="${orderDetails?.addressLine1}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="addressLine2"><g:message code="patientProfile.addressLine2.label" default="Address Line2" /></label>
					<g:textField name="addressLine2" maxlength="100" required="required" value="${orderDetails?.addressLine2}" />
				</div>
			
				<div data-role="fieldcontain">
					<label for="circle"><g:message code="patientProfile.circle.label" default="Circle" /></label>
					<g:textField name="circle" maxlength="100" required="required" value="${orderDetails?.circle}" />
				</div>

			<div data-role="fieldcontain">
					<label for="city"><g:message code="patientProfile.city.label" default="City" /></label>
					<g:textField name="city" maxlength="100" required="required" value="${orderDetails?.city}" />
				</div>
				
				<div data-role="fieldcontain">
					<label for="state"><g:message code="patientProfile.state.label" default="State" /></label>
					<g:textField name="state" maxlength="100" required="required" value="${orderDetails?.state}" />
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
