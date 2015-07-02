<%@ page import="i2i.AdminServer.Constants"%>
<html>
<head>
<title>Pillocate | Home</title>
<g:set var="entityName"
	value="${message(code: 'i2i.home.label', default: 'i2iHome')}" />
<meta name="layout" content="pillocateLayout">

<%--<r:require module="jquery"/>--%>
<%--<r:require module="jquery-ui"/>--%>
<%--<r:layoutResources/>--%>
<%--<g:javascript library="application"/>--%>

<style type="text/css">

</style>

</head>

<body>
	<g:render template="/template/navigationConsumer" />


	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<g:form controller="search" action="saveLocation">
					<div class="row clearfix">
						<h4>Select Your City</h4>
						<%--			<div class="col-sm-6">--%>
						<div class="form-group" style="width: 80%;">
							<%--					<label for="inputEmail3" class="control-label">City :</label> --%>
							<select class="form-control input-lg" required="required"
								id="citySelectBox" name="city">
								<%--						<option value="Chennai" selected="selected">Chennai</option>--%>
								<option value="Mumbai" selected="selected">Mumbai</option>
							</select>
						</div>
						<%--			</div>--%>
						<h4>Select Your Area</h4>
						<%--			<div class="col-sm-6">--%>
						<div class="form-group" style="width: 80%;">
							<%--					<label for="circle" class="control-label">Circle :</label>--%>
							<g:select class="form-control input-lg" required="" name="circle"
								from="${Constants.circleArray }" id="circleSelectBox"
								value="${circle}"></g:select>
							<%--				</div>noSelection="['null':'-Choose your Area-']"--%>
						</div>
					</div>
					<div class="col-sm-offset-3 col-xs-6 col-sm-3">
						<button type="submit" class="btn btn-primary btn-block">
							<i class="glyphicon glyphicon-ok"></i> Enter
						</button>
					</div>
				</g:form>
			</div>
		</div>
	</div>
<%--<button id="trigger_btn" value="open popup">open opoup</button>--%>
<%--<div id="dialogPlaceholder"></div>--%>
<%----%>
<%----%>
<%--	<script>--%>
<%----%>
<%--	$(document).ready(function() {--%>
<%--	    $("#dialogPlaceholder").dialog({--%>
<%--	        autoOpen: false,--%>
<%--	        height: 200,--%>
<%--	        width: 350,--%>
<%--	        modal: true,--%>
<%--	        title: '',--%>
<%--	        close: function(){--%>
<%--	            $("#dialogPlaceholder").html('');--%>
<%--	        }--%>
<%--	    });--%>
<%--	 --%>
<%--	    $("#trigger_btn").bind("click", function() {--%>
<%--	        $.ajax({--%>
<%--	            url:'/i2iAdminServer/search/getContentForDialog',--%>
<%--	            success: function(data){--%>
<%--	                $("#dialogPlaceholder").html(data);--%>
<%--	                $("#dialogPlaceholder").dialog("open");--%>
<%--	            }--%>
<%--	        });--%>
<%--	    });--%>
<%--	 --%>
<%--	});	--%>
<%--	</script>--%>

</body>
</html>
