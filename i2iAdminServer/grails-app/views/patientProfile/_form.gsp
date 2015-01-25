<%@ page import="i2i.AdminServer.User.PatientProfile" %>



<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="patientProfile.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="100" required="required" value="${patientProfileInstance?.name}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'phoneNumber', 'error')} required">
	<label for="phoneNumber">
		<g:message code="patientProfile.phoneNumber.label" default="Phone Number" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phoneNumber" maxlength="100" required="required" value="${patientProfileInstance?.phoneNumber}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'emailID', 'error')} ">
	<label for="emailID">
		<g:message code="patientProfile.emailID.label" default="Email ID" />
		
	</label>
	<g:textField name="emailID" maxlength="100" value="${patientProfileInstance?.emailID}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'addressLine1', 'error')} required">
	<label for="addressLine1">
		<g:message code="patientProfile.addressLine1.label" default="Address Line1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="addressLine1" maxlength="100" required="required" value="${patientProfileInstance?.addressLine1}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'addressLine2', 'error')} required">
	<label for="addressLine2">
		<g:message code="patientProfile.addressLine2.label" default="Address Line2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="addressLine2" maxlength="100" required="required" value="${patientProfileInstance?.addressLine2}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'circle', 'error')} required">
	<label for="circle">
		<g:message code="patientProfile.circle.label" default="Circle" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="circle" maxlength="100" required="required" value="${patientProfileInstance?.circle}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="patientProfile.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="state" maxlength="100" required="required" value="${patientProfileInstance?.state}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'age', 'error')} required">
	<label for="age">
		<g:message code="patientProfile.age.label" default="Age" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="age" value="${fieldValue(bean: patientProfileInstance, field: 'age')}" />
</div>

<div class="fieldcontain ${hasErrors(bean: patientProfileInstance, field: 'country', 'error')} required">
	<label for="country">
		<g:message code="patientProfile.country.label" default="Country" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="country" value="${patientProfileInstance?.country}" />
</div>

