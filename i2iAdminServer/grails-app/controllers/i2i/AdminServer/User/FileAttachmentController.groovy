package i2i.AdminServer.User



import static org.springframework.http.HttpStatus.*
import grails.plugin.awssdk.AmazonWebService
import grails.transaction.Transactional
import org.springframework.web.multipart.commons.CommonsMultipartFile
import com.amazonaws.services.s3.model.*
import com.amazonaws.services.s3.transfer.*
//import com.dto.UploadRequest

//@Transactional(readOnly = true)
class FileAttachmentController {
	AmazonWebService amazonWebService

	//	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index = {
	}

	def uploadFile(){
		println "in upload file" + params
//		List buckets
		CommonsMultipartFile file = request.getFile('inputFile')
		try {
			ObjectMetadata objectMetadata = new ObjectMetadata();
			objectMetadata.setContentLength(file.getInputStream().available())
			objectMetadata.setContentType(file.getContentType())
			
			Upload upload = amazonWebService.transferManager.upload(new PutObjectRequest('testi2i', 'test/testupload2.jpg',file.getInputStream(),objectMetadata ))
			
			while (!upload.done) {
				 println "Transfer: $upload.description"
				 println "  - State: $upload.state"
				 println "  - Progress: $upload.progress.bytesTransfered"
				 // Do work while we wait for our upload to complete…
				 Thread.sleep(500)
			}
			
//			buckets = amazonWebService.s3.listBuckets()
			//amazonWebService.s3.putObject(new PutObjectRequest('testi2i', 'order_prescription/testupload.jpg', file).withCannedAcl(CannedAccessControlList.PublicRead))
			
			redirect (controller: "orders", action: "showOrderStatus", params: [trackingId:params.trackingId, offerCode:params.offerCode])
		}
		catch (Exception exp) {
			println "Exception: "+exp
			redirect (controller: "fileAttachment", action: "index")
		}
		println "count"+ buckets.size()
		
		
	}

	//	def uploadWithDefaultProperties = {
	//		println "file upload" + params
	//
	//		def fileToUpload = "/Users/ChandU/Desktop/pharmas/Adyar.png"
	//		def uploadedFile = new File(fileToUpload).s3upload {path "testi2i/" }
	//
	//		render """${uploadedFile.source.toString()} <br /><br />${uploadedFile.url()}"""
	//	}
	//
	//	def uploadFromInputStream = {
	//		println "file input" + params
	//		def file = request.getFile('inputFile')
	//		println "file upload" + file
	//		def uploadedFile = file.inputStream.s3upload(file.originalFilename) { path "pictures/" }
	//
	//		render uploadedFile.source.toString()
	//	}

	//	def deleteUploadedFile = {
	//
	//		def bucket = params.bucket
	//		def file = params.file
	//		def path = params.path
	//
	//		aws.s3().on(bucket).delete(file, path)
	//
	//		render "Deleted file ${file} (path '${path}') of bucket ${bucket}"
	//	}



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
