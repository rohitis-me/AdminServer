<style type="text/css">
.h-toll-free {
    color: #777;
    font-size: 14px;
    padding-top: 15px;
    padding-bottom: 15px;
    margin: 0 3px;
    display: block;
    position:relative;
}
</style>

<!-- Fixed navbar -->
<nav class="navbar navbar-default">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#site-navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${createLink(controller:'search', action:'index')}"><div class="site-logo">
					<img src="${resource(dir: 'images', file: 'logo.png')}"
						alt="pillocate logo" />
				</div></a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="site-navbar-collapse">
			<ul class="nav navbar-nav navbar-right site-home-nav">
				<g:if test="${entityName== 'i2iHome' }">
					<li class="active"><g:link controller="search" action="index">Home</g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="search" action="index">Home</g:link></li>
				</g:else>

				<g:if test="${entityName== 'TrackOrder' }">
					<li class="active"><g:link controller="orders"
							action="trackOrderStatus">Track Order</g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="orders" action="trackOrderStatus">Track Order</g:link></li>
				</g:else>

				<g:if test="${entityName== 'Feedback' }">
					<li class="active"><g:link controller="feedback"
							action="feedback">Feedback</g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="feedback" action="feedback">Feedback</g:link></li>
				</g:else>

<%--				<sec:ifNotLoggedIn>--%>
<%--					<g:if test="${entityName== 'Login' }">--%>
<%--						<li class="active"><g:link controller="login" action="auth">Login</g:link></li>--%>
<%--					</g:if>--%>
<%--					<g:else>--%>
<%--						<li><g:link controller="login" action="auth">Login</g:link></li>--%>
<%--					</g:else>--%>
<%--				</sec:ifNotLoggedIn>--%>
				<%--				<sec:ifAllGranted roles="ROLE_CONSUMER">--%>
				<%--					<g:if test="${entityName== 'MyAccount' }">--%>
				<%--						<li><g:link class="current" controller="login" action="auth">My Account</g:link></li>--%>
				<%--					</g:if>--%>
				<%--					<g:else>--%>
				<%--						<li><g:link controller="login" action="auth">My Account</g:link></li>--%>
				<%--					</g:else>--%>
				<%--				</sec:ifAllGranted>--%>

				<sec:ifLoggedIn>
					<li><a href="${createLink(controller: 'logout')}"> Logout</a></li>
				</sec:ifLoggedIn>
				<li><p class="h-toll-free"><i class="glyphicon glyphicon-earphone"></i>+91-9591729831</p> </li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container -->
</nav>
<!-- Begin page content -->
