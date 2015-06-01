<%@ page import="i2i.AdminServer.Constants"%>
<html>
<head>
<title>Pillocate | Home</title>
<g:set var="entityName"
	value="${message(code: 'i2i.home.label', default: 'i2iHome')}" />
<meta name="Description"
	content="Get medicines delivered- Quick and Seamless">
<meta name="layout" content="pillocateLayout">
</head>

<body>
	<g:render template="/template/navigationConsumer" />


	<div class="container">
		<h1 class="site-header">Online portal to find medicines near you
		</h1>
		<div class="row">


			<g:render template="/template/searchBox"></g:render>
			

			<div class="col-md-8 col-md-offset-2"></div>
			<div class="info-delivered-widget">
				<div class="col-md-10 col-md-offset-1">
					<div class="well well-sm text-center">
						<p>Select Your Circle</p>
						<p>Enter name of Medicine</p>
						<p>Place order &amp; get medicine delivered in hours!</p>
						<div class="division">
							<div class="line l"></div>
							<span>or</span>
							<div class="line r"></div>
						</div>
						<p class="call-us">
							<i class="fa fa-phone-square"></i> Call us/ <span
								class="text-success"><i class="fa fa-whatsapp"></i>
								whatsapp</span>/ <span class="text-primary"><i
								class="fa fa-mobile"></i> SMS on <span class="text-">${Constants.helpline }</span></span>
							to <br>
							<span class="text-order"
								style="font-family: Helvetica, Arial, sans-serif">Place
								your order now!</span>
						</p>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script>
		$(document).ready(function() {
			mixpanel.track("New Session");
		});
<%--		$('#reg_submit').click(function() {--%>
<%--		    $('#reg_user_name').val($('#reg_email').val());--%>
<%--		    $('#registerForm').submit();--%>
<%--		    });--%>

	</script>
	
</body>
</html>
