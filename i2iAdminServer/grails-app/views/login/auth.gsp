<html>

<head>
<meta name='layout' content='searchLayout' />
<g:set var="entityName"
	value="${message(code: 'springSecurity.login.title', default: 'Login')}" />
<title><g:message code="springSecurity.login.title"
		args="[entityName]" /></title>
</head>

<body>
	<g:render template="/template/navigationConsumer" />

	<br />
	<div id='login' align="center">
		<div class='inner'>
			<h2 style="text-align: center;">Existing User?</h2>
			<g:if test='${flash.message}'>
				<div class='login_message'>
					${flash.message}
				</div>
			</g:if>

			<form action='${postUrl}' method='POST' id='loginForm'>
				<table align="center" style="border-top: 0;">
					<tbody>
						<tr>
							<td style="width: 40%"><label class="label-control"
								for='username'>Email:</label></td>
							<td><input type='text' class='textbox-control' required
								name='j_username' id='username' size="20" /></td>
						</tr>
						<tr>
							<td><label class="label-control" for='password'><g:message
										code="springSecurity.login.password.label" />:</label></td>
							<td><input type='password' class='textbox-control' required
								name='j_password' id='password' size="20" /></td>
						</tr>
						<tr>

							<td><input type='checkbox' class='chk'
								name='${rememberMeParameter}' id='remember_me'
								<g:if test='${hasCookie}'>checked='checked'</g:if> /> <label
								class="label-control" for='remember_me'><g:message
										code="springSecurity.login.remember.me.label" /></label></td>
							<td><span class="forgot-link"> <g:link
										controller='register' action='forgotPassword'>
										<g:message code='spring.security.ui.login.forgotPassword' />
									</g:link>
							</span></td>
						</tr>
						<tr>
							<td>
							<g:link	controller='register'>
									<g:message code='spring.security.ui.login.register' /></g:link>
							</td>
							<td><input class='btn btn-default' type='submit' id="submit"
								value='${message(code: "springSecurity.login.button")}' /></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>



	<script>
		$(document).ready(function() {
			$('#username').focus();
		});
	<%--<s2ui:initCheckboxes/>--%>
		
	</script>

</body>
</html>
