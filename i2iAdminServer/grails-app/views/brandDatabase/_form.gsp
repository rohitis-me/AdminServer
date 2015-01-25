<%@ page import="i2i.AdminServer.BrandDatabase" %>



<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'brandName', 'error')} required">
	<label for="brandName">
		<g:message code="drug.brandName.label" default="Brand Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brandName" maxlength="100" required="" value="${drugInstance?.brandName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'manufacturer', 'error')} required">
	<label for="manufacturer">
		<g:message code="drug.manufacturer.label" default="Manufacturer" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="manufacturer" maxlength="100" required="" value="${drugInstance?.manufacturer}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'generic', 'error')} required">
	<label for="generic">
		<g:message code="drug.generic.label" default="Generic" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="generic" maxlength="100" required="" value="${drugInstance?.generic}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'strength', 'error')} required">
	<label for="strength">
		<g:message code="drug.strength.label" default="Strength" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="strength" maxlength="100" required="" value="${drugInstance?.strength}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'noOfUnits', 'error')} required">
	<label for="noOfUnits">
		<g:message code="drug.noOfUnits.label" default="No Of Units" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="noOfUnits" maxlength="100" required="" value="${drugInstance?.noOfUnits}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'form', 'error')} required">
	<label for="form">
		<g:message code="drug.form.label" default="Form" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="form" maxlength="100" required="" value="${drugInstance?.form}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'mrp', 'error')} required">
	<label for="mrp">
		<g:message code="drug.mrp.label" default="Mrp" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="mrp" maxlength="100" required="" value="${drugInstance?.mrp}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: drugInstance, field: 'brandId', 'error')} required">
	<label for="brandId">
		<g:message code="drug.brandId.label" default="Brand Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brandId" required="" value="${drugInstance?.brandId}"/>

</div>

