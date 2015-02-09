<g:javascript>
            $(document).ready(function() {
                $('#search_textField').autocomplete({
                
                      source: '<g:createLink controller="search" action="listOfBrandNameStartingWith" />',
                      
                      select: function (event, ui){
                      console.log("selected id:" + ui.item.id);
                      console.log("selected name:" + ui.item.value);
                      $('#search_textField').val(ui.item.name);
                      $('#brand_id').val(ui.item.id);
                } 
                });
            });
</g:javascript>
<g:form controller="search" action="search" method="get">
		<div class="searchbox" align="center">
			<input name="brandName" required="" class="textbox-control" id="search_textField"
				placeholder="Enter medicine brand" style="width: 60%;" />
				<g:hiddenField name="brandId" id="brand_id" value=""/>
			 <input type="submit" name="Button1" value="Search"
				id="Button1" class="btn btn-default"
				style="height: 44px; width: 20%;" />
		</div>
</g:form>