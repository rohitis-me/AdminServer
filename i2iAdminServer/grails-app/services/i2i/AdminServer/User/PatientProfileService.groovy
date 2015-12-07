package i2i.AdminServer.User

import grails.transaction.Transactional
import i2i.AdminServer.OrderCollectionCommand

@Transactional
class PatientProfileService {

	def secUserService
	
    def serviceMethod() {

    }
	
	def getPatientProfileDataFromPatientProfileId(String patientId) {
		PatientProfile patientProfile = PatientProfile.findByPatientId(patientId)
	}
	
	def populatePatientProfileFromOrderCollCommand(OrderCollectionCommand order) {
		def patientProfile = new PatientProfile()
		patientProfile.name = order.patientName
		patientProfile.doctorName = order.doctorName
		patientProfile.phoneNumber = order.phoneNumber
		patientProfile.emailID = order.emailID
		patientProfile.age = order.age
		patientProfile.addressLine1 = order.addressLine1
		patientProfile.addressLine2 = order.addressLine2
		patientProfile.circle = order.circle
		patientProfile.city = order.city
		patientProfile.state = order.state
		patientProfile.country = order.country
		return patientProfile
	}
	
	//FIXME
	def savePatientProfile(PatientProfile patientProfile) {

//		try {		
		
			println "patientProfile: "+patientProfile.properties
			if(patientProfile.save()) {
				println "PP save success"
				def patientId = patientProfile.patientId
				def userId = secUserService.getLoggedInUserId()
				if(userId != 0) new SecUserConsumer(patientId:patientId, userId: userId).save(flush:true)
				return patientId
		}
		else {
			patientProfile.errors.each {
				println "Error saving patientProfile: "+it
			}
			return 0
		}
//		}
//		catch(exp) {
//			println "exception in savePatient: "+exp.getRootCause().getMessage()+" \n"
//			throw exp
//			//exp.printStackTrace()
//		}
	}
	
	//FIXME: THis should not be here
//	def saveOrder(OrderDetailsCommand order) {
//		return 1
//	}
	
}
