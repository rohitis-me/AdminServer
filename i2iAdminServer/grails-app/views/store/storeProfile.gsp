<!DOCTYPE html>
<html>
<head>
<g:set var="entityName"
	value="${message(code: 'storeProfile.label', default: 'StoreProfile')}" />
<meta name="layout" content="searchLayout">
<title><g:message code="default.create.label"
		args="[entityName]" /></title>
</head>
<body>
	<g:render template="/template/navigation" />
	<%--				<nav>--%>
	<%--					<ul>--%>
	<%--						<li><g:link class="current" controller="orders" action="showOrderDetailsList">Profile</g:link></li>--%>
	<%--						<li><g:link controller="orders" action="showOrderDetailsList">Orders</g:link></li>--%>
	<%--						<li><g:link controller="availability" action="showInventoryDetails">Inventory</g:link></li>--%>
	<%--					</ul>--%>
	<%--				</nav>--%>

	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:hasErrors bean="${storeInstance}">
		<ul class="errors" role="alert">
			<g:eachError bean="${storeInstance}" var="error">
				<li
					<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
						error="${error}" /></li>
			</g:eachError>
		</ul>
	</g:hasErrors>
<br/>

	<g:form controller="store" action="saveStoreProfile" method="PUT">
	<g:hiddenField name="version" value="${storeInstance?.version}" />
		<table align="center" style="border-top: 0">
			<tbody>
				<tr>
					<td style="width: 25%">
						<div
							class="fieldcontain ${hasErrors(bean: storeInstance, field: 'storeName', 'error')} required">
							<label class="label-control" for="storeName"> <g:message
									code="store.storeName.label" default="Store Name" /> <span
								class="required-indicator">*</span>
							</label>
						</div>
					</td>
					<td><g:textField class="textbox-control" name="storeName" maxlength="100" required=""
							value="${storeInstance?.storeName}" /></td>
				</tr>
				<tr>
					<td style="width: 25%">
						<div
							class="fieldcontain ${hasErrors(bean: storeInstance, field: 'phoneNumber', 'error')} required">
							<label class="label-control" for="phoneNumber"> <g:message
									code="store.phonenumber.label" default="Phone No" /> <span
								class="required-indicator">*</span>
							</label>
						</div>
					</td>
					<td><g:textField class="textbox-control" name="phoneNumber" maxlength="100" required=""
							value="${storeInstance?.phoneNumber}" /></td>
				</tr>
				<tr>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean: storeInstance, field: 'addressLine1', 'error')} required">
							<label class="label-control" for="addressLine1"> <g:message
									code="store.addressLine1.label" default="Address Line1" /> <span
								class="required-indicator">*</span>
							</label>
						</div>
					</td>
					<td><g:textField class="textbox-control" name="addressLine1" maxlength="100"
							required="" value="${storeInstance?.addressLine1}" /></td>
				</tr>

				<tr>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean: storeInstance, field: 'addressLine2', 'error')} required">
							<label class="label-control" for="addressLine2"> <g:message
									code="store.addressLine2.label" default="Address Line2" /> <span
								class="required-indicator">*</span>
							</label>
						</div>
					</td>
					<td><g:textField class="textbox-control" name="addressLine2" maxlength="100"
							required="" value="${storeInstance?.addressLine2}" /></td>
				</tr>

				<tr>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean: storeInstance, field: 'circle', 'error')} required">
							<label class="label-control" for="circle"> <g:message code="store.circle.label"
									default="Circle" /> <span class="required-indicator">*</span>
							</label>
						</div>
					</td>
					<td><g:textField class="textbox-control" name="circle" maxlength="100" required=""
							value="${storeInstance?.circle}" /></td>
				</tr>

				<tr>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean: storeInstance, field: 'city', 'error')} required">
							<label class="label-control" for="city"> <g:message code="store.city.label"
									default="City" /> <span class="required-indicator">*</span>
							</label>
						</div>
					</td>
					<td><g:textField class="textbox-control" name="city" maxlength="100" required=""
							value="${storeInstance?.city}" /></td>
				</tr>

				<tr>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean: storeInstance, field: 'state', 'error')} required">
							<label class="label-control" for="state"> <g:message code="store.state.label"
									default="State" /> <span class="required-indicator">*</span>
							</label>
						</div>
					</td>
					<td><g:textField class="textbox-control" name="state" maxlength="100" required=""
							value="${storeInstance?.state}" /></td>
				</tr>
			</tbody>
		</table>
		<g:hiddenField name="storeId" value="${storeInstance?.storeId }"/>
		<div align="center">
			<g:submitButton name="Update" 
				value="${message(code: 'default.button.update.label', default: 'Update')}" class="btn btn-default"/>
		</div>

	</g:form>
<br/>
</body>
</html>
