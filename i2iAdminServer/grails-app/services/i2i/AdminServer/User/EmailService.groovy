package i2i.AdminServer.User

import grails.transaction.Transactional
import i2i.AdminServer.OrderDetailsCommand
import i2i.AdminServer.Constants

@Transactional
class EmailService {

	def mailService
	def grailsApplication
	
	def serviceMethod() {
	}

	def sendEMail(String toAdd, String mailSubject, String msg){
		
		if(grailsApplication.config.env == Constants.env_DEMO)
		mailSubject = Constants.env_DEMO+' '+mailSubject
		
		try {
		mailService.sendMail {
			to toAdd
			subject mailSubject
			body msg
		}
		}
		catch(Exception exp) {
			println "Exception: "+exp.getRootCause()+"\n"+exp.getStackTrace()
		}
		println "SENT MAIL"
	}
	
	def sendOrderMail(String toAdd, String mailSubject, OrderDetailsCommand orderDetails){
		println "In send order Mail: "+orderDetails.properties
		
		if(grailsApplication.config.env == Constants.env_DEMO)
		mailSubject = Constants.env_DEMO+' '+mailSubject
		
		try {
		
			if(toAdd) {
			mailService.sendMail {
			to toAdd
			bcc Constants.adminEmail
			subject mailSubject
			body( view:"/mail/orderMail",
				model:[orderDetails:orderDetails])
		}
			}
			else
			{
				mailService.sendMail {
					to Constants.adminEmail
					subject mailSubject
					body( view:"/mail/orderMail",
						model:[orderDetails:orderDetails])
				}
			}
			println "SENT MAIL"
		}
		catch(Exception exp) {
			println "Exception: "+exp
			println "MAIL NOT SENT"
		}
		
	}
}
