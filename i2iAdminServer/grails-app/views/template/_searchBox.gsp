	<%@ page import="i2i.AdminServer.Constants"%>
	
<g:javascript>
            $(document).ready(function() {
            
                $("#search_textField").autocomplete({
        source: function(request, response) {
            $.ajax({
                url: '<g:createLink controller="search"
		action="listOfBrandNameStartingWith" />',
                dataType: "json",
                data: {
                    term: request.term,
                    circle: $("#circleSelectBox").val(), 
                },
                success: function(data) {
                    response(data);
                }
            });
        },
        
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
<g:form class='search_form' controller="search" action="search"
	method="get">
	<table align="center" style="border-top: 0">
		<tr>
			<td id="hidden" style="width: 15%"><span class="label-control">Circle:
			</span></td>
			<td style="width: 35%">
			<g:select name="circle" from="${Constants.circleArray }" id="circleSelectBox" value="${circle }"/>
<%--			<select name="circle" required--%>
<%--				class="dropdown-control">--%>
<%--				<g:each in="${Constants.circleArray }" var="circleName">--%>
<%--					<g:if test="${circle== circleName}">--%>
<%--						<option value="${circleName }" selected="selected">${circleName }</option>--%>
<%--					</g:if>--%>
<%--					<g:else>--%>
<%--						<option value="${circleName }">${circleName }</option>--%>
<%--					</g:else>--%>
<%--				</g:each>--%>
<%--					--%>
<%--			</select>--%>
			</td>

			<td id="hidden" style="width: 15%"><span class="label-control">City:
			</span></td>
			<td style="width: 35%"><select name="city" required
				class="dropdown-control">
					<option selected="selected" value="Chennai">Chennai</option>
			</select></td>
		</tr>
	</table>
	<div class="searchbox" align="center">
		<input name="brandName" required class="textbox-control"
			id="search_textField" placeholder="Enter medicine brand"
			style="height: 36px; width: 55%;" value="${brandName}"
			onkeydown="onTextEnter(event)" />
		<g:hiddenField name="brandId" id="brand_id" value="${brandId}" />
		<g:hiddenField name="inventoryId" id="inventory_id"
			value="${inventoryId}" />
		<input type="submit" name="searchButton" value="Search"
			class="btn btn-default" style="height: 44px; width: 25%;" />

		<g:if test="${brandName }">
			<br>
			<br>
			<g:message code="search.list.guide.query" args="[brandName]" />
		</g:if>
	</div>
</g:form>