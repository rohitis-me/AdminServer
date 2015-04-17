<html>

<head>
<title><g:message code='spring.security.ui.forgotPassword.title' /></title>
<meta name='layout' content='pillocateLayout' />
</head>

<body>

	<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<g:form action='forgotPassword' name="forgotPasswordForm">
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<div class="panel-heading text-center">
								<g:message code='spring.security.ui.forgotPassword.header' />
							</div>
							<g:if test='${emailSent}'>
								<br />
								<div class="panel-body">
									<div class="alert alert-default">
										<g:message code='spring.security.ui.forgotPassword.sent' />
									</div>
									<div class="form-group"></div>
								</div>

							</g:if>

							<g:else>
								<div class="panel-body">
									<div class="alert alert-default">
										<g:message
											code='spring.security.ui.forgotPassword.description' />
									</div>
									<div class="form-group">

										<label for="inputEmail3" class="col-sm-4 control-label"><span
											class="text-danger">*</span> E-mail Id : </label>
										<div class="col-sm-7">
											<input name="username" size="25" class="form-control"
												required="required" placeholder="E-mail address" type="email">
											<g:if test='${flash.error}'>
												<div class='login_message'>
													<p style="color: red;">
														${flash.error}
													</p>
												</div>
											</g:if>
										</div>
									</div>
								</div>
								<div class="panel-footer clearfix">
									<div class="row">
										<div class="col-sm-offset-4 col-xs-12 col-sm-3">
											<button type="submit" class="btn btn-primary btn-block">
												<i class="glyphicon glyphicon-ok"></i>&nbsp;
												<g:message code='spring.security.ui.forgotPassword.submit' />
											</button>
										</div>
									</div>
								</div>
							</g:else>
						</div>
					</div>

				</g:form>
			</div>
		</div>
	</div>

	<%--<p/>--%>
	<%----%>
	<%--<s2ui:form width='400' height='220' elementId='forgotPasswordFormContainer'--%>
	<%--           titleCode='spring.security.ui.forgotPassword.header' center='true'>--%>
	<%----%>
	<%--	<g:form action='forgotPassword' name="forgotPasswordForm" autocomplete='off'>--%>
	<%----%>
	<%--	<g:if test='${emailSent}'>--%>
	<%--	<br/>--%>
	<%--	<g:message code='spring.security.ui.forgotPassword.sent'/>--%>
	<%--	</g:if>--%>
	<%----%>
	<%--	<g:else>--%>
	<%----%>
	<%--	<br/>--%>
	<%--	<h4><g:message code='spring.security.ui.forgotPassword.description'/></h4>--%>
	<%----%>
	<%--	<table>--%>
	<%--		<tr>--%>
	<%--			<td><label for="username"><g:message code='spring.security.ui.forgotPassword.username'/></label></td>--%>
	<%--			<td><g:textField name="username" size="25" /></td>--%>
	<%--		</tr>--%>
	<%--	</table>--%>
	<%----%>
	<%--	<s2ui:submitButton elementId='reset' form='forgotPasswordForm' messageCode='spring.security.ui.forgotPassword.submit'/>--%>
	<%----%>
	<%--	</g:else>--%>
	<%----%>
	<%--	</g:form>--%>
	<%--</s2ui:form>--%>

	<script>
		$(document).ready(function() {
			$('#username').focus();
		});
	</script>

</body>
</html>
