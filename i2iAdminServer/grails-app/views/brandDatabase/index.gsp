
<%@ page import="i2i.AdminServer.BrandDatabase" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'drug.label', default: 'Drug')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-drug" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-drug" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="brandName" title="${message(code: 'drug.brandName.label', default: 'Brand Name')}" />
					
						<g:sortableColumn property="manufacturer" title="${message(code: 'drug.manufacturer.label', default: 'Manufacturer')}" />
					
						<g:sortableColumn property="generic" title="${message(code: 'drug.generic.label', default: 'Generic')}" />
					
						<g:sortableColumn property="strength" title="${message(code: 'drug.strength.label', default: 'Strength')}" />
					
						<g:sortableColumn property="noOfUnits" title="${message(code: 'drug.noOfUnits.label', default: 'No Of Units')}" />
					
						<g:sortableColumn property="form" title="${message(code: 'drug.form.label', default: 'Form')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${drugInstanceList}" status="i" var="drugInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${drugInstance.id}">${fieldValue(bean: drugInstance, field: "brandName")}</g:link></td>
					
						<td>${fieldValue(bean: drugInstance, field: "manufacturer")}</td>
					
						<td>${fieldValue(bean: drugInstance, field: "generic")}</td>
					
						<td>${fieldValue(bean: drugInstance, field: "strength")}</td>
					
						<td>${fieldValue(bean: drugInstance, field: "noOfUnits")}</td>
					
						<td>${fieldValue(bean: drugInstance, field: "form")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${drugInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
