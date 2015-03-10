<g:javascript>
            $(document).ready(function() {
                $('#search_textField').autocomplete({
                
                      source: '<g:createLink controller="search" action="listOfBrandNameStartingWith" />',
                                            
                      select: function (event, ui){
                      $('#search_textField').val(ui.item.label);
                      $('#inventory_id').val(ui.item.id);
                      $('#brand_id').val(ui.item.name);
                } 
                });
            });
            function onTextEnter() {
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
<g:form controller="search" action="search" method="get">
	<br />
	<table align="center" style="border-top: 0">
		<tr>
			<td id="hidden" style="width: 10%"><span class="label-control">Circle*</span></td>
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

			<td id="hidden" style="width: 10%"><span class="label-control">City*
			</span></td>
			<td style="width: 40%"><select name="city" required
				class="dropdown-control">
					<option selected="selected" value="Chennai">Chennai</option>
			</select></td>
		</tr>
	</table>
	<br/>
		<div class="searchbox" align="center">
			<input name="brandName" required class="textbox-control" id="search_textField"
				placeholder="Enter medicine brand" style="height:36px; width: 55%;" value="${brandName}" onkeydown="onTextEnter()"/>
				<g:hiddenField name="brandId" id="brand_id" value="${brandId}"/>
				<g:hiddenField name="inventoryId" id="inventory_id" value="${inventoryId}"/>
			 <input type="submit" name="searchButton" value="Search"
				class="btn btn-default"
				style="height: 44px; width: 25%;" />
		</div>
</g:form>