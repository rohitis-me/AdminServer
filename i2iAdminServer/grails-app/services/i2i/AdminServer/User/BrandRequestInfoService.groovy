package i2i.AdminServer.User

import grails.transaction.Transactional


@Transactional
class BrandRequestInfoService {

	def serviceMethod() {
	}

	def saveRequestedBrand(BrandRequestCommand brandRequestCommand) {
		println "brandRequestCommand: "+brandRequestCommand.properties
		
		BrandRequestInfo brandRequest = new BrandRequestInfo()
		brandRequest.brandName = brandRequestCommand.brandName
		brandRequest.emailID = brandRequestCommand.emailID
		brandRequest.phoneNumber = brandRequestCommand.phoneNumber
		brandRequest.circle = brandRequestCommand.circle
		
		println "brandRequest: "+brandRequest.properties
		if(brandRequest && brandRequest.save()) {
			println "brandRequest save success"
			return 1
		}
		else {
			brandRequest.errors.each { println "Error saving brandRequest: "+it }
			return 0
		}
	}
}
