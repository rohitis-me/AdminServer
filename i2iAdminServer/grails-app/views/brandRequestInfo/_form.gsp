<%@ page import="i2i.AdminServer.User.BrandRequestInfo" %>



<div class="fieldcontain ${hasErrors(bean: brandRequestInfoInstance, field: 'brandName', 'error')} required">
	<label for="brandName">
		<g:message code="brandRequestInfo.brandName.label" default="Brand Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brandName" maxlength="100" required="" value="${brandRequestInfoInstance?.brandName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: brandRequestInfoInstance, field: 'emailID', 'error')} ">
	<label for="emailID">
		<g:message code="brandRequestInfo.emailID.label" default="Email ID" />
		
	</label>
	<g:textField name="emailID" maxlength="100" value="${brandRequestInfoInstance?.emailID}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: brandRequestInfoInstance, field: 'phoneNumber', 'error')} ">
	<label for="phoneNumber">
		<g:message code="brandRequestInfo.phoneNumber.label" default="Phone Number" />
		
	</label>
	<g:textField name="phoneNumber" maxlength="100" value="${brandRequestInfoInstance?.phoneNumber}"/>

</div>

