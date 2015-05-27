/**
 * 
 */
package i2i.AdminServer.User

import grails.validation.Validateable;

/**
 * @author ChandU
 *
 */
@Validateable
class BrandRequestCommand {

	String brandName
	String emailID
	String phoneNumber
	String circle
	
	static constraints = {
		brandName nullable:false, blank:false,size:3..100
		circle nullable:false, blank:false,size:3..100
		emailID nullable:true, blank:true,size:3..100, validator: {value, command ->
                if ((command.phoneNumber == "" || command.phoneNumber == null) && (value == "" || value == null)) return 'brandRequestCommand.enter.email.or.phone.message'}
		phoneNumber nullable:true, blank:true,size:3..100, validator: {value, command ->
                if ((command.emailID == ""|| command.emailID == null) && (value == "" || value == null)) return 'brandRequestCommand.enter.email.or.phone.message'}
	}
	
}
