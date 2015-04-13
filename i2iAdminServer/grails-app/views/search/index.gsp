<!DOCTYPE html>
<html>
<head>
<title>pillocate | Home</title>
<g:set var="entityName"
	value="${message(code: 'i2i.home.label', default: 'i2iHome')}" />
<meta name="layout" content="pillocateLayout">
</head>

<body>
	<g:render template="/template/navigationConsumer" />

    <div class="container">
       <h1 class="site-header">Online portal to find medicines near you </h1>
       <div class="row">
        
        <g:render template="/template/searchBox"></g:render>
        
        <div class="col-md-8 col-md-offset-2">
         </div>
          <div class="info-delivered-widget">
            <div class="col-md-8 col-md-offset-2">
              <div class="well well-sm text-center">
                <p>Enter Your Location  /Circle</p> 
                <p>Enter name of Medicine </p>
                <p>Place order &amp; medicine will be delivered home </p>
                <div class="division">
                    <div class="line l"></div>
                      <span>or</span>
                    <div class="line r"></div>
                </div>
                <p class="call-us"><i class="fa fa-phone-square"></i> Call us/ <span class="text-success"><i class="fa fa-whatsapp"></i> whatsapp</span>/ <span class="text-primary"><i class="fa fa-mobile"></i> SMS on <span class="text-">99999 99999</span></span> to <br><span class="text-order">Place your order now!</span></p>
              </div>
            </div>
         </div>
</div>
     
    </div>
    
<%--	<g:render template="/template/navigationConsumer" />--%>
<%----%>
<%--	<g:render template="/template/searchBox"></g:render>--%>
<%--	<br />--%>
<%--	<div style="padding-left: 10%; font-size: x-large;">--%>
<%--		<p>--%>
<%--			<g:message code="search.intro.message"--%>
<%--				default="Online portal to find medicines near you" />--%>
<%--		</p>--%>
<%--	</div>--%>
<%--	<br />--%>
</body>
</html>
