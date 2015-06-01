package i2i.AdminServer.User



import static org.springframework.http.HttpStatus.*

import java.util.Date;

import grails.plugin.awssdk.AmazonWebService
import grails.transaction.Transactional

import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.amazonaws.services.s3.model.*
import com.amazonaws.services.s3.transfer.*

import i2i.AdminServer.OrderDetailsCommand;
import i2i.AdminServer.Util.Utility
import i2i.AdminServer.Constants

//@Transactional(readOnly = true)
class FileAttachmentController {
	AmazonWebService amazonWebService
	FileAttachmentService fileAttachmentService

	//	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index(OrderDetailsCommand orderDetailsCommand){
		println "in file attachment: ODC: "+ orderDetailsCommand.properties
		String prescriptionUpload = params.prescriptionUploadOption
		println "prescrioption option "+prescriptionUpload
		if(prescriptionUpload == '0') {
			redirect (controller: "orders", action: "saveOrder", params:[brandName: orderDetailsCommand?.brandName,brandId : orderDetailsCommand?.brandId, inventoryId: orderDetailsCommand?.inventoryId, storeId:orderDetailsCommand?.storeId, name:orderDetailsCommand?.name, phoneNumber:orderDetailsCommand?.phoneNumber,
				emailID:orderDetailsCommand?.emailID, age:orderDetailsCommand?.age, addressLine1:orderDetailsCommand?.addressLine1, addressLine2:orderDetailsCommand?.addressLine2,circle:orderDetailsCommand?.circle,city:orderDetailsCommand?.city,state:orderDetailsCommand?.state,
				country:orderDetailsCommand?.country,trackingId:orderDetailsCommand?.trackingId,orderStatus:orderDetailsCommand?.orderStatus,
				estimatedDeliveryTime:orderDetailsCommand?.estimatedDeliveryTime,quantity:orderDetailsCommand?.quantity,isEmergencyDeliveryNeeded:orderDetailsCommand?.isEmergencyDeliveryNeeded, deliveryHours:orderDetailsCommand?.deliveryHours, offerCode:orderDetailsCommand?.offerCode, attachmentId:orderDetailsCommand?.attachmentId])
		}
		if (!orderDetailsCommand || orderDetailsCommand?.hasErrors()) {
			render view: '/patientProfile/deliveryDetails', model: [orderDetails: orderDetailsCommand]
//			redirect(controller: 'patientProfile', action: 'deliveryDetails', params:params)
			return
		}
		
