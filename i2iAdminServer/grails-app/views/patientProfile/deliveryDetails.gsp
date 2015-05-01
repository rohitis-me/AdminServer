

<%@ page import="i2i.AdminServer.User.PatientProfile"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
<title><g:message code="title.brand.tag"/> | <g:message code="title.page.deliverydetails"/></title>
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
					<g:set var="quantity" value="${orderDetails?.quantity}" />
					<g:hiddenField name="brandName" value="${orderDetails.brandName}" />
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<div class="panel-heading">Order details</div>
							<div class="panel-body">
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Item
										Name :</label>

									<div class="col-sm-8">
										<label class="order-info"> <g:fieldValue
												bean="${orderDetails}" field="brandName" /> <g:if
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
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Store
										Name :</label>
									<div class="col-sm-8">
										<label class="order-info">
											${storeName}
										</label>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Quantity
										:</label>
									<div class="col-sm-7">
										<input class="form-control" placeholder="Quantity"
											type="number" size="6" name="quantity" min="1" max="99999"
											value="${quantity}">
										<g:hasErrors bean="${orderDetails}" field="quantity">
											<g:eachError bean="${orderDetails}" field="quantity">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
							</div>
							<div class="bg-default">Delivery details</div>

							<g:hiddenField name="brandId" value="${orderDetails?.brandId }" />
							<g:hiddenField name="inventoryId"
								value="${orderDetails?.inventoryId }" />
							<g:hiddenField name="storeId" value="${orderDetails?.storeId }" />
							<g:hiddenField name="deliveryHours"
								value="${orderDetails?.deliveryHours }" />

							<div class="panel-body">
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger">*</span> Name : </label>
									<div class="col-sm-7">
										<input class="form-control" name="name"
											placeholder="Full Name" type="text"
											title='Minimum 3 characters' pattern=".{3,}"
											required="required" maxlength="100"
											onchange="this.setCustomValidity(this.validity.patternMismatch ? this.title : '');"
											value="${orderDetails?.name}">
										<g:hasErrors bean="${orderDetails}" field="name">
											<g:eachError bean="${orderDetails}" field="name">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger">*</span> Age : </label>
									<div class="col-sm-7">
										<input class="form-control" placeholder="Age" type="number"
											size="6" name="age" min="0" max="99" required="required"
											value="${fieldValue(bean: orderDetails, field: 'age')}">
										<g:hasErrors bean="${orderDetails}" field="age">
											<g:eachError bean="${orderDetails}" field="age">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">
										<span class="text-danger">*</span> Phone :
									</label>
									<div class="col-sm-7">
										<input class="form-control" placeholder="Phone No." type="tel"
											name="phoneNumber" value="${orderDetails?.phoneNumber}"
											pattern=".{3,}" required="required" maxlength="100"
											title='Enter valid phone number'>
										<g:hasErrors bean="${orderDetails}" field="phoneNumber">
											<g:eachError bean="${orderDetails}" field="phoneNumber">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger">*</span> Email Id : </label>
									<div class="col-sm-7">
										<input class="form-control" placeholder="Email id"
											name="emailID" type="email" maxlength="100"
											value="${orderDetails?.emailID}" />
										<g:message code="patientProfile.email.helptext" />
										<g:hasErrors bean="${orderDetails}" field="emailID">
											<g:eachError bean="${orderDetails}" field="emailID">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger">*</span> Address : </label>
									<div class="col-sm-7">
										<input class="form-control" placeholder="Your's Address"
											name="addressLine1" value="${orderDetails?.addressLine1}"
											pattern=".{3,}" required="required" maxlength="100"
											title='Minimum 3 characters' />
										<g:hasErrors bean="${orderDetails}" field="addressLine1">
											<g:eachError bean="${orderDetails}" field="addressLine1">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"></label>
									<div class="col-sm-7">
										<input class="form-control" name="addressLine2"
											value="${orderDetails?.addressLine2}" pattern=".{3,}"
											required="required" maxlength="100"
											title='Minimum 3 characters' />
										<g:hasErrors bean="${orderDetails}" field="addressLine2">
											<g:eachError bean="${orderDetails}" field="addressLine2">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Circle
										:</label>
									<div class="col-sm-8">
										<label class="order-info"><g:hiddenField name="circle"
												value="${orderDetails?.circle }" /> ${orderDetails?.circle }
											(Delivery restricted to this area)</label>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">City
										:</label>
									<div class="col-sm-8">
										<label class="order-info"><g:hiddenField name="city"
												value="${orderDetails?.city }" /> ${orderDetails?.city }</label>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">State
										:</label>
									<div class="col-sm-8">
										<label class="order-info"><g:hiddenField name="state"
												value="${orderDetails?.state }" /> ${orderDetails?.state }</label>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Country
										:</label>
									<div class="col-sm-8">
										<label class="order-info"><g:hiddenField
												name="country" value="${orderDetails?.country }" /> ${orderDetails?.country }</label>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label">Payment
										Method :</label>
									<div class="col-sm-8">
										<label class="order-info">Cash on delivery</label>
									</div>
								</div>
							</div>
							<%--					<g:if test="${isEmergencyDeliveryAvailable}">--%>
							<%--						<tr>--%>
							<%--							<td></td>--%>
							<%--							<td><g:checkBox name="isEmergencyDeliveryNeeded" class='chk'--%>
							<%--									id='emergency_delivery'--%>
							<%--									value="${orderDetails?.isEmergencyDeliveryNeeded}" /> <label--%>
							<%--								class="label-control" for='emergency_delivery'><g:message--%>
							<%--										code="order.emergency.delivery.label"--%>
							<%--										default="Request Emergency delivery" /></label></td>--%>
							<%--						</tr>--%>

							<div class="bg-default text-center">
								<h5>
									<span class="text-danger"><g:message
											code="order.prescription.message" /></span>
								</h5>
							</div>
							<div class="panel-footer clearfix">
								<div class="col-sm-offset-3 col-xs-6 col-sm-3">
									<button type="submit" class="btn btn-primary btn-block"
										onclick="return confirm('${message(code: 'order.confirm.message')}');">
										<i class="glyphicon glyphicon-ok"></i>&nbsp; Submit
									</button>
								</div>
								<div class="col-xs-6 col-sm-3">
									<button type="button" class="btn btn-success btn-block"
										onclick="history.go(-1);return true;">
										<i class="glyphicon glyphicon-menu-left"></i> Go Back
									</button>
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
