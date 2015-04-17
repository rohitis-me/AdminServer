<html>

<head>
<meta name='layout' content='pillocateLayout' />
<g:set var="entityName"
	value="${message(code: 'springSecurity.login.title', default: 'Login')}" />
<title>pillocate | login</title>
</head>

<body>
	<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">

				<div class="col-md-12">
					<div class="panel panel-default">
						<!-- Default panel contents -->
						<div class="panel-body">
							<h1 class="login-header">
								Sign up Today, it's <small class="text-danger bold">
									FREE</small>
							</h1>
							<p>When you sign up with pillocate.com, able to get different
								information by E-mail and SMS.</p>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-default register-widget">
						<!-- Default panel contents -->
						<div class="panel-body">
							<h3>Already a member? Log in</h3>
							<p>Please enter your name and password to log in.</p>
							<g:if test='${flash.message}'>
								<div class='login_message'>
									<p style="color: red;">${flash.message}</p>
								</div>
							</g:if>
							<form action='${postUrl}' method='POST' id='loginForm'>
								<div class="form-group">
									<span class="input-icon"> <input class="form-control"
										placeholder="E-mail address"
										type="email" required name='j_username' id='username'
										size="20"> <i class="fa fa-envelope"></i></span>
								</div>
								<div class="form-group form-actions">
									<span class="input-icon"> <input
										class="form-control password"
										placeholder=<g:message
										code="springSecurity.login.password.label"/>
										type="password" required name='j_password' id='password'
										size="20"> <i class="fa fa-lock"></i> 
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
									<button type="submit" id="submit" class="btn btn-primary pull-right">
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
							<h3>New User sign up</h3>
							<p>This information will let us know more about you.</p>
							<g:form controller="register" action='register'
								name='registerForm' id="reg_form">
								<g:if test='${emailSent}'>
									<br />
									<g:message code='spring.security.ui.register.sent' />
								</g:if>
								<g:else>
									<g:hiddenField name="username" id="reg_user_name" bean="${command}"
										value="${command?.username}" />
									<div class="form-group">
										<span class="input-icon"> <input class="form-control"
											name="useremail" placeholder="E-mail address"
											type="email" required id="reg_email"
											value="${command?.email}" size='40' /> <i
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
											placeholder="Password" type="password" required size='40'
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
											placeholder="Confirm password" type="password" required
											size='40' value="${command?.password2}" /> <i
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
										<button id="reg_submit" type="submit" class="btn btn-primary pull-right" onclick="submitMyForm()">
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
	</div>




	<script>
		$(document).ready(function() {
			$('#username').focus();
		});
		
		function submitMyForm(){
		    $('#reg_user_name').val($('#reg_email').val());
		    $('#reg_form').submit();}
		<%--		function onTextEnter(event) {--%>
<%--			$('#reg_user_name').val($('#user_email').val());--%>
<%--		}--%>
	</script>

</body>
</html>
