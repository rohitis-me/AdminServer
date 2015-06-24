
<%@ page import="i2i.AdminServer.Store"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'i2i.search.results.label', default: 'Search Results')}" />
<title><g:message code="title.brand.tag" /> | <g:message message="Search Result" /></title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />

	
	    <div class="container">
       <div class="row">
	<g:render template="/template/searchBox"></g:render>
<br/>
        <div class="col-md-10 col-md-offset-1">
          <g:form controller="shoppingCart" action="addItemToCart" method="PUT">
<%--          <g:formRemote name="subForm" url="[controller:'shoppingCart', action:'addItemToCart']" update="disableSubmit">--%>
          
          <g:hiddenField name="storeId"	value="${storeId}" />
          <g:hiddenField name="brandId" value="${brandId}" />
          <g:hiddenField name="inventoryId" value="${inventoryId}" />
          <g:hiddenField name="circle" value="${circle}" />
          <g:hiddenField name="brandName" value="${brandName}" />
           
            <div class="form-horizontal">
              <div class="panel panel-default order-panel">
<%--                  <div class="panel-heading text-center">Feedback</div>--%>
                    <div class="panel-body">
<%--                    <div class="alert alert-default">Have a complaint, suggestion or query? Write to us</div>--%>
                      <div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Medicine Name :</label>

									<div class="col-sm-8">
										<label class="order-info"> ${brandName} <g:if
												test="${brandData?.form}">
												${" "+brandData.form}
											</g:if> <g:if test="${brandData?.strength}">
												${" "+brandData.strength}
											</g:if></label>
									</div>
									<label for="inputEmail3" class="col-sm-4 control-label"></label>
									<div class="col-sm-8">
										<g:set var="number_units"
											value="${brandData?.noOfUnits?.isInteger()?brandData.noOfUnits.toFloat():null}" />
										<g:if
											test="${brandData?.noOfUnits && !brandData.noOfUnits?.contains("ml") && number_units && number_units > 1}">
											<span class="order-info">Each strip has </span>
											${brandData?.noOfUnits}
											<span class="order-info"> units</span>
											<g:set var="quantity" value="${brandData?.noOfUnits}" />
										</g:if>
										<g:elseif
											test="${brandData?.noOfUnits  && brandData.noOfUnits?.contains("ml")}">
											<span class="order-info">Each unit has </span>
											${brandData.noOfUnits}
										</g:elseif>
									</div>
                      </div>
                      <div class="form-group" align="center">
                      <label for="inputEmail3" class="col-sm-4 control-label"><span style="color: #B0CF36"><g:message
														code="search.list.homedelivery"
														message="Home Delivery Available" /></span></label>
                      
					</div>
						<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Quantity
										:</label>
									<div class="col-sm-7">
										<input class="form-control" placeholder="Quantity"
											type="number" size="6" name="quantity" min="1" max="99999"
											value="${quantity}">
									</div>
						</div>
															
                     </div>
                    <div class="panel-footer clearfix">
                       <div class="col-sm-offset-3 col-xs-6 col-sm-3" id="disableSubmit">
                       <g:if test="${disableAdd == '1' }">
                       <button type="submit" disabled class="btn btn-primary btn-block"><i class="glyphicon glyphicon-plus"></i>&nbsp; Add To Cart</button>
                       </g:if>
                       <g:else>
                        <button type="submit" class="btn btn-primary btn-block"><i class="glyphicon glyphicon-plus"></i>&nbsp; Add To Cart</button>
                       </g:else>
                       </div>
                   	<div class="col-xs-6 col-sm-3">
						<button type="submit" name="placeOrderNow" class="btn btn-success btn-block">
							<i class="glyphicon glyphicon-ok"></i> Buy Now
						</button>
					</div>
                    </div>
               </div>
           </div>
<%--           </g:formRemote>--%>
        </g:form>
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
