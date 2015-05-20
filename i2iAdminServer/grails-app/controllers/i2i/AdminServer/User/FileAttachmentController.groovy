package i2i.AdminServer.User



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

//@Transactional(readOnly = true)
class FileAttachmentController {
	def aws
	
	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index = {
	}

	def uploadWithDefaultProperties = {
		println "file upload" + params
		
		def fileToUpload = "/Users/ChandU/Desktop/pharmas/Adyar.png" 
		def uploadedFile = new File(fileToUpload).s3upload {path "test/" }

		render """${uploadedFile.source.toString()} <br /><br />${uploadedFile.url()}"""
	}

	def uploadFromInputStream = {

		def file = request.getFile('photo')
		def uploadedFile = file.inputStream.s3upload("file-name-${System.currentTimeMillis()}.jpg") { bucket "file-upload-from-inputstream" }

		render uploadedFile.source.toString()
	}

	def deleteUploadedFile = {

		def bucket = params.bucket
		def file = params.file
		def path = params.path

		aws.s3().on(bucket).delete(file, path)

		render "Deleted file ${file} (path '${path}') of bucket ${bucket}"
	}



	def show(FileAttachment fileAttachmentInstance) {
		respond fileAttachmentInstance
	}

	def create() {
		respond new FileAttachment(params)
	}

	@Transactional
	def save(FileAttachment fileAttachmentInstance) {
		if (fileAttachmentInstance == null) {
			notFound()
			return
		}

		if (fileAttachmentInstance.hasErrors()) {
			respond fileAttachmentInstance.errors, view:'create'
			return
		}

		fileAttachmentInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'fileAttachment.label', default: 'FileAttachment'),
					fileAttachmentInstance.id
				])
				redirect fileAttachmentInstance
			}
			'*' { respond fileAttachmentInstance, [status: CREATED] }
		}
	}

	def edit(FileAttachment fileAttachmentInstance) {
		respond fileAttachmentInstance
	}

	@Transactional
	def update(FileAttachment fileAttachmentInstance) {
		if (fileAttachmentInstance == null) {
			notFound()
			return
		}

		if (fileAttachmentInstance.hasErrors()) {
			respond fileAttachmentInstance.errors, view:'edit'
			return
		}

		fileAttachmentInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'FileAttachment.label', default: 'FileAttachment'),
					fileAttachmentInstance.id
				])
				redirect fileAttachmentInstance
			}
			'*'{ respond fileAttachmentInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(FileAttachment fileAttachmentInstance) {

		if (fileAttachmentInstance == null) {
			notFound()
			return
		}

		fileAttachmentInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'FileAttachment.label', default: 'FileAttachment'),
					fileAttachmentInstance.id
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
					message(code: 'fileAttachment.label', default: 'FileAttachment'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
