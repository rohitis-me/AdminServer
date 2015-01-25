<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="searchLayout">
		<title><g:message message="Search" /></title>
	</head>
	
	<body>	
	<table align="center" width="400px"><tr><br><br><br><h1><g:message message="Medicine availability" /></h1></tr></table>
		<div id="show-billing" class="content scaffold-show" role="main">
		
		<g:form controller="search" action="search" method="get">
		
		<table cellpadding=0 cellspacing=0 class="form_table" align="center">
		<tr>
		<td class="form_td_left">
		<g:textField name="brandName" required="" />
		</td>
		
		<td class="form_td_right">
		<input type="submit" value="Search">
		</td>
		</tr>
		</table>
		
		</g:form>
			
			
		</div>
	</body>
</html>
