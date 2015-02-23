
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
	<g:form>
<%--	<div style="padding-left: 20%">--%>
<%--		<g:submitButton name="available" class="btn btn-default"--%>
<%--			value="${message(code: 'availability.availabilityIndex.available.button', default: 'Available')}" />--%>
<%--		<g:submitButton name="Unavailable" class="btn btn-default"--%>
<%--			action="changeStockStatus"--%>
<%--			value="${message(code: 'availability.availabilityIndex.unavailable.button', default: 'Unavailable')}" />--%>
<%--	</div>--%>
<%--	<br>--%>

	<table align="center" class="scroll">
		<thead>
			<tr>
<%--				<g:checkBox id="select_all" name="select_all" value="" onclick="selectAll();" />--%>
				<g:sortableColumn property="brandName" style="width: 30%"
					title="${message(code: 'availability.storeId.label', default: 'Brand Name')}"/>

				<g:sortableColumn property="strength" style="width: 30%"
					title="${message(code: 'availability.brandId.label', default: 'Strength')}" />

				<g:sortableColumn property="form" style="width: 20%"
					title="${message(code: 'availability.form.label', default: 'Form')}" />

				<g:sortableColumn property="availabilityIndex" style="width: 20%"
					title="${message(code: 'availability.availabilityIndex.label', default: 'Stock status')}" />
			</tr>
		</thead>
		<tbody>
			<g:each in="${inventoryAvailabilityList}" status="i"
				var="availabilityInstance">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<g:set var="availabilityIndex" value="${availabilityInstance?.availabilityIndex}"/>
					<td>
<%--					<input type='checkbox' id='availabilitychk' class='chk' value="${availabilityIndex}"/> --%>
					${fieldValue(bean: availabilityInstance, field: "brandName")}
					</td>

					<td>
						${fieldValue(bean: availabilityInstance, field: "strength")}
					</td>

					<td>
						${fieldValue(bean: availabilityInstance, field: "form")}
					</td>

					<td>
					<g:if test="${availabilityIndex <= 0 }"><g:link params="[availabilityInstance: availabilityInstance, brandId: availabilityInstance.brandId]" controller="availability" action="saveAvailability">Unavailable</g:link></g:if>
					<g:elseif test="${orderStatus > 0 }"><g:link controller="availability" action="saveUnavailability">Available</g:link></g:elseif>
					</td>

<%--					<td><g:if test="${availabilityIndex <= 0 }">Unavailable</g:if> --%>
<%--					<g:elseif test="${orderStatus > 0 }">available</g:elseif></td>--%>
				</tr>
			</g:each>
		</tbody>
	</table>
	</g:form>
	<div class="pagination">
		<g:paginate total="${availabilityInstanceCount ?: 0}" />
	</div>
</body>
</html>
