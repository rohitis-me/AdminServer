<html>

<head>
<title><g:message code='spring.security.ui.resetPassword.title' /></title>
<meta name='layout' content='pillocateLayout' />
</head>

<body>

	<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<g:form action='resetPassword' name='resetPasswordForm'
					autocomplete='off'>
					<g:hiddenField name='t' value='${token}' />

					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<div class="panel-heading text-center">
								<g:message code='spring.security.ui.resetPassword.header' />
							</div>
							<div class="panel-body">
								<div class="alert alert-default">
									<g:message code='spring.security.ui.resetPassword.description' />
								</div>
								<div class="form-group">

									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger">*</span> Password : </label>
									<div class="col-sm-7">
										<input size="40" class="form-control" required="required"
											placeholder="Password" type="password" name='password'
											value="${command?.password}">
										<g:hasErrors bean="${command}" field="password">
											<g:eachError bean="${command}" field="password">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-4 control-label"><span
										class="text-danger">*</span> Confirm password : </label>
									<div class="col-sm-7">
										<input class="form-control" placeholder="Confirm password"
											type="password" size="40" name='password2'
											value="${command?.password2}">
										<g:hasErrors bean="${command}" field="password2">
											<g:eachError bean="${command}" field="password2">
												<p style="color: red;">
													<g:message error="${it}" />
												</p>
											</g:eachError>
										</g:hasErrors>
									</div>
								</div>

							</div>
							<div class="panel-footer clearfix">
								<div class="row">
									<div class="col-sm-offset-4 col-xs-12 col-sm-3">
										<button type="submit" class="btn btn-primary btn-block">
											<i class="glyphicon glyphicon-ok"></i>&nbsp;
											<g:message code='spring.security.ui.resetPassword.submit' />
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</g:form>
			</div>
		</div>
	</div>


	<%--<p/>--%>
	<%--<s2ui:form width='475' height='250' elementId='resetPasswordFormContainer'--%>
	<%--           titleCode='spring.security.ui.resetPassword.header' center='true'>--%>
	<%----%>
	<%--	<g:form action='resetPassword' name='resetPasswordForm' autocomplete='off'>--%>
	<%--	<g:hiddenField name='t' value='${token}'/>--%>
	<%--	<div class="sign-in">--%>
	<%----%>
	<%--	<br/>--%>
	<%--	<h4><g:message code='spring.security.ui.resetPassword.description'/></h4>--%>
	<%----%>
	<%--	<table>--%>
	<%--		<s2ui:passwordFieldRow name='password' labelCode='resetPasswordCommand.password.label' bean="${command}"--%>
	<%--                             labelCodeDefault='Password' value="${command?.password}"/>--%>
	<%----%>
	<%--		<s2ui:passwordFieldRow name='password2' labelCode='resetPasswordCommand.password2.label' bean="${command}"--%>
	<%--                             labelCodeDefault='Password (again)' value="${command?.password2}"/>--%>
	<%--	</table>--%>
	<%----%>
	<%--	<s2ui:submitButton elementId='reset' form='resetPasswordForm' messageCode='spring.security.ui.resetPassword.submit'/>--%>
	<%----%>
	<%--	</div>--%>
	<%--	</g:form>--%>
	<%----%>
	<%--</s2ui:form>--%>

	<script>
		$(document).ready(function() {
			$('#password').focus();
		});
	</script>

</body>
</html>
