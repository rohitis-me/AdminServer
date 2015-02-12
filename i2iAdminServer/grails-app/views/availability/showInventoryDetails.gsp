
<%@ page import="i2i.AdminServer.Availability" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="adminLayout">
		<g:set var="entityName" value="${message(code: 'availability.label', default: 'Availability')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
<g:render template="/template/navigation" />	
<%--				<nav>--%>
<%--					<ul>--%>
<%--						<li><g:link controller="store" action="showStoreProfile">Profile</g:link></li>--%>
<%--						<li><g:link controller="orders" action="showOrderDetailsList">Orders</g:link></li>--%>
<%--						<li><g:link class="current" controller="availability" action="showInventoryDetails">Inventory</g:link></li>--%>
<%--					</ul>--%>
<%--				</nav>--%>
		<div id="list-availability" class="content scaffold-list" role="main">
			<h2><g:message code="default.list.label" args="[entityName]" /></h2>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="brandName" title="${message(code: 'availability.storeId.label', default: 'Brand Name')}" />
					
						<g:sortableColumn property="strength" title="${message(code: 'availability.brandId.label', default: 'Strength')}" />
					
						<g:sortableColumn property="form" title="${message(code: 'availability.availabilityIndex.label', default: 'Form')}" />
						
						<g:sortableColumn property="availabilityIndex" title="${message(code: 'availability.availabilityIndex.label', default: 'Stock out')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${inventoryAvailabilityList}" status="i" var="availabilityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: availabilityInstance, field: "brandName")}</td>
					
						<td>${fieldValue(bean: availabilityInstance, field: "strength")}</td>
					
						<td>${fieldValue(bean: availabilityInstance, field: "form")}</td>
						
						<td><g:link controller="availability" action="showInventoryDetails">Stock out</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${availabilityInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
