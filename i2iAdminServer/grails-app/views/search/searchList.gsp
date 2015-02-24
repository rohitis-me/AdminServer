
<%@ page import="i2i.AdminServer.Store"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">

<title><g:message message="i2i-Search List" /></title>
<%--<r:require module="jquery-ui" />--%>
</head>
<body>
<br/>
	<g:set var="brandId" value="${brandId}"></g:set>
	<g:render template="/template/searchBox"></g:render>
	<br />
	<table align="center">
		<thead>
			<tr>
				<g:sortableColumn property="Name" title="Name" />

				<g:sortableColumn property="Remark" title="Remark" />

				<%--						<g:sortableColumn property="Availability" title="Availability" />--%>

			</tr>
		</thead>
		<tbody>
		<g:if test="${storesList }">
			<g:each in="${storesList}" status="i" var="storeInstance">
				<g:set var="storeId" value="${storeInstance?.storeId}"></g:set>
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}" onclick='document.location = "<g:createLink controller="patientProfile"
					action="deliveryDetails"
					params="[storeId: storeId, brandId: brandId, circle: circle]"/>" '>


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
			</g:if>
			<g:else>
			<g:message code="search.result.unavailable" default="Unavailable"/>
			</g:else>
		</tbody>
	</table>
</body>
</html>
