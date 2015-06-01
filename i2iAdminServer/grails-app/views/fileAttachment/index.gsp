<%@ page import="i2i.AdminServer.User.FileAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="pillocateLayout">
<g:set var="entityName"
	value="${message(code: 'fileAttachment.label', default: 'FileAttachment')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<%--<r:require modules="bootstrap-file-upload"/>--%>
<style type="text/css">
<%--
.fileUpload { --%> <%--
	position: relative; --%> <%--
	overflow: hidden; --%> <%--
	margin-left: 10%;
	--%>
	<%--
}

--%>
<%--
.fileUpload input.upload { --%> <%--
	position: absolute; --%> <%--
	top: 0; --%> <%--
	right: 0; --%> <%--
	margin: 0; --%> <%--
	padding: 0; --%> <%--
	font-size: 20px; --%> <%--
	cursor: pointer; --%> <%--
	opacity: 0; --%> <%--
	filter: alpha(opacity = 0);
	--%>
	<%--
}
--%>
</style>
</head>
<body>
	<g:render template="/template/navigationConsumer" />
	<%--<br/>--%>



	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<g:uploadForm controller="fileAttachment" action="uploadFile">

					<g:hiddenField name="quantity" value="${orderDetails?.quantity}" />
					<g:hiddenField name="brandName" value="${orderDetails.brandName}" />
					<g:hiddenField name="brandId" value="${orderDetails?.brandId }" />
					<g:hiddenField name="inventoryId"
						value="${orderDetails?.inventoryId }" />
					<g:hiddenField name="storeId" value="${orderDetails?.storeId }" />
					<g:hiddenField name="deliveryHours"
						value="${orderDetails?.deliveryHours }" />
					<g:hiddenField name="city" value="${orderDetails?.city }" />
					<g:hiddenField name="state" value="${orderDetails?.state }" />
					<g:hiddenField name="country" value="${orderDetails?.country }" />
					<g:hiddenField name="name" value="${orderDetails?.name}" />
					<g:hiddenField name="addressLine1"
						value="${orderDetails?.addressLine1}" />
					<g:hiddenField name="addressLine2"
						value="${orderDetails?.addressLine2}" />
					<g:hiddenField name="circle" value="${orderDetails?.circle}" />
					<g:hiddenField name="phoneNumber"
						value="${orderDetails?.phoneNumber}" />
					<g:hiddenField name="emailID" value="${orderDetails?.emailID}" />
					<g:hiddenField name="offerCode" value="${orderDetails?.offerCode}" />

					<div class="form-horizontal">
						<div class="panel panel-default order-panel">
							<div class="panel-heading text-center">Upload Prescription</div>
							<div class="panel-body">
								<%--                    <div class="alert alert-default">Have a complaint, suggestion or query? Write to us</div>--%>
								<div class="form-group">
									<%--									<input type="file" id="inputField" name="inputFile" accept="image/*" onchange="loadFile(event)">--%>
									<div style="width: 80%; margin-left: 10%;">
										<input type="file"
											placeholder="Upload prescription image (max size 1 MB)"
											class="filestyle" data-buttonName="btn-primary"
											id="inputField" name="inputFile" accept="image/*"
											onchange="loadFile(event)">
									</div>
									<g:if test="${flash.message}">
									<div align="center" class="message" role="status">
									<p style="color: red;">
												${flash.message}
									</p>
									</div>
								</g:if>
									<img id="output"
										style="width: 50%; margin-top: 10px; margin-left: 25%;" src="" />
								</div>

							</div>
							<div class="panel-footer clearfix">
								<div class="row">
									<div class="col-sm-offset-4 col-xs-12 col-sm-3">
										<button type="submit" class="btn btn-primary btn-block">
											<i class="glyphicon glyphicon-upload"></i>&nbsp; Upload
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
