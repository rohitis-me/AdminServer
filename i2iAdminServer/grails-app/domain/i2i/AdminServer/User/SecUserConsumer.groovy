package i2i.AdminServer.User

class SecUserConsumer {

	String patientId
	Long userId
	
    static constraints = {
		patientId nullable:false, blank:false
		userId nullable:false, blank:false
    }
}
