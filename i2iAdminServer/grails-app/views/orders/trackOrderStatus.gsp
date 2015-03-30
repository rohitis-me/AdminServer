
<%@page import="java.lang.invoke.MethodHandleNatives.Constants"%>
<%@ page import="i2i.AdminServer.Orders"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'track.order.status.label', default: 'TrackOrder')}" />
<title><g:message message="Track Order" /></title>
</head>

<body>
	<g:render template="/template/navigationClient" />
	<br />

	<g:form controller="orders" action="showTrackedOrderDetails"
		method="get">
		<div align="center">
			<input name="trackingId" required class="textbox-control"
				placeholder="Enter tracking id" style="width: 40%;"
				value="${trackingId}" />
			<input type="submit" name="searchButton" value="Track order"
				class="btn btn-default" style="width: 20%; height: 33px" />
		</div>
	</g:form>
	
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:if test="${orderStatusCommand }">
			<g:render template="/template/orderStatus" />
	</g:if>
	<g:elseif test="${trackingId}">
		<br/><div align="center">
			<g:message code="invalid.order.trackingid"
				default="Invalid Tracking ID" />
		</div>
	</g:elseif>

	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
	<br />
</body>
</html>
