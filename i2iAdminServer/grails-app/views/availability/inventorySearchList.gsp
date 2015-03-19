
<%@ page import="i2i.AdminServer.Availability"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'availability.search.label', default: 'Availability Search')}" />
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
	<g:form controller="availability" action="searchInventory" method="get">
		<div align="center">
			<input name="brandName" required class="textbox-control"
				id="search_textField" placeholder="Enter medicine brand"
				style="width: 40%;" value="${brandName}" /> <input type="submit"
				name="searchButton" value="Search" class="btn btn-default"
				style="width: 20%; height: 33px" />
		</div>
	</g:form>
	<br />
	<div align="center">
		<div class="pagination" style="width: 60%;">
			<g:paginate
				total="${inventoryAvailabilityList.size() ?resultCount: 0}"
				controller="availability" action="searchInventory"
				params="[brandName: brandName]" />
		</div>
	</div>
	<g:if test="${inventoryAvailabilityList }">
		<table align="center">
			<thead>
				<tr>
					<g:sortableColumn property="brandName" style="width: 50%"
						title="${message(code: 'availability.storeId.label', default: 'Brand Name')}" />
					<g:sortableColumn property="availabilityIndex" style="width: 20%"
						title="${message(code: 'availability.availabilityIndex.label', default: 'Stock status')}" />
					<th style="width: 30%"></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${inventoryAvailabilityList}" status="i"
					var="availabilityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<g:set var="availabilityIndex"
							value="${availabilityInstance?.availabilityIndex}" />
						<td>
							${fieldValue(bean: availabilityInstance, field: "brandName")}
						</td>

						<td><g:if test="${availabilityIndex <= 0 }">Unavailable</g:if>
							<g:elseif test="${availabilityIndex > 0 }">available</g:elseif></td>

						<td><g:set var="availabilityId"
								value="${availabilityInstance?.availabilityId}" /> <g:form
								params='[availabilityId: availabilityId]'>
								<g:if test="${availabilityIndex <= 0 }">
									<g:actionSubmit name="submit" action="onClickAvailable"
										value="${message(code: 'default.button.available.label', default: 'Available')}"
										class="btn btn-default" style="width:80%" />
								</g:if>
								<g:elseif test="${availabilityIndex > 0 }">
									<g:actionSubmit name="submit" action="onClickUnavailable"
										value="${message(code: 'default.button.unavailable.label', default: 'Unavailable')}"
										class="btn btn-default" style="width:80%" />
								</g:elseif>
							</g:form></td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</g:if>
	<g:else>
		<div align="center">
			<g:message code="search.result.not.found" default="No results!" />
		</div>
	</g:else>
	<%--	<br/>--%>
</body>
</html>
