<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="searchLayout">
<title><g:message message="i2i-Home page" /></title>
<%--<r:require module="jquery-ui" />--%>
</head>

<body>
<%--	<h2--%>
<%--		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">--%>
<%--		Could not find your medicine? Search here!</h2>--%>
<%--			<p--%>
<%--		style="text-align: center; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">--%>
<%--		online portal to locate pharmacy selling your medicine.</p>--%>
<%--	<br />--%>
<%--	<br />--%>
	<br />
	<table class="hidden" align="center" style="border-top: 0">
		<tr>
			<td style="width: 10%"><span class="label-control">Circle:</span></td>
			<td style="width: 40%"><select name="DropDownList1" required
				class="dropdown-control">
					<option selected="selected" value="Adyar">Adyar</option>
					<option value="Perungudi">Perungudi</option>
					<option value="Sholinganallur">Sholinganallur</option>
					<option value="Alandur">Alandur</option>
					<option value="Besant Nagar">Besant Nagar</option>
					<option value="Tiruvanmiyur">Tiruvanmiyur</option>
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
			<td style="width: 40%"><select name="DropDownList3" required
				class="dropdown-control">
					<option selected="selected" value="Chennai">Chennai</option>
			</select></td>
		</tr>
	</table>
	<br/>
	<g:render template="/template/searchBox"></g:render>
	<br/>
		<div style="padding-left: 10%; font-size:x-large;"><p>Find medicines near you</p></div> 
	<br />
</body>
</html>
