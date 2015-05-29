package i2i.AdminServer.User



import static org.springframework.http.HttpStatus.*
import grails.plugin.awssdk.AmazonWebService
import grails.transaction.Transactional
import org.springframework.web.multipart.commons.CommonsMultipartFile
import com.amazonaws.services.s3.model.*
import com.amazonaws.services.s3.transfer.*
import i2i.AdminServer.Util.Utility

//@Transactional(readOnly = true)
class FileAttachmentController {
	AmazonWebService amazonWebService
	FileAttachmentService fileAttachmentService
	//	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index = {
	}

	def uploadFile(){
		println "in upload file" + params
		//		List buckets
		CommonsMultipartFile file = request.getFile('inputFile')
		if(file.isEmpty()) {
			flash.message = "File cannot be empty"
		}
		else {
			try {
				ObjectMetadata objectMetadata = new ObjectMetadata();
				objectMetadata.setContentLength(file.getInputStream().available())
				objectMetadata.setContentType(file.getContentType())

				String fileOriginalName = file.getOriginalFilename()
				String bucketName = 'testi2i'
				Date uploadDate = Utility.getDateTimeInIST().getTime()
				def uId = '1235'
				String fileName = ''+uId+'-'+uploadDate.getTime()+'.png'
				println "file name: "+'order_prescription/'+fileName
				Upload upload = amazonWebService.transferManager.upload(new PutObjectRequest(bucketName,'order_prescription/'+fileName,file.getInputStream(),objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead))

				while (!upload.done) {
					println "Transfer: $upload.description"
					println "  - State: $upload.state"
					println "  - Progress: $upload.progress.bytesTransfered"
					// Do work while we wait for our upload to complete…
					Thread.sleep(500)
				}

				println "upload success: "+ upload
				String fileLocation = "https://s3-ap-southeast-1.amazonaws.com/"+bucketName+"/order_prescription/"+fileName
				def status = fileAttachmentService.saveFileAttachment(fileOriginalName, fileLocation, uploadDate)

				if(status == 0)
					flash.message = message(code: 'fileAttachment.not.saved.message', default: 'Error in processing your request. Please try again!')
				else
					flash.message = message(code: 'fileAttachment.saved.success.message', default: 'Your feedback has been recorded. Thanks!')

				//			buckets = amazonWebService.s3.listBuckets()
				//amazonWebService.s3.putObject(new PutObjectRequest('testi2i', 'order_prescription/testupload.jpg', file).withCannedAcl(CannedAccessControlList.PublicRead))

				redirect (controller: "orders", action: "showOrderStatus")
			}
			catch (Exception exp) {
				println "Exception: "+exp
				redirect (controller: "fileAttachment", action: "index")
			}
			//			println "count"+ buckets.size()
		}

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
