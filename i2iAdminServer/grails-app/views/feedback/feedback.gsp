<!DOCTYPE html>
<html>
<head>
<g:set var="entityName"
	value="${message(code: 'feedback.label', default: 'Feedback')}" />
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
          <g:form controller="feedback" action="sendFeedback" method="PUT">
            <div class="form-horizontal">
              <div class="panel panel-default order-panel">
                  <div class="panel-heading text-center">Feedback</div>
                    <div class="panel-body">
                    <div class="alert alert-default">Have a complaint, suggestion or query? Write to us</div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger">*</span> Name : </label>
                        <div class="col-sm-7">
                          <input name="name" class="form-control" required="required" placeholder="Full Name" type="text">
                        </div>
                      </div>
                      
                      
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger"></span> Email Id : </label>
                        <div class="col-sm-7">
                          <input class="form-control" placeholder="Email id" name="emailID"
							type="email" maxlength="100">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label"><span class="text-danger">*</span> Message : </label>
                        <div class="col-sm-7">
                        <textarea class="form-control" name="message"
							required="required"
							maxlength="1000" placeholder="Your's Message"></textarea>
                        </div>
                      </div>
                     </div>
                    <div class="panel-footer clearfix">
                    <div class="row">
                       <div class="col-sm-offset-4 col-xs-12 col-sm-3">
                        <button type="submit" class="btn btn-primary btn-block"><i class="glyphicon glyphicon-ok"></i>&nbsp; Submit</button>
                       </div>
                      </div>
                    </div>
               </div>
           </div>
        </g:form>
        </div> 
      </div>
    </div>
    
<%--	<br />--%>
<%--<p align="center">Have a complaint, suggestion or query?--%>
<%--Write to us</p>--%>
<%--<br/>--%>
<%--	<g:form controller="feedback" action="sendFeedback" method="PUT">--%>
<%--		<table align="center" style="border-top: 0">--%>
<%--			<tbody>--%>
<%--				<tr>--%>
<%--					<td style="width: 25%"><label class="label-control"><g:message--%>
<%--								code="default.name.label" default="Name *" /></label></td>--%>
<%--					<td><g:textField name="name" class="textbox-control"--%>
<%--							required="required" /></td>--%>
<%--				</tr>--%>
<%--				<tr>--%>
<%--					<td><label class="label-control"><g:message--%>
<%--								code="patientProfile.emailID.label" default="Email Id" /></label></td>--%>
<%--					<td><g:field class="textbox-control" name="emailID"--%>
<%--							type="email" maxlength="100"/></td>--%>
<%--				</tr>--%>
<%--				<tr>--%>
<%--					<td><label class="label-control">Message *</label></td>--%>
<%--					<td><g:textArea class="textbox-control" name="message"--%>
<%--							required="required"--%>
<%--							maxlength="1000" /></td>--%>
<%--				</tr>--%>
<%--			</tbody>--%>
<%--		</table>--%>
<%--		<div align="center">--%>
<%--			<g:submitButton name="Submit"--%>
<%--				value="${message(code: 'default.button.submit.label', default: 'Submit')}"--%>
<%--				class="btn btn-default" />--%>
<%--		</div>--%>
<%--	</g:form>--%>
<%--	<br />--%>
</body>
</html>
