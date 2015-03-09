<%@ page import="i2i.AdminServer.User.Feedback" %>



<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="feedback.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="100" required="" value="${feedbackInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'message', 'error')} required">
	<label for="message">
		<g:message code="feedback.message.label" default="Message" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="message" cols="40" rows="5" maxlength="1000" required="" value="${feedbackInstance?.message}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'emailID', 'error')} ">
	<label for="emailID">
		<g:message code="feedback.emailID.label" default="Email ID" />
		
	</label>
	<g:textField name="emailID" maxlength="100" value="${feedbackInstance?.emailID}"/>

</div>

