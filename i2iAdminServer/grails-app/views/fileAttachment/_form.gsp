<%@ page import="i2i.AdminServer.User.FileAttachment" %>



<div class="fieldcontain ${hasErrors(bean: fileAttachmentInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="fileAttachment.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="100" required="" value="${fileAttachmentInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: fileAttachmentInstance, field: 'path', 'error')} required">
	<label for="path">
		<g:message code="fileAttachment.path.label" default="Path" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="path" maxlength="100" required="" value="${fileAttachmentInstance?.path}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: fileAttachmentInstance, field: 'dateUploaded', 'error')} required">
	<label for="dateUploaded">
		<g:message code="fileAttachment.dateUploaded.label" default="Date Uploaded" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateUploaded" precision="day"  value="${fileAttachmentInstance?.dateUploaded}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: fileAttachmentInstance, field: 'attachmentId', 'error')} required">
	<label for="attachmentId">
		<g:message code="fileAttachment.attachmentId.label" default="Attachment Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="attachmentId" type="number" value="${fileAttachmentInstance.attachmentId}" required=""/>

</div>

