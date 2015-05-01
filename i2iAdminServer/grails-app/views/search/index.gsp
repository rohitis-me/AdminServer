<!DOCTYPE html>
<html>
<head>
<title>Pillocate | Home</title>
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
                <p>Select Your Circle</p> 
                <p>Enter name of Medicine </p>
                <p>Place order &amp; get medicine delivered in hours! </p>
              </div>
            </div>
         </div>
</div>
     
    </div>
    

</body>
</html>
