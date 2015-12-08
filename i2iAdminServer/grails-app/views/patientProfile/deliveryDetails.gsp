
<%@ page import="i2i.AdminServer.Constants"%>
<%@ page import="i2i.AdminServer.User.PatientProfile"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
<title><g:message code="title.brand.tag" /> | <g:message
		code="title.page.deliverydetails" /></title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />
	<%--	<br />--%>
	<%--	<div data-role="content">--%>
	<g:if test="${flash.message}">
		<div class="message" align="center" role="alert">
			<p style="color: red;">${flash.message}</p>
		</div>
	</g:if>
	<g:hasErrors bean="${orderDetails}">
		<div class="errors" role="alert">
			<g:renderErrors bean="${orderDetails}" as="list" />
		</div>
	</g:hasErrors>

	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<g:form controller="orderCollection" action="saveOrderItems">
<%--					<g:set var="quantity" value="${orderDetails?.quantity}" />--%>
<%--					<g:hiddenField name="brandName" value="${orderDetails?.brandName}" />--%>
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
						<div class="panel-heading">Delivery Details</div>
							<g:hiddenField name="attachmentId" value="${attachmentId}" />
							<g:hiddenField name="city" value="${orderDetails?.city }" />
							<g:hiddenField name="state" value="${orderDetails?.state }" />
							<g:hiddenField name="country" value="${orderDetails?.country }" />

							<div class="panel-body">
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger">*</span> Patient Name : </label>
									<div class="col-sm-7">
										<input class="form-control" name="patientName"
											placeholder="Patient Name" type="text"
											title='Minimum 3 characters' pattern=".{3,}"
											required="required" maxlength="100"
											onchange="this.setCustomValidity(this.validity.patternMismatch ? this.title : '');"
											value="${orderDetails?.patientName}">
										<g:hasErrors bean="${orderDetails}" field="patientName">
											<g:eachError bean="${orderDetails}" field="patientName">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger"></span> Doctor Name : </label>
									<div class="col-sm-7">
										<input class="form-control" name="doctorName"
											placeholder="Doctor Name" type="text"
											title='Minimum 3 characters' pattern=".{3,}"
											maxlength="100"
											onchange="this.setCustomValidity(this.validity.patternMismatch ? this.title : '');"
											value="${orderDetails?.doctorName}">
										<g:hasErrors bean="${orderDetails}" field="doctorName">
											<g:eachError bean="${orderDetails}" field="doctorName">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
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
											maxlength="100"
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
												value="${orderDetails?.circle }" /> ${orderDetails?.circle }</label>
											<p style="color: red;">(Delivery restricted to this area)</p>
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
										class="text-danger"></span> Email Id : </label>
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
									<label for="inputEmail3" class="col-sm-4 control-label">Payment
										Method :</label>
									<div class="col-sm-8">
										<label class="order-info">Cash on delivery</label>
									</div>
								</div>
								<div class="form-group">
									<g:form id='coupon_code' name="offerForm"
										controller="patientProfile">
										<label for="offerCode" class="col-sm-4 control-label">Offer
											code :</label>
										<div class="col-sm-7">
											<div class="order-input-icon">
												<input id="offercode_input" class="form-control"
													name="offerCode" placeholder="Enter offer code" type="text"
													maxlength="100" value="${orderDetails?.offerCode}">
												<g:submitToRemote class="coupon-code-input" update="offerCodeFeedback"
													action="isValidOfferCode" value="Apply"/>
											</div>
											<div id="offerCodeFeedback" style="color: blue;"></div>
										</div>
									</g:form>
								</div>
								
<%--								<div class="form-group">--%>
<%--									<label for="inputEmail3" class="col-sm-4 control-label"><input--%>
<%--										class="grey remember" type="checkbox" required="required"/></label>--%>
<%--									<div class="col-sm-8">--%>
<%--										<label class="order-info">   I accept <a href="${createLink(uri:'/termsConditions')}">Terms &amp; Conditions</a></label>--%>
<%--									</div>--%>
<%--								</div>--%>
			</div>
									
								<div class="bg-default text-center">
									<h5>
										<span class="text-danger"><g:message
												code="order.prescription.message" /></span>
									</h5>
<%--								</div>--%>
<%--								<div class="bg-default text-center">--%>
									<h5><span class="text-danger"><input
										class="grey remember" type="checkbox" required="required"/>&nbsp;&nbsp;&nbsp;I accept <a href="${createLink(uri:'/termsConditions')}">Terms &amp; Conditions</a></span></h5>
<%--									</div>--%>
								</div>
								<div class="panel-footer clearfix">
									<div class="col-sm-offset-3 col-xs-6 col-sm-3">
										<button id="order_submit" type="submit" class="btn btn-primary btn-block"
											onclick="return confirm('${message(code: 'order.confirm.message')}');">
											<i class="glyphicon glyphicon-ok"></i>&nbsp; Submit
										</button>
									</div>
									<div class="col-xs-6 col-sm-3">
										<button id="go_back" type="button" class="btn btn-success btn-block"
											onclick="history.go(-1);return true;">
											<i class="glyphicon glyphicon-menu-left"></i> Go Back
										</button>
									</div>
								</div>
</div></div>
				</g:form>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			mixpanel.track("Delivery details displayed");
		});
		$('#order_submit').click(function() {
			mixpanel.track("Order details submitted");
		    });
		$('#go_back').click(function() {
			mixpanel.track("Go back from Order details");
		    });
	</script>
	
	<script type="text/javascript">
	$(document).ready(function(){
	    $('#order_submit').click(function() {
	        $('#spinner').show();
	    });
	});
</script>
</body>
</html>
