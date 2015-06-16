
<%@ page import="i2i.AdminServer.OrderCollection" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orderCollection.label', default: 'OrderCollection')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-orderCollection" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-orderCollection" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="personId" title="${message(code: 'orderCollection.personId.label', default: 'Person Id')}" />
					
						<g:sortableColumn property="orderRefId" title="${message(code: 'orderCollection.orderRefId.label', default: 'Order Ref Id')}" />
					
						<g:sortableColumn property="offerCode" title="${message(code: 'orderCollection.offerCode.label', default: 'Offer Code')}" />
					
						<g:sortableColumn property="attachmentId" title="${message(code: 'orderCollection.attachmentId.label', default: 'Attachment Id')}" />
					
						<g:sortableColumn property="orderCollectionId" title="${message(code: 'orderCollection.orderCollectionId.label', default: 'Order Collection Id')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${orderCollectionInstanceList}" status="i" var="orderCollectionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${orderCollectionInstance.id}">${fieldValue(bean: orderCollectionInstance, field: "personId")}</g:link></td>
					
						<td>${fieldValue(bean: orderCollectionInstance, field: "orderRefId")}</td>
					
						<td>${fieldValue(bean: orderCollectionInstance, field: "offerCode")}</td>
					
						<td>${fieldValue(bean: orderCollectionInstance, field: "attachmentId")}</td>
					
						<td>${fieldValue(bean: orderCollectionInstance, field: "orderCollectionId")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${orderCollectionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
