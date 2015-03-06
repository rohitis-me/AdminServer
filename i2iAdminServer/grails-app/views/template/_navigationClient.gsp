<nav>
	<ul>
		<g:if test="${entityName== 'i2iHome' }">
			<li><g:link class="current" controller="search" action="index">Home</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="search" action="index">Home</g:link></li>
		</g:else>
		
		<g:if test="${entityName== 'Contact Us' }">
			<li><g:link class="current" controller="orders" action="showOrderDetailsList">Contact Us</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="orders" action="showOrderDetailsList">Contact Us</g:link></li>
		</g:else>
	</ul>
</nav>