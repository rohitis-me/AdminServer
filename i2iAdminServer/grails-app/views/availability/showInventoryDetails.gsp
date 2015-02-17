
<%@ page import="i2i.AdminServer.Availability"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'availability.label', default: 'Availability')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<g:render template="/template/navigation" />
	<br />
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<div style="padding-left: 20%">
		<g:submitButton name="Available" class="btn btn-default" action="changeStockStatus"
				value="${message(code: 'availability.availabilityIndex.accept.button', default: 'Available')}" />
	</div>
	<br>

	<table align="center" class="scroll">
		<thead>
			<tr>
				<g:sortableColumn property="brandName" style="width: 30%"
					title="${message(code: 'availability.storeId.label', default: 'Brand Name')}" />

				<g:sortableColumn property="strength" style="width: 30%"
					title="${message(code: 'availability.brandId.label', default: 'Strength')}" />

				<g:sortableColumn property="form" style="width: 20%"
					title="${message(code: 'availability.form.label', default: 'Form')}" />

				<g:sortableColumn property="availabilityIndex" style="width: 20%"
					title="${message(code: 'availability.availabilityIndex.label', default: 'Stock status')}" />
			</tr>
		</thead>
		<tbody>
			<g:each in="${inventoryAvailabilityList}" status="i"
				var="availabilityInstance">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

					<td>
						<input type='checkbox' class='chk'/> ${fieldValue(bean: availabilityInstance, field: "brandName")}
					</td>

					<td>
						${fieldValue(bean: availabilityInstance, field: "strength")}
					</td>

					<td>
						${fieldValue(bean: availabilityInstance, field: "form")}
					</td>

					<td><g:link controller="availability"
							action="showInventoryDetails">Stock out</g:link></td>

				</tr>
			</g:each>
		</tbody>
	</table>
	<div class="pagination">
		<g:paginate total="${availabilityInstanceCount ?: 0}" />
	</div>
</body>
</html>
