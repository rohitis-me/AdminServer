package i2i.AdminServer.User

import grails.transaction.Transactional


@Transactional
class FeedbackService {

	def serviceMethod() {
	}

	def saveFeedback(String name, String email, String message) {
//		println ""+ message(code: 'email.subject.feedback')
		
		Feedback feedback = new Feedback()
		feedback.name = name
		feedback.emailID = email
		feedback.message = message
		
		println "feedback: "+feedback.properties
		if(feedback && feedback.save()) {
			println "feedback save success"
			return 1
		}
		else {
			feedback.errors.each { println "Error saving patientProfile: "+it }
			return 0
		}
	}
}
