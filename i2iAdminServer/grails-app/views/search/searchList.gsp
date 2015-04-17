
<%@ page import="i2i.AdminServer.Store"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<title><g:message message="i2i-Search List" /></title>
<g:set var="entityName"
	value="${message(code: 'i2i.search.results.label', default: 'Search Results')}" />
<title><g:message message="Search results" /></title>
<%--<style type="text/css">--%>
<%--/* TABLES */--%>
<%--table {--%>
<%--	border: 1px solid #DFDFDF;--%>
<%--	border-collapse: collapse;--%>
<%--	width: 60%;--%>
<%--	margin-bottom: 1em;--%>
<%--}--%>
<%----%>
<%--tr {--%>
<%--	border: 0;--%>
<%--	font-weight: normal;--%>
<%--	border-bottom: 1px solid #DFDFDF;--%>
<%--}--%>
<%----%>
<%--tr>td:first-child,tr>th:first-child {--%>
<%--	padding-left: 1.25em;--%>
<%--}--%>
<%----%>
<%--tr>td:last-child,tr>th:last-child {--%>
<%--	padding-right: 1.25em;--%>
<%--}--%>
<%----%>
<%--td,th {--%>
<%--	line-height: 1.5em;--%>
<%--	padding: 0.5em 0.6em;--%>
<%--	text-align: left;--%>
<%--	vertical-align: top;--%>
<%--}--%>
<%----%>
<%--th {--%>
<%--	background-color: #efefef;--%>
<%--	color: #666666;--%>
<%--	font-weight: bold;--%>
<%--	line-height: 1.7em;--%>
<%--	padding: 0.2em 0.6em;--%>
<%--}--%>
<%----%>
<%--thead th {--%>
<%--	white-space: nowrap;--%>
<%--}--%>
<%----%>
<%--th a {--%>
<%--	display: block;--%>
<%--	text-decoration: none;--%>
<%--}--%>
<%----%>
<%--th a:hover,th a:focus {--%>
<%--	color: #333333;--%>
<%--}--%>
<%----%>
<%--th.sortable a {--%>
<%--	background-position: right;--%>
<%--	background-repeat: no-repeat;--%>
<%--	padding-right: 1.1em;--%>
<%--}--%>
<%----%>
<%--th.asc a {--%>
<%--	background-image: url(../images/skin/sorted_asc.gif);--%>
<%--}--%>
<%----%>
<%--th.desc a {--%>
<%--	background-image: url(../images/skin/sorted_desc.gif);--%>
<%--}--%>
<%----%>
<%--.odd {--%>
<%--	background: #f5f5f5;--%>
<%--}--%>
<%----%>
<%--.odd:hover {--%>
<%--	background: #ffffff;--%>
<%--}--%>
<%----%>
<%--.even {--%>
<%--	background: #ffffff;--%>
<%--}--%>
<%----%>
<%--.even:hover {--%>
<%--	background: #f5f5f5;--%>
<%--}--%>
<%----%>
<%--.label-control {--%>
<%--	position: relative;--%>
<%--	text-align: right;--%>
<%--}--%>
<%--</style>--%>
</head>
<body>
	<g:render template="/template/navigationConsumer" />
	<%--<br/>--%>
	<%--	<g:set var="brandId" value="${brandId}"></g:set>--%>
	<%--	<g:set var="inventoryId" value="${inventoryId}"></g:set>--%>
	<g:render template="/template/searchBox"></g:render>


	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<g:if test="${storesList }">
					<g:if test="${!availabilityFlag }">
						<div align="center">
							<i> <g:message code="search.result.unavailable"
									default="Currently unavailable. You could place an order under the following stores." />
							</i>
						</div>
					</g:if>
					<div align="center">
						<p>
							<g:message code="search.select.store"
								default="Select a store to proceed" />
						</p>
					</div>
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<%--						<div class="panel-heading">Order Status</div>--%>
							<%--						<div class="bg-default bg-primary">Order Details</div>--%>
							<table class="table table-hover table-striped">
								<thead class="bg-default bg-primary">
									<tr>
										<th>Store Name</th>
										<th>Remarks</th>
									</tr>
								</thead>
								<tbody>
									<g:each in="${storesList}" status="i" var="storeInstance">
										<g:set var="storeId" value="${storeInstance?.storeId}"></g:set>
										<g:if test="${availabilityFlag }">
											<g:set var="deliveryHours"
												value="${storeInstance?.deliveryHoursIfAvailable}"></g:set>
										</g:if>
										<g:else>
											<g:set var="deliveryHours"
												value="${storeInstance?.deliveryHoursIfUnavailable}"></g:set>
										</g:else>

										<tr style="cursor: pointer;"
											class="${(i % 2) == 0 ? 'even' : 'odd'}"
											onclick='document.location = "<g:createLink controller="patientProfile"
					action="deliveryDetails"
					params="[storeId: storeId, brandId: brandId, inventoryId:inventoryId, circle: circle, deliveryHours:deliveryHours]"/>" '>


											<td>
												${fieldValue(bean: storeInstance, field: "storeName")}<br>
												<%--							${fieldValue(bean: storeInstance, field: "addressLine1")} <br>--%>
												<%--						${fieldValue(bean: storeInstance, field: "addressLine2")} <br>--%>
												<%--						${fieldValue(bean: storeInstance, field: "circle")}, ${fieldValue(bean: storeInstance, field: "city")}--%>
											</td>

											<td><span style="color: #B0CF36"><g:message
														code="search.list.homedelivery"
														message="Home Delivery Available" /></span><br> <g:message
													code="search.list.etd" message="Delivery in: " /> ${deliveryHours}
												hours</td>

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
						<g:message code="search.result.unavailable"
							default="The stores in this area are currently offline" />
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
