

<%@ page import="i2i.AdminServer.User.PatientProfile"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
<title><g:message code="order.delivery.details"
		default="Delivery Details" /></title>
</head>
<body>
	<g:render template="/template/navigationClient" />
<%--	<br />--%>
	<div data-role="content">
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
		<h2 style="text-align: center; color: white;">Order details</h2>
		<g:set var="quantity" value="${orderDetails?.quantity}" />
		
		<table align="center" style="border-top: 0">
			<tbody>
				<tr>
					<td style="width: 25%"><span class="label-control">Item
							Name:</span></td>
					<td><g:fieldValue class="label-control" bean="${orderDetails}"
							field="brandName" />${" "+form}${" "+strength} </td>
				</tr>
				<tr>
					<td></td>										
					<g:set var="number_units" value="${noOfUnits?.isInteger()?noOfUnits.toFloat():null}" />
					<td><g:if test="${noOfUnits!="" && !noOfUnits.contains("ml") && number_units!=null && number_units > 1}">					
							<span class="label-control">Each strip has </span>
							${noOfUnits}
							<span class="label-control"> units</span>
							<g:set var="quantity" value="${noOfUnits}" />
						</g:if> <g:elseif test="${noOfUnits!=""  && noOfUnits.contains("ml")}">
					<span class="label-control">Each unit has </span>${noOfUnits}
						</g:elseif></td>
				</tr>
				<tr>
					<td style="width: 25%"><span class="label-control">
					<g:message code="store.label.storeName" default="Store Name: "/>
					</span></td>
					<td><g:fieldValue class="label-control" bean="${orderDetails}"
							field="storeName" /></td>
				</tr>
				<tr>
					<td><span class="label-control">Quantity:</span></td>
					<td><g:field class="textbox-control" type="number" size="6"
							name="quantity" min="1" max="99999"
							value="${quantity}" /></td>
				</tr>
			</tbody>
		</table>

		<h2 style="text-align: center; color: white;">Delivery details</h2>

		<g:form controller="orders" action="saveOrder">

			<g:hiddenField name="brandId" value="${orderDetails?.brandId }" />
			<g:hiddenField name="storeId" value="${orderDetails?.storeId }" />

			<table align="center" style="border-top: 0">
				<tbody>
					<tr>
						<td style="width: 25%"><label class="label-control"
							for="name"><g:message code="patientProfile.name.label"
									default="Name:" />*</label></td>
						<td><g:textField name="name" class="textbox-control"
								title='Minimum 3 characters' pattern=".{3,}" required="required"
								maxlength="100"
								onchange="this.setCustomValidity(this.validity.patternMismatch ? this.title : '');"
								value="${orderDetails?.name}" /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="age"><g:message
									code="patientProfile.age.label" default="Age:*" /></label></td>
						<td><g:field class="textbox-control" type="number" size="6"
								name="age" min="0" max="99" required="required"
								value="${fieldValue(bean: orderDetails, field: 'age')}" /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="phoneNumber"><g:message
									code="patientProfile.phoneNumber.label" default="Phone:" />*</label></td>
						<td><g:field type="tel" name="phoneNumber"
								class="textbox-control" value="${orderDetails?.phoneNumber}"
								pattern=".{3,}" required="required" maxlength="100"
								title='Enter valid phone number' /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="emailID"><g:message
									code="patientProfile.emailID.label" default="Email ID" /></label></td>
						<td><g:field class="textbox-control" name="emailID"
								type="email" maxlength="100" value="${orderDetails?.emailID}" /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="address">Address
								Line1:*</label></td>
						<td><g:textField class="textbox-control" name="addressLine1"
								value="${orderDetails?.addressLine1}" pattern=".{3,}"
								required="required" maxlength="100" title='Minimum 3 characters' /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="landmark">Address
								Line2:*</label></td>
						<td><g:textField class="textbox-control" name="addressLine2"
								value="${orderDetails?.addressLine2}" pattern=".{3,}"
								required="required" maxlength="100" title='Minimum 3 characters' /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="landmark">Circle
						</label></td>
						<td><g:hiddenField name="circle"
								value="${orderDetails?.circle }" /> ${orderDetails?.circle }</td>
					</tr>
					<tr>
						<td><label class="label-control" for="city">City </label></td>
						<td><g:hiddenField name="city" value="${orderDetails?.city }" />
							${orderDetails?.city }</td>
					</tr>
					<tr>
						<td><label class="label-control" for="state">State </label></td>
						<td><g:hiddenField name="state"
								value="${orderDetails?.state }" /> ${orderDetails?.state }</td>
					</tr>
					<tr>
						<td><label class="label-control" for="country">Country
						</label></td>
						<td><g:hiddenField name="country"
								value="${orderDetails?.country }" /> ${orderDetails?.country }</td>
					</tr>

					<%--					<tr>--%>
					<%--						<td style="width: 15%"><label class="label-control" for="pin">Pin--%>
					<%--								code </label></td>--%>
					<%--						<td><input name="pin" type="text" required--%>
					<%--							class="textbox-control" id="textfield"></td>--%>
					<%--					</tr>--%>
				</tbody>
			</table>

			<div class="end" align="center">
				<label class="label-control" for="textfield">Payment Method:
				</label> <label class="label-control" for="textfield">Cash on
					delivery</label> <br /> <br />
				<g:submitButton name="create"
					value="${message(code: 'default.button.submit.label', default: 'Submit')}"
					class="btn btn-default" />
			</div>
		</g:form>
	</div>
	<br />
</body>
</html>
