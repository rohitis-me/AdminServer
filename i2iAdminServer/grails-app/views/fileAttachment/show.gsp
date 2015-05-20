
<%@ page import="i2i.AdminServer.User.FileAttachment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fileAttachment.label', default: 'FileAttachment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-fileAttachment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-fileAttachment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list fileAttachment">
			
				<g:if test="${fileAttachmentInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="fileAttachment.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${fileAttachmentInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fileAttachmentInstance?.path}">
				<li class="fieldcontain">
					<span id="path-label" class="property-label"><g:message code="fileAttachment.path.label" default="Path" /></span>
					
						<span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${fileAttachmentInstance}" field="path"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fileAttachmentInstance?.dateUploaded}">
				<li class="fieldcontain">
					<span id="dateUploaded-label" class="property-label"><g:message code="fileAttachment.dateUploaded.label" default="Date Uploaded" /></span>
					
						<span class="property-value" aria-labelledby="dateUploaded-label"><g:formatDate date="${fileAttachmentInstance?.dateUploaded}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${fileAttachmentInstance?.attachmentId}">
				<li class="fieldcontain">
					<span id="attachmentId-label" class="property-label"><g:message code="fileAttachment.attachmentId.label" default="Attachment Id" /></span>
					
						<span class="property-value" aria-labelledby="attachmentId-label"><g:fieldValue bean="${fileAttachmentInstance}" field="attachmentId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:fileAttachmentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${fileAttachmentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
