package i2i.AdminServer.User

import grails.transaction.Transactional


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
			println "attachment save success"
			return 1
		}
		else {
			attachment.errors.each { println "Error saving attachment: "+it }
			return 0
		}
	}
}
