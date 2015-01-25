package i2i.AdminServer

class Store {
	String storeId
	String storeName
	String addressLine1
	String addressLine2
	String circle
	String city
	String state
	String latitude
	String longitude
	
	
    static constraints = {
		storeId nullable:false, blank:false,size:1..100
		storeName nullable:false, blank:false,size:3..100
		addressLine1 nullable:false, blank:false,size:3..100
		addressLine2 nullable:false, blank:false,size:3..100
		circle nullable:false, blank:false,size:3..100
		city nullable:false, blank:false,size:1..100
		state nullable:false, blank:false,size:1..100
		latitude nullable:false, blank:false,size:1..100
		longitude nullable:false, blank:false,size:1..100
    }
}
