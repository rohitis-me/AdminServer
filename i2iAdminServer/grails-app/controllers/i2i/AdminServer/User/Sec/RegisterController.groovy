package i2i.AdminServer.User.Sec

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.authentication.dao.NullSaltSource
import grails.plugin.springsecurity.ui.RegisterCommand
import grails.plugin.springsecurity.ui.RegistrationCode

import com.metasieve.shoppingcart.SessionUtils

class RegisterController extends grails.plugin.springsecurity.ui.RegisterController {

	@Override
	def index() {
		def copy = [:] + (flash.chainedParams ?: [:])
		copy.remove 'controller'
		copy.remove 'action'
		String postUrl = "${request.contextPath}${conf.apf.filterProcessesUrl}"
		render view: '/login/auth', model: [postUrl:postUrl, command: new RegisterCommand(copy)]
	}

	@Override
	def register(RegisterCommand command) {
		def conf = SpringSecurityUtils.securityConfig
		println "RC:" + command
		def session = SessionUtils.getSession()
		println "session source: "+session?.Source
		boolean isWebApp = false
		if(session?.Source =="WebApp"){
			isWebApp = true
		}
		
		if(command.email == null){
			if(isWebApp){
				flash.error = message(code: 'registerCommand.email.nullable')
				String postUrl = "${request.contextPath}${conf.apf.filterProcessesUrl}"
				render view: '/login/auth', model: [postUrl:postUrl]
				return
			}
			else{
				render(text:message(code: 'registerCommand.email.nullable'))
				return
			}
		}
		
		
		if(!command.username)
			command.username = command.email
		println "username: "+command.username
		println "email: "+command.email

		if (command.hasErrors()) {
			command.errors.each {
				println "ERROR: "+it
				if(!isWebApp){
					def msg = it.getFieldError('username')?.code
					if(msg == null)
						msg = it.getFieldError('password')?.code
					if(msg == null)
						msg = it.getFieldError('password2')?.code
					if(msg != null){
						render(text:message(code: msg))
						return
				}
			}
		}
			if(isWebApp){
				String postUrl = "${request.contextPath}${conf.apf.filterProcessesUrl}"
				render view: '/login/auth', model: [postUrl:postUrl, command: command]
				return
			}
		}
		println "No Error in RegisterCommand"
		String salt = saltSource instanceof NullSaltSource ? null : command.username
		def user = lookupUserClass().newInstance(email: command.email, username: command.username,
		accountLocked: false, enabled: true)

		RegistrationCode registrationCode = springSecurityUiService.register(user, command.password, salt)
		if (registrationCode == null || registrationCode.hasErrors()) {
			// null means problem creating the user
			if(isWebApp){
				flash.error = message(code: 'spring.security.ui.register.miscError')
				flash.chainedParams = params
				redirect action: 'index'
				return
			}
			else{
				render(text:message(code: 'spring.security.ui.register.miscError'))
				return
			}
		}

		//FIXME: remove later
		def UserRole = lookupUserRoleClass()
		def Role = lookupRoleClass()
		for (roleName in conf.ui.register.defaultRoleNames) {
			UserRole.create user, Role.findByAuthority(roleName)
			println "created rolename: "+roleName
		}

		springSecurityService.reauthenticate user.username

		if(isWebApp){
			flash.message = message(code: 'spring.security.ui.register.complete')
			redirect (controller: 'secUser', action: 'showHomePage')
		}
		else{
			render(text:1)//message(code: 'spring.security.ui.register.complete'))
			return
		}
		//				String url = generateLink('verifyRegistration', [t: registrationCode.token])

		//				def conf = SpringSecurityUtils.securityConfig
		//				def body = conf.ui.register.emailBody
		//				if (body.contains('$')) {
		//					body = evaluate(body, [user: user, url: url])
		//				}
		//				mailService.sendMail {
		//					to command.email
		//					from conf.ui.register.emailFrom
		//					subject conf.ui.register.emailSubject
		//					html body.toString()
		//				}

		//				render view: 'index', model: [emailSent: true]
	}

}
