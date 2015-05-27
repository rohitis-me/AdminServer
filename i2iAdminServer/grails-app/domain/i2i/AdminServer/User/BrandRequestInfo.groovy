package i2i.AdminServer.User

//@grails.validation.Validateable
class BrandRequestInfo {
	String brandName
	String emailID
	String phoneNumber
	String circle
	
	static constraints = {
		brandName nullable:false, blank:false,size:3..100
		circle nullable:false, blank:false,size:3..100
		emailID nullable:true, blank:true,size:3..100
		phoneNumber nullable:true, blank:true,size:3..100
	}
}
