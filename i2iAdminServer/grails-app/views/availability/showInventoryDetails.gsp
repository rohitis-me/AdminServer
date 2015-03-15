
<%@ page import="i2i.AdminServer.Availability"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<g:set var="entityName"
	value="${message(code: 'availability.label', default: 'Availability')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>

<%--<script type="text/javascript">--%>
<%--    function selectAll(){//this function is used to check or uncheck all checkboxes--%>
<%--        var select = document.getElementById("select_all");--%>
<%--        var checkboxes = document.forms['bookForm'].elements['delete_checkbox'];--%>
<%--        if (select.checked){--%>
<%--            for (i = 0; i < checkboxes.length; i++) checkboxes[i].checked = true;--%>
<%--        }else{--%>
<%--            for (i = 0; i < checkboxes.length; i++) checkboxes[i].checked = false;--%>
<%--        }--%>
<%--    }//this function works fine--%>
<%--</script>--%>

</head>
<body>
	<g:render template="/template/navigation" />
	<br />
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<%--	<div style="padding-left: 20%">--%>
	<%--		<g:submitButton name="available" class="btn btn-default"--%>
	<%--			value="${message(code: 'availability.availabilityIndex.available.button', default: 'Available')}" />--%>
	<%--		<g:submitButton name="Unavailable" class="btn btn-default"--%>
	<%--			action="changeStockStatus"--%>
	<%--			value="${message(code: 'availability.availabilityIndex.unavailable.button', default: 'Unavailable')}" />--%>
	<%--	</div>--%>
	<%--	<br>--%>
	<%--		<g:if test="${inventoryAvailabilityList.size() > 10 }">--%>
<div align="center">
			<div class="pagination" style="width: 60%;">
				<%--		<tfoot>--%>
				<g:paginate
					total="${inventoryAvailabilityList.size() ?2158: 0}"
					controller="availability" action="showInventoryDetails" />
				<%--		</tfoot>--%>
			</div>
<%--		</g:if>--%>
	</div>

	<table align="center">
		<thead>
			<tr>
				<%--				<g:checkBox id="select_all" name="select_all" value="" onclick="selectAll();" />--%>
				<g:sortableColumn property="brandName" style="width: 50%"
					title="${message(code: 'availability.storeId.label', default: 'Brand Name')}" />

				<%--					<g:sortableColumn property="strength" style="width: 25%"--%>
				<%--						title="${message(code: 'availability.brandId.label', default: 'Strength')}" />--%>
				<%----%>
				<%--					<g:sortableColumn property="form" style="width: 10%"--%>
				<%--						title="${message(code: 'availability.form.label', default: 'Form')}" />--%>

				<g:sortableColumn property="availabilityIndex" style="width: 20%"
					title="${message(code: 'availability.availabilityIndex.label', default: 'Stock status')}" />
				<th style="width: 30%"></th>
			</tr>
		</thead>
		<tbody>
			<g:each in="${inventoryAvailabilityList}" status="i"
				var="availabilityInstance">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<g:set var="availabilityIndex"
						value="${availabilityInstance?.availabilityIndex}" />
					<td>
						<%--					<input type='checkbox' id='availabilitychk' class='chk' value="${availabilityIndex}"/> --%>
						${fieldValue(bean: availabilityInstance, field: "brandName")}
					</td>

					<%--						<td>--%>
					<%--							${fieldValue(bean: availabilityInstance, field: "strength")}--%>
					<%--						</td>--%>
					<%----%>
					<%--						<td>--%>
					<%--							${fieldValue(bean: availabilityInstance, field: "form")}--%>
					<%--						</td>--%>

					<td><g:if test="${availabilityIndex <= 0 }">Unavailable</g:if>
						<g:elseif test="${availabilityIndex > 0 }">available</g:elseif></td>

					<td><g:set var="availabilityId"
							value="${availabilityInstance?.availabilityId}" /> <g:form
							params='[availabilityId: availabilityId]'>
							<g:if test="${availabilityIndex <= 0 }">
								<g:actionSubmit name="submit" action="onClickAvailable"
									value="${message(code: 'default.button.available.label', default: 'Available')}"
									class="btn btn-default" style="width:100%" />
							</g:if>
							<g:elseif test="${availabilityIndex > 0 }">
								<g:actionSubmit name="submit" action="onClickUnavailable"
									value="${message(code: 'default.button.unavailable.label', default: 'Unavailable')}"
									class="btn btn-default" style="width:100%" />
							</g:elseif>
						</g:form></td>
				</tr>
			</g:each>
		</tbody>

	</table>
<%--	<br/>--%>
</body>
</html>
