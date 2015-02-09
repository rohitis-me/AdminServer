

<%@ page import="i2i.AdminServer.User.PatientProfile" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'patientProfile.label', default: 'PatientProfile')}" />
<title><g:message code="default.create.label"
		args="[entityName]" /></title>
</head>
<body>
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

		<div class="ordername" align="center">
			<g:fieldValue class="label-control" bean="${orderDetails}"
				field="brandName" />
			<span class="label-control"> from </span>
			<g:fieldValue class="label-control" bean="${orderDetails}"
				field="storeName" />
		</div>
		<br />
		<h2
			style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
			Delivery address</h2>
		<br />

		<g:form controller="orders" action="saveOrder" >
			
			<g:hiddenField name="brandId" value="${orderDetails?.brandId }"/>
			<g:hiddenField name="storeId" value="${orderDetails?.storeId }"/>
			
			<table align="center" style="border-top: 0">
				<tbody>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="name"><g:message code="patientProfile.name.label"
									default="Name" /></label></td>
						<td><g:textField name="name" maxlength="100"
								required="required" class="textbox-control"
								value="${orderDetails?.name}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control" for="age"><g:message
									code="patientProfile.age.label" default="Age" /></label></td>
						<td><g:field class="textbox-control" type="number" name="age"
								value="${fieldValue(bean: orderDetails, field: 'age')}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="phoneNumber"><g:message
									code="patientProfile.phoneNumber.label" default="Phone" /></label></td>
						<td><g:textField name="phoneNumber" class="textbox-control"
								maxlength="100" required="required"
								value="${orderDetails?.phoneNumber}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="emailID"><g:message
									code="patientProfile.emailID.label" default="Email ID" /></label></td>
						<td><g:textField class="textbox-control" name="emailID"
								type="email" maxlength="100" value="${orderDetails?.emailID}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="address">Address </label></td>
						<td><g:textArea class="textbox-control" name="addressLine1"
								cols="1" rows="1" maxlength="1000" required="required"
								style="height: 80px;" value="${orderDetails?.addressLine1}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="landmark">Landmark </label></td>
						<td><g:textField class="textbox-control" name="addressLine2"
								maxlength="100" required="required"
								value="${orderDetails?.addressLine2}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="landmark">Circle </label></td>
						<td><g:textField class="textbox-control" name="circle"
								maxlength="100" required="required"
								value="${orderDetails?.circle}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="city">City </label></td>
						<td><g:textField class="textbox-control" name="city"
								maxlength="100" required="required"
								value="${orderDetails?.city}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="state">State </label></td>
						<td><g:textField class="textbox-control" name="state"
								maxlength="100" required="required"
								value="${orderDetails?.state}" /></td>
					</tr>
					<tr>
						<td style="width: 15%"><label class="label-control"
							for="country">Country </label></td>
						<td><g:textField class="textbox-control" name="country"
								maxlength="100" required="required"
								value="${orderDetails?.country}" /></td>
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
				<g:submitButton name="create" data-icon="check"
					value="${message(code: 'default.button.create.label', default: 'Confirm order')}"
					class="btn btn-default" style="height:44px; width:20%" />
			</div>
		</g:form>
	</div>
</body>
</html>
