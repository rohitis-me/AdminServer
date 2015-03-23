
<%@ page import="i2i.AdminServer.Store"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">

<title><g:message message="i2i-Search Suggestions" /></title>
<g:set var="entityName"
	value="${message(code: 'i2i.search.suggestions.label', default: 'Search Suggestions')}" />
<title><g:message message="Search Suggestions" /></title>
</head>
<body>
	<g:render template="/template/navigationClient" />

<%--<br/>--%>
<%--	<g:set var="brandId" value="${brandId}"></g:set>--%>
	<g:render template="/template/searchBox"></g:render>
	<br />
	<table align="center" style="border-top: 0">
		<g:if test="${drugList}">
			<div align="center">${drugList.size()}<g:message code="search.result.medicine.found" default=" medicines found!"/></div>
		<br/>
<%--		<thead>--%>
<%--			<tr>--%>
<%--				<g:sortableColumn property="BrandName" title="BrandName" />--%>
<%--				<g:sortableColumn property="Strength" title="Strength" />--%>
<%--				<g:sortableColumn property="Form" title="Form" />--%>
<%----%>
<%--				<g:sortableColumn property="Availability" title="Availability" />--%>
<%----%>
<%--			</tr>--%>
<%--		</thead>--%>
		<tbody>
			<g:each in="${drugList}" status="i" var="drugInstance">
				<g:set var="brandName" value="${drugInstance?.brandName}"></g:set>
				<g:if test="${drugInstance?.strength}">
				<g:set var="brandName" value="${brandName+" "+drugInstance.strength}"></g:set>
				</g:if>
				<g:if test="${drugInstance?.form}">
				<g:set var="brandName" value="${brandName+" "+drugInstance.form}"></g:set>
				</g:if>
				
				<tr style="cursor: pointer;" class="${(i % 2) == 0 ? 'even' : 'odd'}" onclick='document.location = "<g:createLink controller="search"
					action="search"
					params="[brandName: brandName, brandId: drugInstance.brandId, inventoryId: drugInstance.inventoryId, circle: circle]"/>" '>

					<td>
						${fieldValue(bean: drugInstance, field: "brandName")}
					</td>
<%--					<td>--%>
<%--						${fieldValue(bean: drugInstance, field: "strength")} --%>
<%--					</td>--%>
<%--					<td>--%>
<%--						${fieldValue(bean: drugInstance, field: "form")} <br>--%>
<%--					</td>--%>

<%--					<td>--%>
<%--						<span style="color:#B0CF36"><g:message code="search.list.homedelivery" message="Home Delivery Available"/></span><br>--%>
<%--						<g:message code="search.list.etd" message="Delivery in: "/>${deliveryTime }--%>
<%--					</td>--%>

					<%--						<td>${fieldValue(bean: storeInstance, field: "availabilityIndex")}</td>--%>

				</tr>
			</g:each>
		</tbody>
			</g:if>
			<g:else>
			<div align="center"><g:message code="search.result.unavailable" default="No medicines found!"/></div>
<%--			<g:if test="${brandId == null || brandId == "" }">--%>
<%--			<br/><div align="center"><g:message code="search.result.inputerror" default="Tip: Select brand from auto suggestion."/></div>--%>
<%--			</g:if>--%>
			</g:else>
	</table>
</body>
</html>
