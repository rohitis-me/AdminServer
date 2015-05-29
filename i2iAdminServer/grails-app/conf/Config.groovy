import i2i.AdminServer.Constants

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = [
	'Gecko',
	'WebKit',
	'Presto',
	'Trident'
]
grails.mime.types = [ // the first one is the default format
	all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
	atom:          'application/atom+xml',
	css:           'text/css',
	csv:           'text/csv',
	form:          'application/x-www-form-urlencoded',
	html:          [
		'text/html',
		'application/xhtml+xml'
	],
	js:            'text/javascript',
	json:          [
		'application/json',
		'text/json'
	],
	multipartForm: 'multipart/form-data',
	rss:           'application/rss+xml',
	text:          'text/plain',
	hal:           [
		'application/hal+json',
		'application/hal+xml'
	],
	xml:           [
		'text/xml',
		'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// set variables
turnOnTestCode = 0
turnOnBootStrapCode = 0

//enableProdConfig = 0
env=Constants.env_LOCAL

if(env == Constants.env_DEMO) {
	Constants.envLink= Constants.envLink_DEMO
	Constants.analyticsTrackingId =  Constants.analyticsTrack_DEMO
}
else if(env == Constants.env_PROD) {
	Constants.envLink= Constants.envLink_PROD
	Constants.analyticsTrackingId =  Constants.analyticsTrack_PROD
}
else if(env == Constants.env_LOCAL) {
	Constants.envLink= Constants.envLink_LOCAL
}
//grails.mail.host = "192.168.2.8"

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = [
	'/images/*',
	'/css/*',
	'/js/*',
	'/plugins/*',
	'/fonts/*'
]
grails.resources.adhoc.includes = [
	'/images/**',
	'/css/**',
	'/js/**',
	'/plugins/**',
	'/fonts/**'
]

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
	views {
		gsp {
			encoding = 'UTF-8'
			htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
			codecs {
				expression = 'html' // escapes values inside ${}
				scriptlet = 'html' // escapes output from scriptlets in GSPs
				taglib = 'none' // escapes output from taglibs
				staticparts = 'none' // escapes output from static template parts
			}
		}
		// escapes all not-encoded output at final stage of outputting
		// filteringCodecForContentType.'text/html' = 'html'
	}
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
	development {
		grails.logging.jul.usebridge = true
	}
	production {
		grails.logging.jul.usebridge = false
		// TODO: grails.serverURL = "http://www.changeme.com"
	}
}

// log4j configuration
log4j = {
	// Example of changing the log pattern for the default console appender:
	//
	//appenders {
	//    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
	//}

	//	appenders {
	//		file name: "searchtxt", file: "/var/log/search.logs"
	//		file name: "orderstxt", file: "/var/log/orders.logs"
	//	 }
	//
	//	debug searchtxt: "i2i.AdminServer.SearchController",
	//		  orderstxt: "i2i.AdminServer.OrdersController"

	error  'org.codehaus.groovy.grails.web.servlet',        // controllers
			'org.codehaus.groovy.grails.web.pages',          // GSP
			'org.codehaus.groovy.grails.web.sitemesh',       // layouts
			'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
			'org.codehaus.groovy.grails.web.mapping',        // URL mapping
			'org.codehaus.groovy.grails.commons',            // core / classloading
			'org.codehaus.groovy.grails.plugins',            // plugins
			'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
			'org.springframework',
			'org.hibernate',
			'net.sf.ehcache.hibernate'
}


// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/secUser/showHomePage/'
grails.plugin.springsecurity.logout.afterLogoutUrl = '/search/index/'
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.userLookup.userDomainClassName = 'i2i.AdminServer.User.Sec.SecUser'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'i2i.AdminServer.User.Sec.SecUserSecRole'
grails.plugin.springsecurity.authority.className = 'i2i.AdminServer.User.Sec.SecRole'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/**':                              ['permitAll']]

//Added by the Spring Security ui plugin:
grails.plugin.springsecurity.ui.register.postRegisterUrl = '/'
grails.plugin.springsecurity.ui.register.postResetUrl = '/'
//grails.plugin.springsecurity.ui.register.emailBody = '...'
//grails.plugin.springsecurity.ui.register.emailFrom = '...'
//grails.plugin.springsecurity.ui.register.emailSubject = '...'
grails.plugin.springsecurity.ui.register.defaultRoleNames = [
	'ROLE_CONSUMER'] //FIX ME remove later
grails.plugin.springsecurity.ui.password.validationRegex = '^.*(?=.*\\d)(?=.*[a-zA-Z]).*$'
grails.plugin.springsecurity.ui.password.minLength = 5
grails.plugin.springsecurity.ui.password.maxLength = 20
//grails.plugin.springsecurity.controllerAnnotations.staticRules = [
//	'/**':                              ['permitAll'],
//	'/index':                         ['permitAll'],
//	'/index.gsp':                     ['permitAll'],
//	'/assets/**':                     ['permitAll'],
//	'/**/js/**':                      ['permitAll'],
//	'/**/css/**':                     ['permitAll'],
//	'/**/images/**':                  ['permitAll'],
//	'/**/favicon.ico':                ['permitAll']
//]

//grails {
//	mail {
//		host = "smtp.gmail.com"
//		port = 465
//		if(env == Constants.env_PROD)
//			username = "i2itechnologypvtltd@gmail.com"
//		else
//			username = "noreply.pillocate@gmail.com"
//		password = "support@i2i"
//		props = ["mail.smtp.auth":"true",
//			"mail.smtp.socketFactory.port":"465",
//			"mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
//			"mail.smtp.socketFactory.fallback":"false"]
//	}
//}

grails {
	mail {
	  host = "smtp.zoho.com"
	  username = "support@i2itech.co.in"
	  password = "support@123"
	  port = 465
	  props = ["mail.smtp.auth":"true",
			   "mail.smtp.socketFactory.port":"465",
			   "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
			   "mail.smtp.socketFactory.fallback":"false"]
	}
  }

//grails {
//	plugin {
//	   aws {
//		  credentials {
//			 accessKey = "AKIAILAGOAL2JOETQC7Q"
//			 secretKey = "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"
//		  }
//		  s3 {
//			  bucket = "testi2i"
//			  bucketLocation = 'ap-southeast-1'
//			  acl = "public"
//		   }
//	   }
//	}
// }

grails {
	plugin {
		awssdk {
			accessKey = "AKIAILAGOAL2JOETQC7Q"    // Default access key
			secretKey = "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"    // Default secret key
			region = 'AP_Singapore'        // Default region
			s3 {}
			// Proxy settings
			proxyHost = '10.200.1.26'
			proxyPort = 8080
		}
	}
}

//grails.plugin.awssdk.accessKey = "AKIAILAGOAL2JOETQC7Q"
//grails.plugin.awssdk.secretKey = "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"
//grails.plugin.awssdk.region = 'AP_Singapore'

