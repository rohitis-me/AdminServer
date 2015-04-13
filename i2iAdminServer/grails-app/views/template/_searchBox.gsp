<g:javascript>
            $(document).ready(function() {
                $('#search_textField').autocomplete({
                
                      source: '<g:createLink controller="search"
		action="listOfBrandNameStartingWith" />',
                                            
                      select: function (event, ui){
                      $('#search_textField').val(ui.item.label);
                      $('#inventory_id').val(ui.item.id);
                      $('#brand_id').val(ui.item.name);
                      $(".search_form").submit()
                } 
                });
            });
            function onTextEnter(event) {
			 if(event.keyCode != 13) {
				console.log("in if")
					$('#inventory_id').val("");
					$('#brand_id').val("");
				}
			else {
				console.log("in else")
				}
			}
</g:javascript>

<div class="col-md-8 col-md-offset-2">
	<g:form class='search_form' controller="search" action="search"
		method="get">
		<div class="row clearfix">
			<div class="col-sm-6">
				<div class="form-group">
					<label for="inputEmail3" class="control-label">Circle :</label> <select
						class="form-control input-lg" required="" name="circle">
						<g:if test="${circle=="Thiruvanmiyur"}">
							<option value="Thiruvanmiyur" selected="selected">Thiruvanmiyur</option>
						</g:if>
						<g:else>
							<option value="Thiruvanmiyur">Thiruvanmiyur</option>
						</g:else>
						<g:if test="${circle=="Kottivakkam"}">
							<option value="Kottivakkam" selected="selected">Kottivakkam</option>
						</g:if>
						<g:else>
							<option value="Kottivakkam">Kottivakkam</option>
						</g:else>
					</select>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="form-group">
					<label for="inputEmail3" class="control-label">City :</label> <select
						class="form-control input-lg" required="" name="city">
						<option value="Chennai" selected="selected">Chennai</option>
					</select>
				</div>
			</div>
			<g:hiddenField name="brandId" id="brand_id" value="${brandId}" />
			<g:hiddenField name="inventoryId" id="inventory_id"
				value="${inventoryId}" />
			<div class="form-group">
				<div class="col-sm-12">
					<div class="site-input-icon">
						<input name="brandName" required class="form-control input-lg"
							id="search_textField" placeholder="Enter medicine brand"
							type="text" value="${brandName}" onkeydown="onTextEnter(event)"/>
						<input class="main-input-search" name="searchButton" value=""
							type="submit" /><i class="fa fa-search"></i>
					</div>
					<!-- /input-group -->
				</div>
			</div>

			<g:if test="${brandName }">
				<br>
				<br>
				<g:message code="search.list.guide.query" args="[brandName]" />
			</g:if>

		</div>
	</g:form>
</div>


<%--<g:form class='search_form' controller="search" action="search"--%>
<%--	method="get">--%>
<%--	<table align="center" style="border-top: 0">--%>
<%--		<tr>--%>
<%--			<td id="hidden" style="width: 15%"><span class="label-control">Circle:--%>
<%--			</span></td>--%>
<%--			<td style="width: 35%"><select name="circle" required--%>
<%--				class="dropdown-control">--%>
<%--					<g:if test="${circle=="Thiruvanmiyur"}">--%>
<%--						<option value="Thiruvanmiyur" selected="selected">Thiruvanmiyur</option>--%>
<%--					</g:if>--%>
<%--					<g:else>--%>
<%--						<option value="Thiruvanmiyur">Thiruvanmiyur</option>--%>
<%--					</g:else>--%>
<%--					<g:if test="${circle=="Kottivakkam"}">--%>
<%--						<option value="Kottivakkam" selected="selected">Kottivakkam</option>--%>
<%--					</g:if>--%>
<%--					<g:else>--%>
<%--						<option value="Kottivakkam">Kottivakkam</option>--%>
<%--					</g:else>--%>
<%--			</select></td>--%>
<%----%>
<%--			<td id="hidden" style="width: 15%"><span class="label-control">City:--%>
<%--			</span></td>--%>
<%--			<td style="width: 35%"><select name="city" required--%>
<%--				class="dropdown-control">--%>
<%--					<option selected="selected" value="Chennai">Chennai</option>--%>
<%--			</select></td>--%>
<%--		</tr>--%>
<%--	</table>--%>
<%--	<div class="searchbox" align="center">--%>
<%--		<input name="brandName" required class="textbox-control"--%>
<%--			id="search_textField" placeholder="Enter medicine brand"--%>
<%--			style="height: 36px; width: 55%;" value="${brandName}"--%>
<%--			onkeydown="onTextEnter(event)" />--%>
<%--		<g:hiddenField name="brandId" id="brand_id" value="${brandId}" />--%>
<%--		<g:hiddenField name="inventoryId" id="inventory_id"--%>
<%--			value="${inventoryId}" />--%>
<%--		<input type="submit" name="searchButton" value="Search"--%>
<%--			class="btn btn-default" style="height: 44px; width: 25%;" />--%>
<%----%>
<%--		<g:if test="${brandName }">--%>
<%--			<br>--%>
<%--			<br>--%>
<%--			<g:message code="search.list.guide.query" args="[brandName]" />--%>
<%--		</g:if>--%>
<%--	</div>--%>
<%--</g:form>--%>


