
<%@ page import="i2i.AdminServer.Store"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<title><g:message message="i2i-Search List" /></title>
<g:set var="entityName"
	value="${message(code: 'i2i.search.results.label', default: 'Search Results')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<%--<r:require module="jquery-ui" />--%>
</head>
<body>
		<g:render template="/template/navigationClient" />
<%--<br/>--%>
<%--	<g:set var="brandId" value="${brandId}"></g:set>--%>
<%--	<g:set var="inventoryId" value="${inventoryId}"></g:set>--%>
	<g:render template="/template/searchBox"></g:render>
	<br />
	<table align="center">
		<g:if test="${storesList }">
		<g:if test="${!availabilityFlag }">
	    <div align="center">
	    <i>
	    <g:message code="search.result.unavailable" default="Currently unavailable. You could place an order under the following stores."/>
	    </i>
	    </div>
	    
		</g:if>
		<thead>
			<tr>
				<th>Name</th>

				<th>Remark</th>

				<%--<g:sortableColumn property="Availability" title="Availability" />--%>

			</tr>
		</thead>
		<tbody>
			<g:each in="${storesList}" status="i" var="storeInstance">
				<g:set var="storeId" value="${storeInstance?.storeId}"></g:set>
				<tr style="cursor: pointer;" class="${(i % 2) == 0 ? 'even' : 'odd'}" onclick='document.location = "<g:createLink controller="patientProfile"
					action="deliveryDetails"
					params="[storeId: storeId, brandId: brandId, inventoryId:inventoryId, circle: circle]"/>" '>


					<td>
							${fieldValue(bean: storeInstance, field: "storeName")}<br>
							${fieldValue(bean: storeInstance, field: "addressLine1")} <br>
						${fieldValue(bean: storeInstance, field: "addressLine2")} <br>
						${circle }, ${fieldValue(bean: storeInstance, field: "city")}
						</td>

					<td>
						<span style="color:#B0CF36"><g:message code="search.list.homedelivery" message="Home Delivery Available"/></span><br>
						<g:message code="search.list.etd" message="Delivery in: "/>${deliveryTime }
					</td>

					<%--						<td>${fieldValue(bean: storeInstance, field: "availabilityIndex")}</td>--%>

				</tr>
			</g:each>
		</tbody>
			</g:if>
			<g:else>
			<div align="center"><g:message code="search.result.unavailable" default="The stores in this area are currently offline"/></div>
<%--			<g:if test="${brandId == null || brandId == "" }">--%>
<%--			<br/><div align="center"><g:message code="search.result.inputerror" default="Tip: Select brand from auto suggestion."/></div>--%>
<%--			</g:if>--%>
			</g:else>
	</table>
</body>
</html>
