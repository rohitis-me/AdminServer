
<%--<%@ page import="i2i.AdminServer.Store"%>--%>
<%--<%@ page import="i2i.AdminServer.Constants"%>--%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'prescription.items.list', default: 'Prescriptions')}" />
<title><g:message code="title.brand.tag" /> | <g:message message="Uploaded Prescriptions" /></title>
<g:javascript library="jquery"/>
</head>
<body>
	<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
<%--			<g:render template="/template/searchBox"></g:render>--%>
<%--			<br />--%>
			<div class="col-md-10 col-md-offset-1">
				<br />
				<g:if test="${attachmentLinkList}">
					<div align="center">
						<label> <g:message code="cart.items.list"
								default="Your Uploaded prescriptions" />
						</label>
					</div>
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<table class="table table-hover table-striped">
<%--								<thead class="bg-default bg-primary">--%>
<%--									<tr>--%>
<%--										<th>Item</th>--%>
<%--										<th>Quantity</th>--%>
<%--										<th></th>--%>
<%--									</tr>--%>
<%--								</thead>--%>
								<tbody>
									<g:each in="${attachmentLinkList}" status="i" var="attachmentLink">
								
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										<td>
										  <span class="label-control"><a href="${attachmentLink}">Prescription ${i}</a></span>
										</td>
										</tr>
									</g:each>
								</tbody>
							</table>
							<br/>
						</div>
					</div>
				</g:if>
				<g:else>
					<div align="center">
						<label style="color: red;"> <g:message
								code="address.items.unavailable" default="No uploaded prescriptions." /></label>
					</div>
					<br/>
<%--					<g:form controller="search" action="index"> --%>
<%--								<div class="col-sm-offset-3 col-xs-6 col-sm-3" align="center">--%>
<%--									<button type="submit" class="btn btn-primary btn-block" >--%>
<%--										<i class="glyphicon glyphicon-menu-left"></i> Add Items--%>
<%--									</button>--%>
<%--								</div>--%>
<%--					</g:form>			--%>
				</g:else>

			</div>
		</div>
	</div>
	<br />
<%--	<p id="demo"></p>--%>
	
<%--<g:javascript>--%>
<%--function qtyChangeFunction() {--%>
<%--    var x = document.getElementById("qtySelectBox").value;--%>
<%--    document.getElementById("demo").innerHTML = "You selected: " + x;--%>
<%--    $("#qtyForm").submit()--%>
<%--}--%>
<%--</g:javascript>--%>

</body>
</html>
