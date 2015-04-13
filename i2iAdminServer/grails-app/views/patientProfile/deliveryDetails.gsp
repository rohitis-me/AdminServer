

<%@ page import="i2i.AdminServer.User.PatientProfile"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
<title>pillocate | delivery-details</title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />
	<%--	<br />--%>
<%--	<div data-role="content">--%>
		<g:if test="${flash.message}">
			<div class="message" role="alert">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${orderDetails}">
			<div class="errors" role="alert">
				<g:renderErrors bean="${orderDetails}" as="list" />
			</div>
		</g:hasErrors>

<div class="container">
      <div class="row">
        <div class="col-md-8 col-md-offset-2">
          <g:form controller="orders" action="saveOrder">
            <div class="form-horizontal">
              <div class="panel panel-default order-panel">
                  <div class="panel-heading">Order details</div>
                    <div class="panel-body">
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">Item Name :</label>
                        <g:hiddenField name="brandName" value="${orderDetails.brandName}" />
                        <div class="col-sm-8">
                        <g:fieldValue class="order-info"
								bean="${orderDetails}" field="brandName" /> <g:if
								test="${brandData?.form}">
								${" "+brandData.form}
							</g:if> <g:if test="${brandData?.strength}">
								${" "+brandData.strength}
							</g:if>
                        </div>
                        <div class="col-sm-8">
						<g:set var="number_units"
							value="${brandData?.noOfUnits?.isInteger()?brandData.noOfUnits.toFloat():null}" />
						<g:if
								test="${brandData?.noOfUnits && !brandData.noOfUnits?.contains("ml") && number_units && number_units > 1}">
								<span class="order-info">Each strip has </span>
								${brandData?.noOfUnits}
								<span class="order-info"> units</span>
								<g:set var="quantity" value="${brandData?.noOfUnits}" />
							</g:if> <g:elseif
								test="${brandData?.noOfUnits  && brandData.noOfUnits?.contains("ml")}">
								<span class="order-info">Each unit has </span>
								${brandData.noOfUnits}
							</g:elseif>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">Store Name :</label>
                        <div class="col-sm-7">
                          <input class="form-control" id="inputEmail3" placeholder="Store Name" type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">Quantity :</label>
                        <div class="col-sm-7">
                          <input class="form-control" id="inputEmail3" placeholder="Quantity" type="text">
                        </div>
                      </div>
                     </div>
            		<div class="bg-default">Delivery details</div>
                    <div class="panel-body">
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger">*</span> Name : </label>
                        <div class="col-sm-7">
                          <input class="form-control" id="inputEmail3" placeholder="Full Name" type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger">*</span> Age : </label>
                        <div class="col-sm-7">
                          <input class="form-control" id="inputEmail3" placeholder="Age" type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"> <span class="text-danger">*</span> Phone :</label>
                        <div class="col-sm-7">
                          <input class="form-control" id="inputEmail3" placeholder="Phone No." type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger">*</span> Email Id : </label>
                        <div class="col-sm-7">
                          <input class="form-control" id="inputEmail3" placeholder="Email id" type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger">*</span> Address : </label>
                        <div class="col-sm-7">
                        <textarea class="form-control" id="inputEmail3" placeholder="Your's Address"></textarea>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">Circle :</label>
                        <div class="col-sm-8">
                          <label class="order-info">Thiruvanmiyur (Delivery restricted to this area)</label>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">City :</label>
                        <div class="col-sm-8">
                          <label class="order-info">Chennai</label>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">State :</label>
                        <div class="col-sm-8">
                          <label class="order-info">Tamil Nadu</label>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">Country :</label>
                        <div class="col-sm-8">
                          <label class="order-info">India</label>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">Payment Method :</label>
                        <div class="col-sm-8">
                          <label class="order-info">Cash on delivery</label>
                        </div>
                      </div>
                     </div>
                     <div class="bg-default text-center"><h5><span class="text-danger">Please note</span>, the pharmacist may ask for a valid prescription at the time of delivery.</h5></div>
                    <div class="panel-footer clearfix">
                       <div class="col-sm-offset-3 col-xs-6 col-sm-3">
                        <button type="submit" class="btn btn-primary btn-block"><i class="glyphicon glyphicon-ok"></i>&nbsp; Submit</button>
                       </div>
                       <div class="col-xs-6 col-sm-3">
                        <button type="button" class="btn btn-success btn-block"><i class="glyphicon glyphicon-menu-left"></i> Go Back</button>
                       </div>
                    </div>
               </div>
           </div>
        </g:form>
        </div> 
      </div>
    </div>

		
</body>
</html>
