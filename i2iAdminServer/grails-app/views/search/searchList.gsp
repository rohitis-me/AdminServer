
<%@ page import="i2i.AdminServer.Store"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<title><g:message message="i2i-Search List" /></title>
<g:set var="entityName"
	value="${message(code: 'i2i.search.results.label', default: 'Search Results')}" />
<title><g:message message="Search results" /></title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />
	<%--<br/>--%>
	<%--	<g:set var="brandId" value="${brandId}"></g:set>--%>
	<%--	<g:set var="inventoryId" value="${inventoryId}"></g:set>--%>
	
	    <div class="container">
<%--       <h1 class="site-header">Online portal to find medicines near you </h1>--%>
       <div class="row">
	<g:render template="/template/searchBox"></g:render>

			<div class="col-md-10 col-md-offset-1">
				<g:if test="${storesList }">
					<g:if test="${!availabilityFlag }">
						<div align="center">
							<label style="color: red;"> <g:message code="search.result.unavailable"
									default="This medicine is unavailable in your local pharmacy. You could try placing an order with alternate stores below, and you will be notified if they are available." />
							</label>
						</div>
					</g:if>
					<div align="center">
						<label>
							<g:message code="search.select.store"
								default="Select a store to proceed" />
						</label>
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
												hours (subject to order acceptance by pharmacy)</td>

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
						<label style="color: red;"> <g:message code="search.result.unavailable"
							default="The stores in this area are currently offline" /></label>
					</div>
					<%--			<g:if test="${brandId == null || brandId == "" }">--%>
					<%--			<br/><div align="center"><g:message code="search.result.inputerror" default="Tip: Select brand from auto suggestion."/></div>--%>
					<%--			</g:if>--%>
				</g:else>

			</div>
		</div>
	</div>
	<br/>
	
	<script>
		$(document).ready(function() {
			mixpanel.track("Search List displayed");
		});
<%--		$('#reg_submit').click(function() {--%>
<%--		    $('#reg_user_name').val($('#reg_email').val());--%>
<%--		    $('#registerForm').submit();--%>
<%--		    });--%>

	</script>

</body>
</html>
