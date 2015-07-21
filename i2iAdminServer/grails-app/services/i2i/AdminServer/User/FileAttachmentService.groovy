package i2i.AdminServer.User

import grails.transaction.Transactional
import i2i.AdminServer.Constants

@Transactional
class FileAttachmentService {

	def serviceMethod() {
	}

	def saveFileAttachment(String name, String path, Date dateUploaded) {
//		println ""+ message(code: 'email.subject.feedback')
		
		FileAttachment attachment = new FileAttachment()
		attachment.name = name
		attachment.path = path
		attachment.dateUploaded = dateUploaded
		
		println "attachment: "+attachment.properties
		if(attachment && attachment.save()) {
			println "attachment save success "+attachment.attachmentId
			return attachment.attachmentId
		}
		else {
			attachment.errors.each { println "Error saving attachment: "+it }
			return 0
		}
	}
	
	def getAttachmentLinkFromAttachmentId(def attachmentId)
	{
		println "AID "+ attachmentId
		FileAttachment attachment = FileAttachment.findByAttachmentId(attachmentId)
		String link = Constants.amazonS3Link+Constants.amazonS3Bucket+'/'+attachment.path
		return link
	}
}
