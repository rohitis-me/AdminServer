package i2i.AdminServer.User



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import i2i.AdminServer.Constants

//@Transactional(readOnly = true)
class BrandRequestInfoController {

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	BrandRequestInfoService brandRequestInfoService
	EmailService emailService
	
	def index(BrandRequestCommand brandRequestCommand) {
		println "PARAMS: "+params
		render (view:"index", model: [command:brandRequestCommand, brandName:brandRequestCommand?.brandName])
	}

	def requestNewBrand(BrandRequestCommand brandRequestCommand){
		println "BRC: "+brandRequestCommand.properties

		if (!brandRequestCommand || brandRequestCommand?.hasErrors()) {
			render (view:"index", model: [command:brandRequestCommand, brandName: brandRequestCommand?.brandName, showError:true])
			return
		}

		println "No errors"
		String body = "BrandName: "+brandRequestCommand?.brandName + "\nEmail: "+brandRequestCommand?.emailID+ "\nPhone: "+brandRequestCommand?.phoneNumber +"\nCircle: "+brandRequestCommand?.circle
		String toAdd = Constants.adminEmail + ","+ "adhirajalai@gmail.com"+","+ "chandu@i2itech.co.in"
		emailService.sendEMail (
				toAdd,
				message(code: 'email.subject.medicineRequest'),
				body)

		def status = brandRequestInfoService.saveRequestedBrand(brandRequestCommand)

		if(status == 0)
			flash.message = message(code: 'medicineRequest.fail.message', default: 'Error in processing your request. Please try again!')
		else
			flash.message = message(code: 'medicineRequest.success.message', default: 'Thanks for the information. We will inform you as per your contact details provided, as soon as the medicine is available')

		render(view:'index')
	}

	def show(BrandRequestInfo brandRequestInfoInstance) {
		respond brandRequestInfoInstance
	}

	def create() {
		respond new BrandRequestInfo(params)
	}

	@Transactional
	def save(BrandRequestInfo brandRequestInfoInstance) {
		if (brandRequestInfoInstance == null) {
			notFound()
			return
		}

		if (brandRequestInfoInstance.hasErrors()) {
			respond brandRequestInfoInstance.errors, view:'create'
			return
		}

		brandRequestInfoInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'brandRequestInfo.label', default: 'BrandRequestInfo'),
					brandRequestInfoInstance.id
				])
				redirect brandRequestInfoInstance
			}
			'*' { respond brandRequestInfoInstance, [status: CREATED] }
		}
	}

	def edit(BrandRequestInfo brandRequestInfoInstance) {
		respond brandRequestInfoInstance
	}

	@Transactional
	def update(BrandRequestInfo brandRequestInfoInstance) {
		if (brandRequestInfoInstance == null) {
			notFound()
			return
		}

		if (brandRequestInfoInstance.hasErrors()) {
			respond brandRequestInfoInstance.errors, view:'edit'
			return
		}

		brandRequestInfoInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'BrandRequestInfo.label', default: 'BrandRequestInfo'),
					brandRequestInfoInstance.id
				])
				redirect brandRequestInfoInstance
			}
			'*'{ respond brandRequestInfoInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(BrandRequestInfo brandRequestInfoInstance) {

		if (brandRequestInfoInstance == null) {
			notFound()
			return
		}

		brandRequestInfoInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'BrandRequestInfo.label', default: 'BrandRequestInfo'),
					brandRequestInfoInstance.id
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
					message(code: 'brandRequestInfo.label', default: 'BrandRequestInfo'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
