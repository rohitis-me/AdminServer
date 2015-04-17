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

<div class="col-md-8 col-md-offset-2">
	<g:form class='search_form' controller="search" action="search"
		method="get">
		<div class="row clearfix">
			<div class="col-sm-6">
				<div class="form-group">
					<label for="circle" class="control-label">Circle :</label> 						
					<g:select class="form-control input-lg" required="" name="circle" from="${Constants.circleArray }" id="circleSelectBox" value="${circle}"></g:select>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="form-group">
					<label for="inputEmail3" class="control-label">City :</label> <select
						class="form-control input-lg" required="required" name="city">
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
							<div align="center">
				
				<p><g:message code="search.list.guide.query" args="[brandName]" /></p>
				</div>
			</g:if>

		</div>
	</g:form>
</div>



