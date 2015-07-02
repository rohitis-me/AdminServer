<%@ page import="i2i.AdminServer.Constants"%>
<%--<div id="myform">--%>
<%--    <div>${now}</div>--%>
<%--<div class="container">--%>
<%--		<div class="row">--%>
<%--			<div class="col-md-10 col-md-offset-1">--%>
				<g:form controller="search" action="saveLocation">
					<div class="row clearfix">
						<h4>Select Your City</h4>
						<div class="form-group">
							<%--					<label for="inputEmail3" class="control-label">City :</label> --%>
							<select class="form-control" required="required"
								id="citySelectBox" name="city">
								<%--						<option value="Chennai" selected="selected">Chennai</option>--%>
								<option value="Mumbai" selected="selected">Mumbai</option>
							</select>
						</div>
						<h4>Select Your Area</h4>
						<div class="form-group">
							<%--					<label for="circle" class="control-label">Circle :</label>--%>
							<g:select class="form-control" required="" name="circle"
								from="${Constants.circleArray }" id="circleSelectBox"
								value="${circle}"></g:select>
							<%--				</div>noSelection="['null':'-Choose your Area-']"--%>
						</div>
					</div>
					<div class="col-sm-offset-3 ">
						<button type="submit" class="btn btn-primary btn-block">
							<i class="glyphicon glyphicon-ok"></i> Enter
						</button>
					</div>
				</g:form>
<%--			</div>--%>
<%--		</div>--%>
<%--	</div>--%>
<%--</div>--%>



