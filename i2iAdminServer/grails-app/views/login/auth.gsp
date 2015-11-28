<html>

<head>
<meta name='layout' content='pillocateLayout' />
<g:set var="entityName"
	value="${message(code: 'springSecurity.login.title', default: 'Login')}" />
<title><g:message code="title.brand.tag"/> | <g:message code="title.page.login"/></title>
</head>

<body>
	<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<!-- Default panel contents -->
						<div class="panel-body">
							<h1 class="login-header">
								Sign up Today, it's <small class="text-danger bold">
									FREE</small>
							</h1>
							<p>When you sign up, we can customize your pillocate experience and serve you better!</p>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-default register-widget">
						<!-- Default panel contents -->
						<div class="panel-body">
							<h3>Existing User? Log in</h3>
							<p>Please enter your e-mail and password to log in.</p>
							<g:if test='${flash.message}'>
								<div class='login_message'>
									<p style="color: red;">${flash.message}</p>
								</div>
							</g:if>
<%--							${postUrl}--%>
							<form action='${postUrl}' method='POST' id='loginForm' name="loginForm">
								<g:set var="Source" value="WebApp" scope="session" />
								<div class="form-group">
									<span class="input-icon"> <input class="form-control"
										placeholder="E-mail address"
										type="text" required="required" name='j_username' id='username'
										size="20" value=""> <i class="fa fa-envelope"></i></span>
								</div>
								<div class="form-group form-actions">
									<span class="input-icon"> <input
										class="form-control password"
										placeholder=<g:message
										code="springSecurity.login.password.label"/>
										type="password" required="required" name='j_password' id='password'
										size="20" value=""> <i class="fa fa-lock"></i> 
										<span
										class="forgot-pass"> <g:link controller='register'
												action='forgotPassword'>
												<g:message code='spring.security.ui.login.forgotPassword' />
											</g:link>
									</span>
									</span>
								</div>
								<div class="form-actions clearfix">
									<label for="remember" class="checkbox-inline"> <input
										class="grey remember" type="checkbox"
										name='${rememberMeParameter}' id='remember_me'
										<g:if test='${hasCookie}'>checked='checked'</g:if> /> Keep me
										signed in
									</label>
<%--									<g:link controller='register'>--%>
<%--										<g:message code='spring.security.ui.login.register' />--%>
<%--									</g:link>--%>
									<button type="submit" id="login_submit" class="btn btn-primary pull-right">
										&nbsp; Login <i class="fa fa-sign-in"></i>&nbsp;
									</button>
								</div>
							</form>
						</div>
						<!-- panel container -->
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-default register-widget">
						<div class="panel-body">
							<h3>New User? Sign up</h3>
							<p>This information will let us know more about you.</p>
							<g:form controller="register" action='register' id="registerForm" name='registerForm'>
								<g:if test='${emailSent}'>
									<br />
									<g:message code='spring.security.ui.register.sent' />
								</g:if>
								<g:else>
									<g:hiddenField name="username" id="reg_user_name" bean="${command}"
										value="${command?.username}" />
									<div class="form-group">
										<span class="input-icon"> <input class="form-control"
											name="email" placeholder="E-mail address"
											type="text" required="required" id="reg_email"
											value="${command?.email}" size='60' /> <i
											class="fa fa-envelope"></i>
										</span>
											<g:hasErrors bean="${command}" field="username">
											<g:eachError bean="${command}" field="username">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>

									<div class="form-group form-actions">
										<span class="input-icon"> <input
											class="form-control password" name="password"
											placeholder="Password" type="password" required="required" size='20'
											value="${command?.password}" /> <i class="fa fa-lock"></i>
										</span>
										<g:hasErrors bean="${command}" field="password">
											<g:eachError bean="${command}" field="password">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>

									<div class="form-group form-actions">
										<span class="input-icon"> <input
											class="form-control password" name="password2"
											placeholder="Confirm password" type="password" required="required"
											size='20' value="${command?.password2}" /> <i
											class="fa fa-lock"></i>
										</span>
											<g:hasErrors bean="${command}" field="password2">
											<g:eachError bean="${command}" field="password2">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
									<div class="form-actions clearfix">
									<label for="termsConditions" class="checkbox-inline"> <input
										class="grey remember" type="checkbox" required="required"/> I accept <a href="${createLink(uri:'/termsConditions')}">Terms &amp; Conditions</a>

									</label>
										<button type="submit" id="reg_submit" class="btn btn-primary pull-right" >
											Sign-Up <i class="glyphicon glyphicon-play-circle"></i>
										</button>
									</div>
								</g:else>
							</g:form>
						</div>
						<!-- panel container -->
					</div>
				</div>
				<!-- end row -->
			</div>
		</div>



	<script>
		$(document).ready(function() {
			$('#username').focus();
		});
		$('#login_submit').click(function() {
		    $('#loginForm').submit();
		    });
		$('#reg_submit').click(function() {
		    $('#reg_user_name').val($('#reg_email').val());
		    $('#registerForm').submit();
		    });
<%--				function onTextEnter(event) {--%>
<%--			$('#reg_user_name').val($('#user_email').val());--%>
<%--		}--%>
	</script>

</body>
</html>
