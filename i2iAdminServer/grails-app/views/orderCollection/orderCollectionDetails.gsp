<%@ page import="i2i.AdminServer.Constants"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'ordercollection.items.list', default: 'Order Collection Status')}" />
<title><g:message message="Pillocate | Order Details" /></title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />

	<g:if test="${flash.message}">
		<div class="message" role="status" align="center">
			${flash.message}
		</div>
	</g:if>
	<g:elseif test="${offerCode}">
		<div class="message" align="center" style="color: white; background: #5cb85c;">
			<g:message code="orderStatus.couponCode.success.message" args="${[offerCode]}"/>
		</div>
		<br/>
	</g:elseif>
	
<g:render template="/template/orderCollectionStatus" />

	<br />
</body>
</html>
