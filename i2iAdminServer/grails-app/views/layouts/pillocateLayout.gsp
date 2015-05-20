<%@ page import="i2i.AdminServer.Constants"%>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="i2i" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="">
<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/x-icon">
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'font-awesome.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
<g:javascript library="application" />

<!-- Google Analytics -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', '${Constants.analyticsTrackingId}', 'auto');
  ga('send', 'pageview');
</script>
<!-- End Google Analytics -->
<!-- start Mixpanel -->
<g:if test="${grailsApplication.config.env == Constants.env_PROD}">
<script type="text/javascript">(function(f,b){if(!b.__SV){var a,e,i,g;window.mixpanel=b;b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.union people.track_charge people.clear_charges people.delete_user".split(" ");
for(g=0;g<i.length;g++)f(c,i[g]);b._i.push([a,e,d])};b.__SV=1.2;a=f.createElement("script");a.type="text/javascript";a.async=!0;a.src="undefined"!==typeof MIXPANEL_CUSTOM_LIB_URL?MIXPANEL_CUSTOM_LIB_URL:"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";e=f.getElementsByTagName("script")[0];e.parentNode.insertBefore(a,e)}})(document,window.mixpanel||[]);
mixpanel.init("124b937fb93313a62e4857cf8a366b41");</script>
</g:if>
<!-- end Mixpanel -->

<!-- DESIGN START -->
	<script src="${resource(dir: 'js', file: '1.11.2.jquery.min.js')}"></script>
	<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
	<script src="${resource(dir: 'js', file: 'site-min.js')}"></script>
<!-- DESIGN END -->
<r:require module="jquery-ui" />
<g:layoutHead />
<r:layoutResources />
</head>
<body>
	<g:layoutBody />
	
	<footer class="footer clearfix">
   <ul class="footer-link text-center">
<%--        <li><a href="">About Us</a></li>--%>
        <li><a href="${createLink(controller:'feedback', action:'feedback')}">Contact Us</a></li>
        <li><a href="${createLink(uri:'/termsConditions')}">Terms &amp; Conditions</a></li>
        <li><a href="${createLink(uri:'/privacyPolicy')}">Privacy Policy</a></li>     
    </ul>
<%--    <article class="Footer-social clearfix">--%>
<%--        <ul>--%>
<%--            <li><a class="Twitter" href="#"></a></li>--%>
<%--            <li><a class="Facebook" href="#"></a></li>--%>
<%--            <li><a class="Google" href="#"></a></li>--%>
<%--            <li><a class="Pinterest" href="#"></a></li>--%>
<%--        </ul>--%>
<%--        <div class="Footer-so-line"></div>--%>
<%--    </article>--%>
		<div class="container">
			<p class="float-left copyright">© 2015 pillocate.com All rights
				reserved.</p>
		</div>
	</footer>

	<a data-placement="left" data-toggle="tooltip" title="Back to top"
		role="button" class="btn btn-default back-to-top btn-bg" href="#"
		id="back-to-top"><span class="glyphicon glyphicon-chevron-up"></span></a>


	<r:layoutResources />
</body>
</html>
