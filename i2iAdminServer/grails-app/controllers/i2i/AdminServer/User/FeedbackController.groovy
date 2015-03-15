package i2i.AdminServer.User



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import i2i.AdminServer.Constants

@Transactional(readOnly = true)
class FeedbackController {

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	EmailService emailService
	
	def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond Feedback.list(params), model:[feedbackInstanceCount: Feedback.count()]
	}

	def show(Feedback feedbackInstance) {
		respond feedbackInstance
	}

	def create() {
		respond new Feedback(params)
	}

	def feedback(){
	}

	def sendFeedback(){
		println "PARAMS: "+params
		
		emailService.sendEMail (
			Constants.supportEmail,
			message(code: 'email.subject.feedback'),
			params.message)

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'feedback.received.message', default: 'Thanks for your feedback!')
				//redirect storeInstance
			}
		}
			
		render(view:'feedback')
	}

	@Transactional
	def save(Feedback feedbackInstance) {
		if (feedbackInstance == null) {
			notFound()
			return
		}

		if (feedbackInstance.hasErrors()) {
			respond feedbackInstance.errors, view:'create'
			return
		}

		feedbackInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'feedback.label', default: 'Feedback'),
					feedbackInstance.id
				])
				redirect feedbackInstance
			}
			'*' { respond feedbackInstance, [status: CREATED] }
		}
	}

	def edit(Feedback feedbackInstance) {
		respond feedbackInstance
	}

	@Transactional
	def update(Feedback feedbackInstance) {
		if (feedbackInstance == null) {
			notFound()
			return
		}

		if (feedbackInstance.hasErrors()) {
			respond feedbackInstance.errors, view:'edit'
			return
		}

		feedbackInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'Feedback.label', default: 'Feedback'),
					feedbackInstance.id
				])
				redirect feedbackInstance
			}
			'*'{ respond feedbackInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(Feedback feedbackInstance) {

		if (feedbackInstance == null) {
			notFound()
			return
		}

		feedbackInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'Feedback.label', default: 'Feedback'),
					feedbackInstance.id
				])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [
					message(code: 'feedback.label', default: 'Feedback'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
