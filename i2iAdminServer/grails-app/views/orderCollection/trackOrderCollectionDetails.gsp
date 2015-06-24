<%@ page import="i2i.AdminServer.Constants"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'ordercollection.items.list', default: 'Order Collection Status')}" />
<title><g:message code="title.brand.tag" /> | <g:message message="Track Order" /></title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />

    <div class="container">
      <div class="row">
        <div class="col-md-10 col-md-offset-1">
          <g:form controller="orderCollection" action="showTrackedOrderDetails"
		method="get">        
          <div class="form-group">
            <div class="col-sm-12">
            <div class="order-input-icon">
                <input name="trackingId" required class="form-control input-lg" placeholder="Enter tracking id..." type="text" value="${trackingId}">
                <input class="order-input-search" name="searchButton" value="Track order" type="submit">
            </div>
            </div>
          </div>
        </g:form>	
        </div> 
      </div>
    </div>
    
	<br/>
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:if test="${orderDetailsList }">
			<g:render template="/template/orderCollectionStatus" />
	</g:if>
	<g:elseif test="${trackingId}">
		<br/><div align="center">
			<g:message code="invalid.order.trackingid"
				default="Invalid Tracking ID" />
		</div>
	</g:elseif>
	<br />
</body>
</html>