		render(view: "index", model: [orderDetails: orderDetailsCommand])
	}

	def uploadFile(OrderDetailsCommand orderDetailsCommand){
		println "in upload file" + params
		//		List buckets
		CommonsMultipartFile file = request.getFile('inputFile')
		println "size " + file.getSize()
		if(file.isEmpty()) {
			flash.message = "File cannot be empty"
//			redirect (controller: "fileAttachment", action: "index", params:[orderDetailsCommand:orderDetailsCommand, prescriptionUploadOption: '1'])
			redirect (controller: "fileAttachment", action: "index", params:[ prescriptionUploadOption: '1', brandName: orderDetailsCommand?.brandName,brandId : orderDetailsCommand?.brandId, inventoryId: orderDetailsCommand?.inventoryId, storeId:orderDetailsCommand?.storeId, name:orderDetailsCommand?.name, phoneNumber:orderDetailsCommand?.phoneNumber,
				emailID:orderDetailsCommand?.emailID, age:orderDetailsCommand?.age, addressLine1:orderDetailsCommand?.addressLine1, addressLine2:orderDetailsCommand?.addressLine2,circle:orderDetailsCommand?.circle,city:orderDetailsCommand?.city,state:orderDetailsCommand?.state,
				country:orderDetailsCommand?.country,trackingId:orderDetailsCommand?.trackingId,orderStatus:orderDetailsCommand?.orderStatus,
				estimatedDeliveryTime:orderDetailsCommand?.estimatedDeliveryTime,quantity:orderDetailsCommand?.quantity,isEmergencyDeliveryNeeded:orderDetailsCommand?.isEmergencyDeliveryNeeded, deliveryHours:orderDetailsCommand?.deliveryHours, offerCode:orderDetailsCommand?.offerCode, attachmentId:orderDetailsCommand?.attachmentId])
		}
		else if(file.getSize() > 10*1000000)
		{
			flash.message = "File size cannot exceed 10 MB"
//			redirect (controller: "fileAttachment", action: "index", params:[orderDetailsCommand:orderDetailsCommand,prescriptionUploadOption:'1'])
			redirect (controller: "fileAttachment", action: "index", params:[prescriptionUploadOption:'1', brandName: orderDetailsCommand?.brandName,brandId : orderDetailsCommand?.brandId, inventoryId: orderDetailsCommand?.inventoryId, storeId:orderDetailsCommand?.storeId, name:orderDetailsCommand?.name, phoneNumber:orderDetailsCommand?.phoneNumber,
				emailID:orderDetailsCommand?.emailID, age:orderDetailsCommand?.age, addressLine1:orderDetailsCommand?.addressLine1, addressLine2:orderDetailsCommand?.addressLine2,circle:orderDetailsCommand?.circle,city:orderDetailsCommand?.city,state:orderDetailsCommand?.state,
				country:orderDetailsCommand?.country,trackingId:orderDetailsCommand?.trackingId,orderStatus:orderDetailsCommand?.orderStatus,
				estimatedDeliveryTime:orderDetailsCommand?.estimatedDeliveryTime,quantity:orderDetailsCommand?.quantity,isEmergencyDeliveryNeeded:orderDetailsCommand?.isEmergencyDeliveryNeeded, deliveryHours:orderDetailsCommand?.deliveryHours, offerCode:orderDetailsCommand?.offerCode, attachmentId:orderDetailsCommand?.attachmentId])
		}
		else {
			try {
				
//				List buckets = amazonWebService.s3.listBuckets()
//				buckets.each { Bucket bucket ->
//					println "bucketName: ${bucket.name}, creationDate: ${bucket.creationDate}"
//				}
				
				ObjectMetadata objectMetadata = new ObjectMetadata();
				objectMetadata.setContentLength(file.getInputStream().available())
				objectMetadata.setContentType(file.getContentType())

				String fileOriginalName = file.getOriginalFilename()
				Date uploadDate = Utility.getDateTimeInIST().getTime()
				String filePath = 'order_prescription/'+uploadDate.getTime()+'-'+fileOriginalName
				println "file name: "+filePath
				Upload upload = amazonWebService.transferManager.upload(new PutObjectRequest(Constants.amazonS3Bucket,filePath,file.getInputStream(),objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead))

				while (!upload.done) {
//					println "Transfer: $upload.description"
//					println "  - State: $upload.state"
//					println "  - Progress: $upload.progress.bytesTransfered"
//					// Do work while we wait for our upload to complete…
//					Thread.sleep(1000)
				}

				println "upload success: "+ upload
				String fileLocation = Constants.amazonS3Link+Constants.amazonS3Bucket+'/'+filePath
				println "file link: "+fileLocation
				def attachmentId = fileAttachmentService.saveFileAttachment(fileOriginalName, filePath, uploadDate)

				if(attachmentId == 0)
					flash.message = message(code: 'fileAttachment.not.saved.message', default: 'Error in processing your request. Please try again!')
				else
					flash.message = message(code: 'fileAttachment.saved.success.message', default: 'Your prescription has been uploaded successfully!')

				orderDetailsCommand?.attachmentId = attachmentId
				redirect (controller: "orders", action: "saveOrder", params:[brandName: orderDetailsCommand?.brandName,brandId : orderDetailsCommand?.brandId, inventoryId: orderDetailsCommand?.inventoryId, storeId:orderDetailsCommand?.storeId, name:orderDetailsCommand?.name, phoneNumber:orderDetailsCommand?.phoneNumber,
						emailID:orderDetailsCommand?.emailID, age:orderDetailsCommand?.age, addressLine1:orderDetailsCommand?.addressLine1, addressLine2:orderDetailsCommand?.addressLine2,circle:orderDetailsCommand?.circle,city:orderDetailsCommand?.city,state:orderDetailsCommand?.state, 
						country:orderDetailsCommand?.country,trackingId:orderDetailsCommand?.trackingId,orderStatus:orderDetailsCommand?.orderStatus,
						estimatedDeliveryTime:orderDetailsCommand?.estimatedDeliveryTime,quantity:orderDetailsCommand?.quantity,isEmergencyDeliveryNeeded:orderDetailsCommand?.isEmergencyDeliveryNeeded, deliveryHours:orderDetailsCommand?.deliveryHours, offerCode:orderDetailsCommand?.offerCode, attachmentId:orderDetailsCommand?.attachmentId])
			}
			catch (Exception exp) {
				println "Exception: "+exp
				flash.message = message(code: 'fileAttachment.not.saved.message', default: 'Error in processing your request. Please try again!')
//				redirect (controller: "fileAttachment", action: "index",  params:[orderDetailsCommand:orderDetailsCommand, prescriptionUploadOption:'1'])
				redirect (controller: "fileAttachment", action: "index", params:[prescriptionUploadOption:'1', brandName: orderDetailsCommand?.brandName,brandId : orderDetailsCommand?.brandId, inventoryId: orderDetailsCommand?.inventoryId, storeId:orderDetailsCommand?.storeId, name:orderDetailsCommand?.name, phoneNumber:orderDetailsCommand?.phoneNumber,
					emailID:orderDetailsCommand?.emailID, age:orderDetailsCommand?.age, addressLine1:orderDetailsCommand?.addressLine1, addressLine2:orderDetailsCommand?.addressLine2,circle:orderDetailsCommand?.circle,city:orderDetailsCommand?.city,state:orderDetailsCommand?.state,
					country:orderDetailsCommand?.country,trackingId:orderDetailsCommand?.trackingId,orderStatus:orderDetailsCommand?.orderStatus,
					estimatedDeliveryTime:orderDetailsCommand?.estimatedDeliveryTime,quantity:orderDetailsCommand?.quantity,isEmergencyDeliveryNeeded:orderDetailsCommand?.isEmergencyDeliveryNeeded, deliveryHours:orderDetailsCommand?.deliveryHours, offerCode:orderDetailsCommand?.offerCode, attachmentId:orderDetailsCommand?.attachmentId])
				}
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
