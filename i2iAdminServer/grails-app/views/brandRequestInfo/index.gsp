
<%@ page import="i2i.AdminServer.User.BrandRequestInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'brandRequestInfo.label', default: 'Request Medicine')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<g:render template="/template/navigationConsumer" />
	<%--<br/>--%>

	<div class="container">
		<div class="row">
			<g:render template="/template/searchBox"></g:render>

			<div class="col-md-10 col-md-offset-1">

				<g:if test="${flash.message}">
				<br/>
				<br/>
					<div align="center" class="message" role="status">
						<p>${flash.message}</p>
					</div>
				</g:if>
				<g:else>
					<div align="center">
						<label style="color: red;"> <g:message
								code="search.result.unavailable"
								default="Medicine not available. Please enter your contact details below, and we will get back to you as soon as they are available" /></label>
					</div>

					<g:form controller="brandRequestInfo" action="requestNewBrand">
						<div class="form-horizontal">
							<div class="panel panel-default order-panel">
								<%--                  <div class="panel-heading text-center">Feedback</div>--%>
								<div class="panel-body">
									<%--                    <div class="alert alert-default">Have a complaint, suggestion or query? Write to us</div>--%>
									<g:hiddenField name="circle" value="${command?.circle }" />

									<div class="form-group">
										<label for="inputEmail3" class="col-sm-4 control-label"><span
											class="text-danger">*</span> Medicine Name : </label>
										<div class="col-sm-7">
											<input name="brandName" class="form-control"
												placeholder="Medicine Name" type="text" required="required"
												maxlength="100" value="${command?.brandName}"/>
										</div>
									</div>


									<div class="form-group">
										<label for="inputEmail3" class="col-sm-4 control-label"><span
											class="text-danger"></span> Email-Id : </label>
										<div class="col-sm-7">
											<input class="form-control" placeholder="Email id"
												name="emailID" type="email" maxlength="100"
												value="${command?.emailID}" />
											
											<label for="inputEmail3" class="col-sm-4 control-label">
												(OR) </label>
										</div>


									</div>
									<div class="form-group">
										<label for="inputEmail3" class="col-sm-4 control-label"><span
											class="text-danger"></span> Phone : </label>
										<div class="col-sm-7">
											<input class="form-control" placeholder="Phone No."
												type="tel" name="phoneNumber" pattern=".{3,}"
												maxlength="100" title='Enter valid phone number'
												value="${command?.phoneNumber}" />
										<g:if test="${showError}">
										<g:hasErrors bean="${command}" field="emailID">
												<g:eachError bean="${command}" field="emailID">
													<p style="color: red;">
														<g:message error="${it}" />
													</p>
												</g:eachError>
											</g:hasErrors>
											</g:if>
										</div>
									</div>
								</div>
								<div class="panel-footer clearfix">
									<div class="row">
										<div class="col-sm-offset-4 col-xs-12 col-sm-3">
											<button type="submit" class="btn btn-primary btn-block">
												<i class="glyphicon glyphicon-ok"></i>&nbsp; Submit
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</g:form>
				</g:else>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			mixpanel.track("Clicked Feedback link");
		});
	</script>
</body>
</html>
