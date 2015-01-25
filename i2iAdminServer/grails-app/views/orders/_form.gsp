<%@ page import="i2i.AdminServer.Orders" %>



<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'personId', 'error')} required">
	<label for="personId">
		<g:message code="orders.personId.label" default="Person Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="personId" maxlength="100" required="" value="${ordersInstance?.personId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'brandId', 'error')} required">
	<label for="brandId">
		<g:message code="orders.brandId.label" default="Brand Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brandId" maxlength="100" required="" value="${ordersInstance?.brandId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'storeId', 'error')} required">
	<label for="storeId">
		<g:message code="orders.storeId.label" default="Store Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="storeId" maxlength="100" required="" value="${ordersInstance?.storeId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'orderStatus', 'error')} required">
	<label for="orderStatus">
		<g:message code="orders.orderStatus.label" default="Order Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="orderStatus" type="number" value="${ordersInstance.orderStatus}" required=""/>

</div>

