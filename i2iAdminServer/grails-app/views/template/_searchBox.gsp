
<%@ page import="i2i.AdminServer.Constants"%>

<g:javascript>

            $("#search_textField").autocomplete({
        source: function(request, response) {
        	$('#spinnerSearch').show();
            $.ajax({
                url: '<g:createLink controller="search"
		action="listOfBrandNameStartingWith" />',
                dataType: "json",
                data: {
                    term: request.term,
                },
                success: function(data) {
               	 $('#spinnerSearch').hide();
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
               
<%--             $(".search_form").onsubmit(function(){--%>
<%--    			mixpanel.track("Searched for Medicine");--%>
<%--			}); --%>
			 
<%--            $(document).ready(function() {--%>
<%--		$.getJSON("http://www.telize.com/geoip?callback=?",--%>
<%--			function(json) {--%>
<%--    			alert('City: '+json.city);--%>
<%--			}--%>
<%--		);--%>
<%--	});--%>

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

<div class="col-md-10 col-md-offset-1">
	<g:form class='search_form' controller="search" action="search" method="get">
		<div class="row clearfix">
			<div class="col-sm-6">
<%--				<div class="form-group">--%>
<%--					<label for="circle" class="control-label">Circle :</label>--%>
<%--					<g:select class="form-control input-lg" required="" name="circle"--%>
<%--						from="${Constants.circleArray }" id="circleSelectBox"--%>
<%--						value="${circle}"></g:select>--%>
<%--				</div>--%>
			</div>
			<div class="col-sm-6">
<%--				<div class="form-group">--%>
<%--					<label for="inputEmail3" class="control-label">City :</label> <select--%>
<%--						class="form-control input-lg" required="required" id="citySelectBox" name="city">--%>
<%--						<option value="Chennai" selected="selected">Chennai</option>--%>
<%--						<option value="Mumbai" selected="selected">Mumbai</option>--%>
<%--					</select>--%>
<%--				</div>--%>
			</div>
			<g:hiddenField name="brandId" id="brand_id" value="${brandId}" />
			<g:hiddenField name="inventoryId" id="inventory_id"
				value="${inventoryId}" />
			<div class="form-group">
				<div class="col-sm-12">
					<div class="site-input-icon">
						<input name="brandName" required class="form-control input-lg"
							id="search_textField" placeholder="Enter medicine brand"
							type="text" value="${brandName}" onkeydown="onTextEnter(event)" />
							
							<div id="spinnerSearch" class="main-input-search" style="display:none;right: 20px;">
<%--<img src="${resource(dir: 'images', file: 'ajax-loader.gif')}" alt="Loading..." />--%>
<i class="fa fa-refresh fa-spin" style="font-size: 28px;line-height: 1.5; color: #909090;"></i>
</div>

						<input class="main-input-search" name="searchButton" value=""
							type="submit" /><i class="fa fa-search"></i>
					</div>
					<!-- /input-group -->
				</div>
			</div>
			<g:if test="${brandName }">
				<div align="center">
				<label style="margin-top: 10px;"><g:message code="search.list.guide.query"
							args="[brandName]" /></label>
				</div>
			</g:if>
		</div>
	</g:form>
</div>



