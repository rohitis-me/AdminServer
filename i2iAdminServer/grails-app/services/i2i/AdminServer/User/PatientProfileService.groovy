package i2i.AdminServer.User

import grails.transaction.Transactional
import i2i.AdminServer.OrderDetailsCommand

@Transactional
class PatientProfileService {

    def serviceMethod() {

    }
	
	def populatePatientProfileFromOrderDetailsCommand(OrderDetailsCommand order) {
		def patientProfile = new PatientProfile()
		patientProfile.name = order.name
		patientProfile.phoneNumber = order.phoneNumber
		patientProfile.emailID = order.emailID
		patientProfile.age = order.age
		patientProfile.addressLine1 = order.addressLine1
		patientProfile.addressLine2 = order.addressLine2
		patientProfile.circle = order.circle
		patientProfile.city = order.city
		patientProfile.state = order.state
		patientProfile.country = order.country
	}
	
	def saveOrder(OrderDetailsCommand order) {
		return 1
	}
	
}
