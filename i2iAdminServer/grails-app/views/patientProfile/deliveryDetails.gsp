

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
	<g:render template="/template/navigationConsumer" />
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

		<g:form controller="orders" action="saveOrder">

			<h2 style="text-align: center; color: white;">Order details</h2>
			<g:set var="quantity" value="${orderDetails?.quantity}" />

			<table align="center" style="border-top: 0">
				<tbody>
					<tr>
						<td style="width: 25%"><span class="label-control">Item
								Name:</span></td>
						<g:hiddenField name="brandName" value="${orderDetails.brandName}" />
						<td><g:fieldValue class="label-control"
								bean="${orderDetails}" field="brandName" /> <g:if
								test="${brandData?.form}">
								${" "+brandData.form}
							</g:if> <g:if test="${brandData?.strength}">
								${" "+brandData.strength}
							</g:if></td>
					</tr>
					<tr>
						<td></td>
						<g:set var="number_units"
							value="${brandData?.noOfUnits?.isInteger()?brandData.noOfUnits.toFloat():null}" />
						<td><g:if
								test="${brandData?.noOfUnits && !brandData.noOfUnits?.contains("ml") && number_units && number_units > 1}">
								<span class="label-control">Each strip has </span>
								${brandData?.noOfUnits}
								<span class="label-control"> units</span>
								<g:set var="quantity" value="${brandData?.noOfUnits}" />
							</g:if> <g:elseif
								test="${brandData?.noOfUnits  && brandData.noOfUnits?.contains("ml")}">
								<span class="label-control">Each unit has </span>
								${brandData.noOfUnits}
							</g:elseif></td>
					</tr>
					<tr>
						<td style="width: 25%"><span class="label-control"> <g:message
									code="store.label.storeName" default="Store Name: " />
						</span></td>
						<td><span class="label-control">
								${storeName}
						</span></td>
					</tr>
					<tr>
						<td><span class="label-control">Quantity:</span></td>
						<td><g:field class="textbox-control" type="number" size="6"
								name="quantity" min="1" max="99999" value="${quantity}" /></td>
					</tr>
				</tbody>
			</table>

			<h2 style="text-align: center; color: white;">Delivery details</h2>

			<g:hiddenField name="brandId" value="${orderDetails?.brandId }" />
			<g:hiddenField name="inventoryId"
				value="${orderDetails?.inventoryId }" />
			<g:hiddenField name="storeId" value="${orderDetails?.storeId }" />
			<g:hiddenField name="deliveryHours"
				value="${orderDetails?.deliveryHours }" />

			<table align="center" style="border-top: 0">
				<tbody>
					<tr>
						<td style="width: 25%"><label class="label-control"
							for="name"><g:message code="patientProfile.name.label"
									default="Name: " />*</label></td>
						<td><g:textField name="name" class="textbox-control"
								title='Minimum 3 characters' pattern=".{3,}" required="required"
								maxlength="100"
								onchange="this.setCustomValidity(this.validity.patternMismatch ? this.title : '');"
								value="${orderDetails?.name}" /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="age"><g:message
									code="patientProfile.age.label" default="Age: *" /></label></td>
						<td><g:field class="textbox-control" type="number" size="6"
								name="age" min="0" max="99" required="required"
								value="${fieldValue(bean: orderDetails, field: 'age')}" /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="phoneNumber"><g:message
									code="patientProfile.phoneNumber.label" default="Phone: " />*</label></td>
						<td><g:field type="tel" name="phoneNumber"
								class="textbox-control" value="${orderDetails?.phoneNumber}"
								pattern=".{3,}" required="required" maxlength="100"
								title='Enter valid phone number' /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="emailID"><g:message
									code="patientProfile.emailID.label" default="Email Id:" /></label></td>
						<td><g:field class="textbox-control" name="emailID"
								type="email" maxlength="100" value="${orderDetails?.emailID}" />
								<g:message code="patientProfile.email.helptext"/></td>
					</tr>
					
					<tr>
						<td><label class="label-control" for="address">Address:
								*</label></td>
						<td><g:textField class="textbox-control" name="addressLine1"
								value="${orderDetails?.addressLine1}" pattern=".{3,}"
								required="required" maxlength="100" title='Minimum 3 characters' /></td>
					</tr>
					<tr>
						<td></td>
						<td><g:textField class="textbox-control" name="addressLine2"
								value="${orderDetails?.addressLine2}" pattern=".{3,}"
								required="required" maxlength="100" title='Minimum 3 characters' /></td>
					</tr>
					<tr>
						<td><label class="label-control" for="landmark">Circle:
						</label></td>
						<td><g:hiddenField name="circle"
								value="${orderDetails?.circle }" /> ${orderDetails?.circle }
							(Delivery restricted to this area)</td>
					</tr>
					<tr>
						<td><label class="label-control" for="city">City: </label></td>
						<td><g:hiddenField name="city" value="${orderDetails?.city }" />
							${orderDetails?.city }</td>
					</tr>
					<tr>
						<td><label class="label-control" for="state">State: </label></td>
						<td><g:hiddenField name="state"
								value="${orderDetails?.state }" /> ${orderDetails?.state }</td>
					</tr>
					<tr>
						<td><label class="label-control" for="country">Country:
						</label></td>
						<td><g:hiddenField name="country"
								value="${orderDetails?.country }" /> ${orderDetails?.country }</td>
					</tr>
					<tr>
						<td><label class="label-control" for="textfield">Payment
								Method: </label></td>
						<td><label class="label-control" for="textfield">Cash
								on delivery</label></td>
					</tr>
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
<%--					</g:if>--%>
					<%--					<tr>--%>
					<%--						<td style="width: 15%"><label class="label-control" for="pin">Pin--%>
					<%--								code </label></td>--%>
					<%--						<td><input name="pin" type="text" required--%>
					<%--							class="textbox-control" id="textfield"></td>--%>
					<%--					</tr>--%>
				</tbody>
			</table>

			<div class="end" align="center">
			<g:message code="order.prescription.message"/><br>
				<%--				<br />--%>
				<g:submitButton name="create"
					value="${message(code: 'default.button.submit.label', default: 'Submit')}"
					class="btn btn-default" onclick="return confirm('${message(code: 'order.confirm.message')}');"/>
				<input type="button" class="btn btn-default"
					value="${message(code: 'patient.details.back.button', default: 'Go Back')}"
					onClick="history.go(-1);return true;">
			</div>
		</g:form>
	</div>
	<br />
</body>
</html>
