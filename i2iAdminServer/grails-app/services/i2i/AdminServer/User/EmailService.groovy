package i2i.AdminServer.User

import grails.transaction.Transactional

@Transactional
class EmailService {

	def mailService
	
	def serviceMethod() {
	}

	def sendEMail(String from, String to, String msg){
		println "in email service: "+params
		
		mailService.sendMail {
			to to
			from from
			subject "Feedback@i2i"
			body msg
		}
	}
}
