
<%@ page import="i2i.AdminServer.Store" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">

		<title><g:message message="Search" /></title>
	</head>
	<body>
		
		<div id="show-billing" class="content scaffold-show" role="main">
			<h1><g:message message="Medicine availability" /></h1>
			
			<g:form controller="search" action="search" method="get">
				<g:textField name="brandName" required="" />
				<input type="submit" value="Search">
			</g:form>
			
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="Store Name" title="Store Name" />
					
						<g:sortableColumn property="Address" title="Address" />
					
<%--						<g:sortableColumn property="Availability" title="Availability" />--%>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${storesList}" status="i" var="storeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						
						<td>
				<g:link controller="patientProfile" action="deliveryDetails" params="[storeId: '${storeInstance?.storeId }',brandId: '${brandId }']" >
						${fieldValue(bean: storeInstance, field: "storeName")}
					</g:link>
						</td>
					
						<td>${fieldValue(bean: storeInstance, field: "addressLine1")} <br>${fieldValue(bean: storeInstance, field: "addressLine2")} <br>${fieldValue(bean: storeInstance, field: "circle")}
						<br>${fieldValue(bean: storeInstance, field: "city")}<br>${fieldValue(bean: storeInstance, field: "state")}</td>
					
<%--						<td>${fieldValue(bean: storeInstance, field: "availabilityIndex")}</td>--%>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
