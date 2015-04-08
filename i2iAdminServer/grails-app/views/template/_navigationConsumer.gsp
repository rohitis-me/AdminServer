<nav>
	<ul>
		<g:if test="${entityName== 'i2iHome' }">
			<li><g:link class="current" controller="search" action="index">Home</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="search" action="index">Home</g:link></li>
		</g:else>

		<g:if test="${entityName== 'TrackOrder' }">
			<li><g:link class="current" controller="orders"
					action="trackOrderStatus">Track Order</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="orders" action="trackOrderStatus">Track Order</g:link></li>
		</g:else>

		<g:if test="${entityName== 'Feedback' }">
			<li><g:link class="current" controller="feedback"
					action="feedback">Feedback</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="feedback" action="feedback">Feedback</g:link></li>
		</g:else>

		<sec:ifNotLoggedIn>
			<g:if test="${entityName== 'Login' }">
				<li><g:link class="current" controller="login" action="auth">Login</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="login" action="auth">Login</g:link></li>
			</g:else>
		</sec:ifNotLoggedIn>
		<sec:ifAllGranted roles="ROLE_CONSUMER">
			<g:if test="${entityName== 'MyAccount' }">
				<li><g:link class="current" controller="login" action="auth">My Account</g:link></li>
			</g:if>
			<g:else>
				<li><g:link controller="login" action="auth">My Account</g:link></li>
			</g:else>
		</sec:ifAllGranted>

		<sec:ifLoggedIn>
			<li><a href="${createLink(controller: 'logout')}"> Logout</a></li>
		</sec:ifLoggedIn>

	</ul>
</nav>