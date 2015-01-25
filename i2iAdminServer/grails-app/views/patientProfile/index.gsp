
<%@ page import="i2i.AdminServer.User.PatientProfile" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-patientProfile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-patientProfile" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'patientProfile.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="phoneNumber" title="${message(code: 'patientProfile.phoneNumber.label', default: 'Phone Number')}" />
					
						<g:sortableColumn property="emailID" title="${message(code: 'patientProfile.emailID.label', default: 'Email ID')}" />
					
						<g:sortableColumn property="addressLine1" title="${message(code: 'patientProfile.addressLine1.label', default: 'Address Line1')}" />
					
						<g:sortableColumn property="addressLine2" title="${message(code: 'patientProfile.addressLine2.label', default: 'Address Line2')}" />
					
						<g:sortableColumn property="circle" title="${message(code: 'patientProfile.circle.label', default: 'Circle')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${patientProfileInstanceList}" status="i" var="patientProfileInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${patientProfileInstance.id}">${fieldValue(bean: patientProfileInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: patientProfileInstance, field: "phoneNumber")}</td>
					
						<td>${fieldValue(bean: patientProfileInstance, field: "emailID")}</td>
					
						<td>${fieldValue(bean: patientProfileInstance, field: "addressLine1")}</td>
					
						<td>${fieldValue(bean: patientProfileInstance, field: "addressLine2")}</td>
					
						<td>${fieldValue(bean: patientProfileInstance, field: "circle")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${patientProfileInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
