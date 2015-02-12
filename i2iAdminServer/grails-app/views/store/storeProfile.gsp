<!DOCTYPE html>
<html>
<head>
<g:set var="entityName"
	value="${message(code: 'storeProfile.label', default: 'StoreProfile')}" />
<meta name="layout" content="adminLayout">
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
	<div id="create-store" class="content scaffold-create" role="main">
		<h2>
			My account details
		</h2>
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
		<g:form url="[resource:storeInstance, action:'save']">
			<fieldset class="form">

				<div
					class="fieldcontain ${hasErrors(bean: storeInstance, field: 'storeName', 'error')} required">
					<label for="storeName"> <g:message
							code="store.storeName.label" default="Store Name" /> <span
						class="required-indicator">*</span>
					</label>
					<g:textField name="storeName" maxlength="100" required=""
						value="${storeInstance?.storeName}" />

				</div>

				<div
					class="fieldcontain ${hasErrors(bean: storeInstance, field: 'addressLine1', 'error')} required">
					<label for="addressLine1"> <g:message
							code="store.addressLine1.label" default="Address Line1" /> <span
						class="required-indicator">*</span>
					</label>
					<g:textField name="addressLine1" maxlength="100" required=""
						value="${storeInstance?.addressLine1}" />

				</div>

				<div
					class="fieldcontain ${hasErrors(bean: storeInstance, field: 'addressLine2', 'error')} required">
					<label for="addressLine2"> <g:message
							code="store.addressLine2.label" default="Address Line2" /> <span
						class="required-indicator">*</span>
					</label>
					<g:textField name="addressLine2" maxlength="100" required=""
						value="${storeInstance?.addressLine2}" />

				</div>

				<div
					class="fieldcontain ${hasErrors(bean: storeInstance, field: 'circle', 'error')} required">
					<label for="circle"> <g:message code="store.circle.label"
							default="Circle" /> <span class="required-indicator">*</span>
					</label>
					<g:textField name="circle" maxlength="100" required=""
						value="${storeInstance?.circle}" />

				</div>

				<div
					class="fieldcontain ${hasErrors(bean: storeInstance, field: 'city', 'error')} required">
					<label for="city"> <g:message code="store.city.label"
							default="City" /> <span class="required-indicator">*</span>
					</label>
					<g:textField name="city" maxlength="100" required=""
						value="${storeInstance?.city}" />

				</div>

				<div
					class="fieldcontain ${hasErrors(bean: storeInstance, field: 'state', 'error')} required">
					<label for="state"> <g:message code="store.state.label"
							default="State" /> <span class="required-indicator">*</span>
					</label>
					<g:textField name="state" maxlength="100" required=""
						value="${storeInstance?.state}" />

				</div>

			</fieldset>
			<fieldset class="buttons">
				<g:submitButton name="Update" class="save"
					value="${message(code: 'default.button.create.label', default: 'Create')}" />
			</fieldset>
		</g:form>
	</div>
</body>
</html>
