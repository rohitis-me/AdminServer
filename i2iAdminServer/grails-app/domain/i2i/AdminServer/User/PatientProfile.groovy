package i2i.AdminServer.User

class PatientProfile {

	Long patientId
	String name
	String phoneNumber
	String emailID
	int age
	String addressLine1
	String addressLine2
	String circle
	String city
	String state
	String country
	
    static constraints = {
		name nullable:false, blank:false,size:1..100
		phoneNumber nullable:false, blank:false,size:3..100
		emailID nullable:true, blank:true,size:3..100
		addressLine1 nullable:false, blank:false,size:1..100
		addressLine2 nullable:false, blank:false,size:3..100
		city nullable:false, blank:false,size:3..100
		circle nullable:false, blank:false,size:3..100
		state nullable:false, blank:false,size:3..100
    }
	
	static mapping = {
		table "patientprofile_tbl"
		id name: 'patientId', column: 'patient_id'
	}
}
