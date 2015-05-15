package i2i.AdminServer.User

class Feedback {
	String name
	String emailID
	String message
	
	static constraints = {
		name nullable:true, blank:true,size:1..100
		message nullable:false, blank:false,size:1..1000
		emailID nullable:true, blank:true,size:3..100
	}
}
