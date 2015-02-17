<html>
<head>
<meta name='layout' content='searchLayout' />
<title><g:message code="springSecurity.login.title" /></title>
<style type='text/css' media='screen'>
#login {
	
}

#login .inner {
	width: 60%;
	padding: 12px;
	margin: 60px auto;
	text-align: left;
	border: 1px solid #cccccc;
	border-radius: 4px;
	background-color: #777373;
}

#login #remember_me_holder {
	text-align: right;
}

#login #remember_me_holder label {
	float: none;
	margin-left: 0;
	text-align: left;
	width: 200px
}

#login .inner .login_message {
	padding: 6px 25px 20px 25px;
	color: #c33;
}
</style>
</head>

<body>
	<%--	<nav>--%>
	<%--		<ul>--%>
	<%--			<li><a href="" class="current">Home</a></li>--%>
	<%--			<li><a href="">Orders</a></li>--%>
	<%--			<li><a href="">Inventory</a></li>--%>
	<%--		</ul>--%>
	<%--	</nav>--%>

	<div id='login'>
		<div class='inner'>
			<h2 style="text-align: center;">Login</h2>
			<g:if test='${flash.message}'>
				<div class='login_message'>
					${flash.message}
				</div>
			</g:if>
			<div>
				<form action='${postUrl}' method='POST' id='loginForm'>
					<table align="center" style="border-top: 0; width:80%;">
						<tbody>
							<tr>
								<td style="width: 25%"><label class="label-control"
									for='username'><g:message
											code="springSecurity.login.username.label" />:</label></td>
								<td><input type='text' class='textbox-control' required
									name='j_username' id='username' /></td>
							</tr>
							<tr>
								<td><label class="label-control" for='password'><g:message
											code="springSecurity.login.password.label" />:</label></td>
								<td><input type='password' class='textbox-control' required
									name='j_password' id='password' /></td>
							</tr>
							<tr>
								<td></td>
								<td><input type='checkbox' class='chk'
									name='${rememberMeParameter}' id='remember_me'
									<g:if test='${hasCookie}'>checked='checked'</g:if> /> <label
									class="label-control" for='remember_me'><g:message
											code="springSecurity.login.remember.me.label" /></label></td>
							</tr>
						</tbody>
					</table>

					<div align="center">
						<input class='btn btn-default' type='submit' id="submit"
							value='${message(code: "springSecurity.login.button")}' />
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type='text/javascript'>
	<!--
		(function() {
			document.forms['loginForm'].elements['j_username'].focus();
		})();
	// -->
	</script>
</body>
</html>