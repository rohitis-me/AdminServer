<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<title><g:message message="i2i-Home page" /></title>
<r:require module="jquery-ui" />
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
<r:layoutResources/>
</head>

<body>
	<h2
		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
		Could not find your medicine? Search here!</h2>
			<p
		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
		online portal to locate pharmacy selling your medicine.</p>
	<br />
	<br />
	<br />
	<table align="center" style="border-top: 0">
		<tr>
			<td style="width: 15%"><span id="Label1" class="label-control">State
			</span></td>
			<td><select name="DropDownList1" required
				class="dropdown-control" id="DropDownList1">
					<option selected="selected" value="TamilNadu">TamilNadu</option>
			</select></td>
		</tr>
		<tr>
			<td style="width: 15%"><span id="Label2" class="label-control">City
			</span></td>
			<td><select name="DropDownList3" required
				class="dropdown-control" id="DropDownList3">
					<option selected="selected" value="Chennai">Chennai</option>
			</select></td>
		</tr>
	</table>
	<br />
	<br />
	<g:form controller="search" action="search" method="get">
		<div class="searchbox" align="center">
			<input name="brandName" required="" class="textbox-control" id="search_textField"
				placeholder="Enter medicine brand" style="width: 60%;" />
				<g:hiddenField name="brandId" id="brand_id" value=""/>
			<br /> <br /> <input type="submit" name="Button1" value="Search"
				id="Button1" class="btn btn-default"
				style="height: 44px; width: 20%;" />
		</div>
	</g:form>
</body>
</html>
