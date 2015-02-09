<%@ page import="i2i.AdminServer.Availability" %>



<div class="fieldcontain ${hasErrors(bean: availabilityInstance, field: 'storeId', 'error')} required">
	<label for="storeId">
		<g:message code="availability.storeId.label" default="Store Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="storeId" maxlength="100" required="" value="${availabilityInstance?.storeId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: availabilityInstance, field: 'brandId', 'error')} required">
	<label for="brandId">
		<g:message code="availability.brandId.label" default="Brand Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brandId" maxlength="100" required="" value="${availabilityInstance?.brandId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: availabilityInstance, field: 'availabilityIndex', 'error')} required">
	<label for="availabilityIndex">
		<g:message code="availability.availabilityIndex.label" default="Availability Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="availabilityIndex" type="number" value="${availabilityInstance.availabilityIndex}" required=""/>

</div>

