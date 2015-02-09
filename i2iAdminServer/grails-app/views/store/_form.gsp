<%@ page import="i2i.AdminServer.Store" %>



<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'storeId', 'error')} required">
	<label for="storeId">
		<g:message code="store.storeId.label" default="Store Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="storeId" maxlength="100" required="" value="${storeInstance?.storeId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'storeName', 'error')} required">
	<label for="storeName">
		<g:message code="store.storeName.label" default="Store Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="storeName" maxlength="100" required="" value="${storeInstance?.storeName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'addressLine1', 'error')} required">
	<label for="addressLine1">
		<g:message code="store.addressLine1.label" default="Address Line1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="addressLine1" maxlength="100" required="" value="${storeInstance?.addressLine1}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'addressLine2', 'error')} required">
	<label for="addressLine2">
		<g:message code="store.addressLine2.label" default="Address Line2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="addressLine2" maxlength="100" required="" value="${storeInstance?.addressLine2}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'circle', 'error')} required">
	<label for="circle">
		<g:message code="store.circle.label" default="Circle" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="circle" maxlength="100" required="" value="${storeInstance?.circle}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'city', 'error')} required">
	<label for="city">
		<g:message code="store.city.label" default="City" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="city" maxlength="100" required="" value="${storeInstance?.city}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="store.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="state" maxlength="100" required="" value="${storeInstance?.state}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="store.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="latitude" maxlength="100" required="" value="${storeInstance?.latitude}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="store.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="longitude" maxlength="100" required="" value="${storeInstance?.longitude}"/>

</div>

