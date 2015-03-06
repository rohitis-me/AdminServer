package i2i.AdminServer

class Store {
	String storeId
	String storeName
	String phoneNumber
	String addressLine1
	String addressLine2
	String circle
	String city
	String state
	String latitude
	String longitude
	
	
    static constraints = {
		storeId nullable:false, blank:false,size:3..100
		storeName nullable:false, blank:false,size:3..100
		phoneNumber nullable:false, blank:false,size:3..100
		addressLine1 nullable:false, blank:false,size:3..100
		addressLine2 nullable:false, blank:false,size:3..100
		circle nullable:false, blank:false,size:3..100
		city nullable:false, blank:false,size:1..100
		state nullable:false, blank:false,size:1..100
		latitude nullable:true, blank:true,size:1..100
		longitude nullable:true, blank:true,size:1..100
    }
	
	static mapping = {
		table "store_tbl"
		id name: 'storeId', column: 'store_id', generator: 'assigned'
	}
}
