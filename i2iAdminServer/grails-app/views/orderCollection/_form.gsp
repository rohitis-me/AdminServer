<%@ page import="i2i.AdminServer.OrderCollection" %>



<div class="fieldcontain ${hasErrors(bean: orderCollectionInstance, field: 'personId', 'error')} required">
	<label for="personId">
		<g:message code="orderCollection.personId.label" default="Person Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="personId" maxlength="100" required="" value="${orderCollectionInstance?.personId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: orderCollectionInstance, field: 'orderRefId', 'error')} required">
	<label for="orderRefId">
		<g:message code="orderCollection.orderRefId.label" default="Order Ref Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="orderRefId" maxlength="100" required="" value="${orderCollectionInstance?.orderRefId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: orderCollectionInstance, field: 'offerCode', 'error')} ">
	<label for="offerCode">
		<g:message code="orderCollection.offerCode.label" default="Offer Code" />
		
	</label>
	<g:textField name="offerCode" maxlength="100" value="${orderCollectionInstance?.offerCode}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: orderCollectionInstance, field: 'attachmentId', 'error')} ">
	<label for="attachmentId">
		<g:message code="orderCollection.attachmentId.label" default="Attachment Id" />
		
	</label>
	<g:textField name="attachmentId" maxlength="100" value="${orderCollectionInstance?.attachmentId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: orderCollectionInstance, field: 'orderCollectionId', 'error')} required">
	<label for="orderCollectionId">
		<g:message code="orderCollection.orderCollectionId.label" default="Order Collection Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="orderCollectionId" type="number" value="${orderCollectionInstance.orderCollectionId}" required=""/>

</div>

