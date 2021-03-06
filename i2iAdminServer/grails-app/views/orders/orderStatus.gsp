
<%@page import="java.lang.invoke.MethodHandleNatives.Constants"%>
<%@ page import="i2i.AdminServer.Orders"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'order.status.label', default: 'Order Status')}" />
<title>Pillocate | Order Status</title>
<meta http-equiv="refresh" content="90">
<%--    <meta name="viewport" content="width=device-width, initial-scale=1">--%>
<%--    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">--%>

</head>
<body>
	<g:render template="/template/navigationConsumer" />

	<g:if test="${flash.message}">
		<div class="message" role="status" align="center">
			${flash.message}
		</div>
	</g:if>
	<g:elseif test="${orderStatusCommand?.offerCode}">
		<div class="message" align="center" style="color: white; background: #5cb85c;">
			<g:message code="orderStatus.couponCode.success.message" args="${[orderStatusCommand?.offerCode]}"/>
		</div>
		<br/>
	</g:elseif>
	<g:render template="/template/orderStatus" />

	<div class="pagination">
		<g:paginate total="${ordersInstanceCount ?: 0}" />
	</div>
	<br />
	
	<script>
		$(document).ready(function() {
			mixpanel.track("Order status page displayed");
		});
<%--		$('#reg_submit').click(function() {--%>
<%--		    $('#reg_user_name').val($('#reg_email').val());--%>
<%--		    $('#registerForm').submit();--%>
<%--		    });--%>

	</script>
</body>
</html>
