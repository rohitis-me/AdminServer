<!DOCTYPE html>
<html>
<head>
<g:set var="entityName"
	value="${message(code: 'profile.label', default: 'Profile')}" />
<meta name="layout" content="pillocateLayout">
<title><g:message code="title.brand.tag"/> | <g:message code="title.page.feedback"/></title>
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
          <g:form controller="SecUser" action="editProfile" method="PUT">
            <div class="form-horizontal">
              <div class="panel panel-default order-panel">
                  <div class="panel-heading text-center">My Details</div>
                    <div class="panel-body">
<%--                    <div class="alert alert-default">Have a complaint, suggestion or query? Write to us</div>--%>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger"></span> Name : </label>
                        <div class="col-sm-7">
                          <input name="username" class="form-control" placeholder="Full Name" type="text" value="${username}">
                        </div>
                      </div>
                      
                      
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger"></span> Email Id : </label>
                        <div class="col-sm-7">
                          <input class="form-control" placeholder="Email id" name="email"
							type="email" maxlength="100" value="${email}">
							
                        </div>
                      </div>
                      
                       <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger"></span> Phone No : </label>
                        <div class="col-sm-7">
                          <input class="form-control" placeholder="Phone No" name="phone"
							type="number" maxlength="100">
							
                        </div>
                      </div>
                      
<%--                      <div class="form-group">--%>
<%--                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger"></span> Phone : </label>--%>
<%--                        <div class="col-sm-7">--%>
<%--                        <textarea class="form-control" name="message"--%>
<%--							required="required"--%>
<%--							maxlength="1000" placeholder="Your's Message"></textarea>--%>
<%--                        </div>--%>
<%--                      </div>--%>
                     </div>
                    <div class="panel-footer clearfix">
                    <div class="row">
                       <div class="col-sm-offset-4 col-xs-12 col-sm-3">
<%--                        <button type="submit" class="btn btn-primary btn-block"><i class="glyphicon glyphicon-ok"></i>&nbsp; Edit</button>--%>
                       </div>
                      </div>
                    </div>
               </div>
           </div>
        </g:form>
        </div> 
      </div>
    </div>

<%--	<script>--%>
<%--		$(document).ready(function() {--%>
<%--			mixpanel.track("Clicked Feedback link");--%>
<%--		});--%>
<%--	</script>--%>
</body>
</html>
