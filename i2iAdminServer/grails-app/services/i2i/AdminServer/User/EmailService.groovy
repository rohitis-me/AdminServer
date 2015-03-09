package i2i.AdminServer.User

import grails.transaction.Transactional

@Transactional
class EmailService {

	def mailService
	
	def serviceMethod() {
	}

	def sendEMail(String toAdd, String mailSubject, String msg){
		try {
		mailService.sendMail {
			to toAdd
			subject mailSubject
			body msg
		}
		}
		catch(Exception exp) {
			println "Exception: "+exp.getRootCause()
		}
		println "SENT MAIL"
	}
}
