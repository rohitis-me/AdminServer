package i2i.AdminServer.User

import org.codehaus.groovy.grails.validation.Validateable

/**
 * @author Chandu
 *
 */

@Validateable
class RegisterCommand {

	def secUserService
	
	String username
	String password
	String confirmPassword
	
	static constraints = {
		username nullable:false, blank:false,size:3..100
		password nullable:false, blank:false,size:5..15
		confirmPassword nullable:false, blank:false,size:5..15
		
        username validator: { val, obj ->
            obj.secUserService.canRegister(obj.username, obj.password, obj.confirmPassword)	}
	}
}
