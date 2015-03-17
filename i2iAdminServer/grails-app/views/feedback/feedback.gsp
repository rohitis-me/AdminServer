<!DOCTYPE html>
<html>
<head>
<g:set var="entityName"
	value="${message(code: 'feedback.label', default: 'Feedback')}" />
<meta name="layout" content="searchLayout">
<title><g:message code="default.create.label"
		args="[entityName]" /></title>
</head>
<body>
	<g:render template="/template/navigationClient" />
<br/>
	<g:if test="${flash.message}">
		<div align="center" class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	
<%--	<br />--%>
<p align="center">Have a complaint, suggestion or query?
Write to us</p>
<br/>
	<g:form controller="feedback" action="sendFeedback" method="PUT">
		<table align="center" style="border-top: 0">
			<tbody>
				<tr>
					<td style="width: 25%"><label class="label-control"><g:message
								code="default.name.label" default="Name *" /></label></td>
					<td><g:textField name="name" class="textbox-control"
							required="required" /></td>
				</tr>
				<tr>
					<td><label class="label-control"><g:message
								code="patientProfile.emailID.label" default="Email Id" /></label></td>
					<td><g:field class="textbox-control" name="emailID"
							type="email" maxlength="100"/></td>
				</tr>
				<tr>
					<td><label class="label-control">Message *</label></td>
					<td><g:textArea class="textbox-control" name="message"
							required="required"
							maxlength="1000" /></td>
				</tr>
			</tbody>
		</table>
		<div align="center">
			<g:submitButton name="Submit"
				value="${message(code: 'default.button.submit.label', default: 'Submit')}"
				class="btn btn-default" />
		</div>
	</g:form>
	<br />
</body>
</html>
