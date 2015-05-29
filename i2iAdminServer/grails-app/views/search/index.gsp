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
			
			<div class="divButtons">
				<a data-toggle="modal" href="#windowTitleDialog" class="btn btn-primary btn-large">Set Window Title</a>
			</div>
			
			<div id="windowTitleDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="windowTitleLabel" aria-hidden="true">
				<div class="modal-header">
					<a href="#" class="close" data-dismiss="modal">&times;</a>
					<h3>Please enter a new title for this window.</h3>
					</div>
				<div class="modal-body">
					<div class="divDialogElements">
						<input class="xlarge" id="xlInput" name="xlInput" type="text" />
						</div>
					</div>
				<div class="modal-footer">
					<a href="#" class="btn" onclick="closeDialog ();">Cancel</a>
					<a href="#" class="btn btn-primary" onclick="okClicked ();">OK</a>
				</div>
			</div>
			

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
								class="fa fa-mobile"></i> SMS on <span class="text-">+91-9591729831</span></span>
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
	<script>
			$(document).ready(function() {
				$('#windowTitleDialog').bind('show', function () {
					document.getElementById ("xlInput").value = document.title;
					});
				});
			function closeDialog () {
				$('#windowTitleDialog').modal('hide'); 
				};
			function okClicked () {
				document.title = document.getElementById ("xlInput").value;
				closeDialog ();
				};
			</script>
	
</body>
</html>
