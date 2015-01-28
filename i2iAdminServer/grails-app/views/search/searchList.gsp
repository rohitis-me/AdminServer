
<%@ page import="i2i.AdminServer.Store" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="searchLayout">

		<title><g:message message="i2i-Search List" /></title>
	</head>
	<body>
		<g:set var="brandId" value="${brandId}"></g:set>
		<g:form controller="search" action="search" method="get">
			<g:textField name="brandName" value="${brandName}" required="" class="textbox-control" id="TextBox1" style="width: 50%; position: relative; left: 15%;" />
			<input type="submit" name="Button1" value="Search" id="Button1" class="btn btn-default" style="height: 44px; width: 20%; left:15%" />
		</g:form>
			<br/><br/>
			<table align="center">
			<thead>
					<tr>
						<g:sortableColumn property="Store Name" title="Store Name" />
					
						<g:sortableColumn property="Address" title="Address" />
					
<%--						<g:sortableColumn property="Availability" title="Availability" />--%>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${storesList}" status="i" var="storeInstance">
				<g:set var="storeId" value="${storeInstance?.storeId}"></g:set>
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						
						<td>
				<g:link controller="patientProfile" action="deliveryDetails" params="[storeId: storeId, brandId: brandId]" >
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
