<%@ page import="i2i.AdminServer.Constants"%>
<%@ page import="com.metasieve.shoppingcart.ShoppingCartService" %>
<%@ page import="com.metasieve.shoppingcart.SessionUtils" %>
<%
    def shoppingCartService = grailsApplication.classLoader.loadClass('com.metasieve.shoppingcart.ShoppingCartService').newInstance()
%>

<%--<r:require module="jquery"/>--%>
<%--<r:require module="jquery-ui"/>--%>
<%--<r:layoutResources/>--%>
<%--<g:javascript library="application"/>--%>

<style type="text/css">
.h-toll-free {
    color: #777;
    font-size: 14px;
    padding-top: 15px;
    padding-bottom: 15px;
    margin: 0 3px;
    display: block;
    position:relative;
}
</style>

<!-- Fixed navbar -->
<nav class="navbar navbar-default">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#site-navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${createLink(controller:'search', action:'index')}"><div class="site-logo">
					<img src="${resource(dir: 'images', file: 'logo.png')}"
						alt="pillocate logo" />
				</div></a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="site-navbar-collapse">
			<ul class="nav navbar-nav navbar-right site-home-nav">
				<g:if test="${entityName== 'i2iHome' }">
					<li class="active"><g:link controller="search" action="index">Home</g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="search" action="index">Home</g:link></li>
				</g:else>

				<g:if test="${entityName== 'TrackOrder' }">
					<li class="active"><g:link controller="orderCollection"
							action="trackOrderCollectionDetails">Track Order</g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="orderCollection" action="trackOrderCollectionDetails">Track Order</g:link></li>
				</g:else>

				<g:if test="${entityName== 'Feedback' }">
					<li class="active"><g:link controller="feedback"
							action="feedback">Feedback</g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="feedback" action="feedback">Feedback</g:link></li>
				</g:else>

				<g:set var="itemsCount" value="${0}" />
				<g:if test="${shoppingCartService && shoppingCartService.getItems()}">
				<g:set var="itemsCount" value="${shoppingCartService.getItems()?.size()}" />
				</g:if>
				<g:if test="${entityName== 'Cart' }">
					<li class="active"><g:link controller="shoppingCart"
							action="showCartItems">Cart (${itemsCount}) </g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="shoppingCart" action="showCartItems">Cart (${itemsCount})</g:link></li>
				</g:else>
				
				<sec:ifLoggedIn>
					<li><a href="${createLink(controller: 'logout')}"> Logout</a></li>
				</sec:ifLoggedIn>
				<li><p class="h-toll-free"><i class="glyphicon glyphicon-earphone"></i>${Constants.helpline }</p> </li>
				
				<g:set var="circle" value="${"Select circle"}" />
				<g:set var="session" value="${SessionUtils.getSession()}" />
				<g:if test="${session && session.circle}">
					<g:set var="circle" value="${session.circle}" />
				</g:if>
					<li class="active"><button id="locationDialog_btn" class="navbar-btn btn" style="border-radius:0px;" value="${circle}">${circle}</button></li>
<%--					style="padding-bottom: 15px;padding-top: 15px;border-radius:0px;"--%>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container -->
</nav>
<!-- Begin page content -->

<div id="dialogPlaceholder"></div>

<script type="text/javascript">
	$(document).ready(function() {
	    $("#dialogPlaceholder").dialog({
	        autoOpen: false,
	        height: "auto",
	        width: 300,
	        modal: true,
	        closeOnEscape: false,
	        draggable: false,
	        resizable: false,
	        open: function(event, ui) {
	        	  $(this).closest('.ui-dialog').find('.ui-dialog-titlebar').hide();
	        	}
	    });
	 
	    $("#locationDialog_btn").bind("click", function() {
	        $.ajax({
	            url:'<g:createLink controller="search" action="getContentForLocationDialog" />',
	            success: function(data){
	                $("#dialogPlaceholder").html(data);
	                $("#dialogPlaceholder").dialog("open");
	            }
	        });
	    });
	});
	<%--    mixpanel.track_links("#site-navbar-collapse a", "Clicked nav link", {--%>
	<%--        "referrer": document.referrer--%>
	<%--    });--%>
	</script>
	