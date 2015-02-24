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
	<br />
	<table class="hidden" align="center" style="border-top: 0">
		<tr>
			<td style="width: 10%"><span class="label-control">Circle:</span></td>
			<td style="width: 40%"><select name="circle" required
				class="dropdown-control">
					<option selected="selected" value="Adyar">Adyar</option>
					<option value="Perungudi">Perungudi</option>
					<option value="Sholinganallur">Sholinganallur</option>
					<option value="Alandur">Alandur</option>
					<option value="Besant Nagar">Besant Nagar</option>
					<option value="Thiruvanmiyur">Thiruvanmiyur</option>
					<option value="Saidapet">Saidapet</option>
					<option value="Guindy">Guindy</option>
					<option value="Madipakkam">Madipakkam</option>
					<option value="Nanganallur">Nanganallur</option>
					<option value="Velachery">Velachery</option>
					<option value="Pallikaranai">Pallikaranai</option>
					<option value="Thoraipakkam">Thoraipakkam</option>
					<option value="Neelankarai">Neelankarai</option>
			</select></td>

			<td style="width: 10%"><span class="label-control">City:
			</span></td>
			<td style="width: 40%"><select name="city" required
				class="dropdown-control">
					<option selected="selected" value="Chennai">Chennai</option>
			</select></td>
		</tr>
	</table>
	<br/>
		<div class="searchbox" align="center">
			<input name="brandName" required="" class="textbox-control" id="search_textField"
				placeholder="Enter medicine brand" style="width: 55%;" value="${brandName}" />
				<g:hiddenField name="brandId" id="brand_id" value="${brandId}"/>
			 <input type="submit" name="Button1" value="Search"
				id="Button1" class="btn btn-default"
				style="height: 44px; width: 25%;" />
		</div>
</g:form>