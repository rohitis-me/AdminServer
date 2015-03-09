<nav>
	<ul>
		<g:if test="${entityName== 'i2iHome' }">
			<li><g:link class="current" controller="search" action="index">Home</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="search" action="index">Home</g:link></li>
		</g:else>
		
		<g:if test="${entityName== 'Feedback' }">
			<li><g:link class="current" controller="feedback" action="feedback">Feedback</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="feedback" action="feedback">Feedback</g:link></li>
		</g:else>
	</ul>
</nav>