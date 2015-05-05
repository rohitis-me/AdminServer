
<%@ page import="i2i.AdminServer.Store"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">

<title><g:message message="i2i-Search Suggestions" /></title>
<g:set var="entityName"
	value="${message(code: 'i2i.search.suggestions.label', default: 'Search Suggestions')}" />
<title><g:message message="Search Suggestions" /></title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />

	<%--<br/>--%>
	<%--	<g:set var="brandId" value="${brandId}"></g:set>--%>

	<div class="container">
		<div class="row">
	<g:render template="/template/searchBox"></g:render>
			<div class="col-md-10 col-md-offset-1">
				<g:if test="${drugList}">
					<div align="center">
						<label>${drugList.size()}<g:message code="search.result.medicine.found"
							default=" medicines found!" /></label>
					</div>
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<%--						<div class="panel-heading">Order Status</div>--%>
							<%--						<div class="bg-default bg-primary">Order Details</div>--%>
							<table class="table table-hover table-striped">
								<tbody>
									<g:each in="${drugList}" status="i" var="drugInstance">
										<g:set var="brandName" value="${drugInstance?.brandName}"></g:set>
										<g:if test="${drugInstance?.strength}">
											<g:set var="brandName"
												value="${brandName+" "+drugInstance.strength}"></g:set>
										</g:if>
										<g:if test="${drugInstance?.form}">
											<g:set var="brandName"
												value="${brandName+" "+drugInstance.form}"></g:set>
										</g:if>

										<tr style="cursor: pointer;"
											class="${(i % 2) == 0 ? 'even' : 'odd'}"
											onclick='document.location = "<g:createLink controller="search"
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
							</table>
						</div>
					</div>
				</g:if>
							<g:else>
								<div align="center">
									<label class="control-label" style="color: red;"> <g:message code="search.result.unavailable"
										default="Medicine not found. Please try again!" /></label>
								</div>
								<%--			<g:if test="${brandId == null || brandId == "" }">--%>
								<%--			<br/><div align="center"><g:message code="search.result.inputerror" default="Tip: Select brand from auto suggestion."/></div>--%>
								<%--			</g:if>--%>
							</g:else>

			</div>
		</div>
	</div>

<br/>
</body>
</html>
