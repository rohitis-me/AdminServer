<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<title><g:message message="i2i-Home page" /></title>
</head>

<body>
	<h2
		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
		Could not find your medicine? Search here!</h2>
	<br />
	<br />
	<table align="center" style="border-top: 0";>
			<tr>
				<td style="width: 15%"><span id="Label1" class="label-control">State
				</span></td>
				<td><select name="DropDownList1" required
					class="dropdown-control" id="DropDownList1">
						<option selected="selected" value="TamilNadu">TamilNadu</option>
				</select></td>
			</tr>
			<tr>
				<td style="width: 15%">&nbsp;</td>
				<td>&nbsp;</td>
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
			<g:textField name="brandName" required="" class="textbox-control"
				hint="Please enter medicine name" id="TextBox1" style="width: 60%;" />
			<br />
			<br /> <input type="submit" name="Button1" value="Search"
				id="Button1" class="btn btn-default"
				style="height: 44px; width: 20%;" />
		</div>
	</g:form>
</body>
</html>
