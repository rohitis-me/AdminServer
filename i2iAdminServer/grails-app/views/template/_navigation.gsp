<nav>
	<ul>
		<g:if test="${entityName== 'StoreProfile' }">
			<li><g:link class="current" controller="store" action="showStoreProfile">Store Profile</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="store" action="showStoreProfile">Store Profile</g:link></li>
		</g:else>
		
		<g:if test="${entityName== 'Orders' }">
			<li><g:link class="current" controller="orders" action="showOrderDetailsList">Orders</g:link></li>
		</g:if>
		<g:else>
			<li><g:link controller="orders" action="showOrderDetailsList">Orders</g:link></li>
		</g:else>
				
		<g:if test="${entityName== 'Availability' }">
				<li><g:link class="current" controller="availability"
				action="showInventoryDetails">Inventory</g:link></li>
		</g:if>
		<g:else>
				<li><g:link controller="availability"
				action="showInventoryDetails">Inventory</g:link></li>
		</g:else>		
		<li><a href="${createLink(controller: 'logout')}"> Logout</a></li>
	</ul>
</nav>