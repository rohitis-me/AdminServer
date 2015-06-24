
<%@ page import="i2i.AdminServer.Store"%>
<%@ page import="i2i.AdminServer.Constants"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'cart.items.list', default: 'Cart')}" />
<title><g:message code="title.brand.tag" /> | <g:message message="Cart Items" /></title>
<%--<g:javascript library="jquery"/>--%>
</head>
<body>
	<g:render template="/template/navigationConsumer" />

	<div class="container">
		<div class="row">
<%--			<g:render template="/template/searchBox"></g:render>--%>
<%--			<br />--%>
			<div class="col-md-10 col-md-offset-1">
				<br />
				<g:if test="${cartItemMapList}">
					<div align="center">
						<label> <g:message code="cart.items.list"
								default="Find your Cart items here." />
						</label>
					</div>
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<table class="table table-hover table-striped">
								<thead class="bg-default bg-primary">
									<tr>
										<th>Item</th>
										<th>Quantity</th>
<%--										<th>Remarks</th>--%>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<g:each in="${cartItemMapList}" status="i" var="itemInstance">
										<g:set var="quantity" value="${itemInstance['qty']}" />
										<g:set var="inventoryId" value="${itemInstance['iId']}" />
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											<td>
												${itemInstance['item']}
											</td>
											<td>
<%--											<g:form action="changeCartItemQuantity" id="qtyForm">--%>
<%--											<g:select class="form-control input-lg" required="" name="quantity"--%>
<%--											from="${Constants.quantityArray}" id="qtySelectBox"--%>
<%--											 onchange="qtyChangeFunction()"></g:select>--%>
<%--											 </g:form>--%>
											<input class="form-control" placeholder="Quantity"
											type="number" size="6" name="quantity" min="1" max="99999"
											value="${quantity}">
											</td>
<%--											<td><span style="color: #B0CF36"><g:message--%>
<%--														code="search.list.homedelivery"--%>
<%--														message="Home Delivery Available" /></span>--%>
<%--														<br> <g:message--%>
<%--													code="search.list.etd" message="Delivery in: " /> 4 hours--%>
<%--												(subject to order acceptance by pharmacy)--%>
<%--												</td>--%>
											<td>
											<g:form action="removeItemFromCart" params='[inventoryId: inventoryId, quantity:quantity]'>
												<button type="submit" class="btn btn-danger btn-block" >
												<i class="glyphicon glyphicon-remove"></i></button>
												</g:form>
											</td>
										</tr>
									</g:each>
								</tbody>
							</table>
							<br />
							<br/>

							<g:form>
							<div class="bg-default text-center">
								<div class="form-group">
									<g:radioGroup name="prescriptionUploadOption" labels="['Show prescription on delivery', 'Upload prescription now']" values="[0,1]" value="0">
										${it.radio} <g:message code="${it.label}" /> <br/> 
									</g:radioGroup>
								</div>
							</div>
							<div class="panel-footer clearfix">
								<div class="col-sm-offset-3 col-xs-6 col-sm-3">
									<button type="submit" class="btn btn-primary btn-block" name="_action_goToHomePage" >
										<i class="glyphicon glyphicon-plus"></i> Add More </button>
								</div>
<%--								<g:actionSubmit value="Sum" controller="search" action="index"/>--%>
								<div class="col-xs-6 col-sm-3">
									<button type="submit" class="btn btn-success btn-block" name="_action_placeOrder">
										<i class="glyphicon glyphicon-ok"></i>&nbsp; Place Order
									</button>
								</div>
							</div>
							</g:form>
						</div>
					</div>
				</g:if>
				<g:else>
					<div align="center">
						<label style="color: red;"> <g:message
								code="cart.items.unavailable" default="There are no items in this cart." /></label>
					</div>
					<br/>
					<g:form controller="search" action="index"> 
								<div class="col-sm-offset-3 col-xs-6 col-sm-3" align="center">
									<button type="submit" class="btn btn-primary btn-block" >
										<i class="glyphicon glyphicon-menu-left"></i> Add Items
									</button>
								</div>
					</g:form>			
				</g:else>

			</div>
		</div>
	</div>
	<br />
	<p id="demo"></p>
	
<%--	<script>--%>
<%--	function qtyChangeFunction() {--%>
<%--    var x = document.getElementById("qtySelectBox").value;--%>
<%--    document.getElementById("demo").innerHTML = "You selected: " + x;--%>
<%--    $("qtyForm").submit();--%>
<%--}--%>
<%--</script>--%>

</body>
</html>
