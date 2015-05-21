<%@ page import="i2i.AdminServer.User.FileAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'fileAttachment.label', default: 'FileAttachment')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<%--<r:require modules="bootstrap-file-upload"/>--%>
</head>
<body>
	<g:render template="/template/navigationConsumer" />
	<%--<br/>--%>
	<g:if test="${flash.message}">
		<div align="center" class="message" role="status">
			${flash.message}
		</div>
	</g:if>


	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<g:uploadForm controller="fileAttachment" action="uploadWithDefaultProperties">
					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<div class="panel-heading text-center">Upload Prescription</div>
							<div class="panel-body">
								<%--                    <div class="alert alert-default">Have a complaint, suggestion or query? Write to us</div>--%>
								<div class="form-group">

									<input type="file" id="inputField" name="inputFile" accept="image/*" onchange="loadFile(event)">
									<img id="output" style="width:60%; margin-top:10px; margin-left: 20%;"  src="" />

								</div>
<%--<div class="form-group">--%>
<%--<bsfu:fileUpload action="upload" controller="image"/>--%>
<%--</div>--%>



							</div>
							<div class="panel-footer clearfix">
								<div class="row">
									<div class="col-sm-offset-4 col-xs-12 col-sm-3">
										<button type="submit" class="btn btn-primary btn-block">
											<i class="glyphicon glyphicon-ok"></i>&nbsp; Upload
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</g:uploadForm>
			</div>
		</div>
	</div>
<%--<bsfu:imageGallery/>--%>
	<script>
		var loadFile = function(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var output = document.getElementById('output');
				output.src = reader.result;
			};
			reader.readAsDataURL(event.target.files[0]);
		};
	</script>

</body>
</html>
