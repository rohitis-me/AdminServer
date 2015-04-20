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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-theme.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'font-awesome.css')}" type="text/css">
<g:javascript library="application" />
<r:require module="jquery-ui" />
<g:layoutHead />
<r:layoutResources />

<%--<!-- Google Analytics -->--%>
<%--<script>--%>
<%--  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){--%>
<%--  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),--%>
<%--  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)--%>
<%--  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');--%>
<%----%>
<%--  ga('create', '${Constants.analyticsTrackingId}', 'auto');--%>
<%--  ga('send', 'pageview');--%>
<%--</script>--%>
<%--<!-- End Google Analytics -->--%>
<%--<!-- OPENTRACKER START -->--%>
<%--<script defer--%>
<%--	src="https://script.opentracker.net/?site=demo.pillocate.com"></script>--%>
<%--<!-- OPENTRACKER END -->--%>

	<script src="${resource(dir: 'js', file: '1.11.2.jquery.min.js')}"></script>
	<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
	<script src="${resource(dir: 'js', file: 'npm.js')}"></script>
	<script src="${resource(dir: 'js', file: 'site-min.js')}"></script>
</head>
<body>
	<%--	<div class="headerBanner" id="headerdiv" role="banner">pillocate--%>
	<%--		(Beta)</div>--%>
	<%--	<br />--%>
	<g:layoutBody />
	<footer class="footer clearfix">
		<ul class="footer-link text-center">
			<li><a href="">About Us</a></li>
			<li><a href="">Contact Us</a></li>
			<li><a href="">Terms &amp; Conditions</a></li>
			<li><a href="">Privacy Policy</a></li>
		</ul>
		<article class="Footer-social clearfix">
			<ul>
				<li><a class="Twitter" href="#"></a></li>
				<li><a class="Facebook" href="#"></a></li>
				<li><a class="Google" href="#"></a></li>
				<li><a class="Pinterest" href="#"></a></li>
			</ul>
			<div class="Footer-so-line"></div>
		</article>
		<div class="container">
			<p class="float-left copyright">© 2015 pillocate.com All rights
				reserved.</p>
			<p class="float-right design">
				Design &amp; Developed By - <a class="design"
					href="http://deenwebindia.com/" target="_blank">Deenwebindia
					Technologies</a>
			</p>
		</div>
	</footer>

	<a data-placement="left" data-toggle="tooltip" title="Back to top"
		role="button" class="btn btn-default back-to-top btn-bg" href="#"
		id="back-to-top"><span class="glyphicon glyphicon-chevron-up"></span></a>


	<r:layoutResources />
</body>
</html>
