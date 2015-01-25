<%@ page import="com.pharmacy.store.Billing" %>



<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'billingId', 'error')} required">
	<label for="billingId">
		<g:message code="billing.billingId.label" default="Billing Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="billingId" required="" value="${billingInstance?.billingId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'billingNumber', 'error')} required">
	<label for="billingNumber">
		<g:message code="billing.billingNumber.label" default="Billing Number" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="billingNumber" required="" value="${billingInstance?.billingNumber}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'billingTime', 'error')} required">
	<label for="billingTime">
		<g:message code="billing.billingTime.label" default="Billing Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="billingTime" precision="day"  value="${billingInstance?.billingTime}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'discountAmount', 'error')} required">
	<label for="discountAmount">
		<g:message code="billing.discountAmount.label" default="Discount Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="discountAmount" value="${fieldValue(bean: billingInstance, field: 'discountAmount')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'finalAmount', 'error')} required">
	<label for="finalAmount">
		<g:message code="billing.finalAmount.label" default="Final Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="finalAmount" value="${fieldValue(bean: billingInstance, field: 'finalAmount')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'inventoryId', 'error')} required">
	<label for="inventoryId">
		<g:message code="billing.inventoryId.label" default="Inventory Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="inventoryId" required="" value="${billingInstance?.inventoryId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'isDeleted', 'error')} ">
	<label for="isDeleted">
		<g:message code="billing.isDeleted.label" default="Is Deleted" />
		
	</label>
	<g:checkBox name="isDeleted" value="${billingInstance?.isDeleted}" />

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'lastUpdatedTimeStamp', 'error')} required">
	<label for="lastUpdatedTimeStamp">
		<g:message code="billing.lastUpdatedTimeStamp.label" default="Last Updated Time Stamp" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="lastUpdatedTimeStamp" type="number" value="${billingInstance.lastUpdatedTimeStamp}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'orderStatus', 'error')} required">
	<label for="orderStatus">
		<g:message code="billing.orderStatus.label" default="Order Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="orderStatus" type="number" value="${billingInstance.orderStatus}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'patientId', 'error')} required">
	<label for="patientId">
		<g:message code="billing.patientId.label" default="Patient Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="patientId" required="" value="${billingInstance?.patientId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'paymentType', 'error')} required">
	<label for="paymentType">
		<g:message code="billing.paymentType.label" default="Payment Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="paymentType" type="number" value="${billingInstance.paymentType}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'quantity', 'error')} required">
	<label for="quantity">
		<g:message code="billing.quantity.label" default="Quantity" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="quantity" type="number" value="${billingInstance.quantity}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'sellingPrice', 'error')} required">
	<label for="sellingPrice">
		<g:message code="billing.sellingPrice.label" default="Selling Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="sellingPrice" type="number" value="${billingInstance.sellingPrice}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'storeId', 'error')} required">
	<label for="storeId">
		<g:message code="billing.storeId.label" default="Store Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="storeId" required="" value="${billingInstance?.storeId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: billingInstance, field: 'vatAmount', 'error')} required">
	<label for="vatAmount">
		<g:message code="billing.vatAmount.label" default="Vat Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="vatAmount" value="${fieldValue(bean: billingInstance, field: 'vatAmount')}" required=""/>

</div>

