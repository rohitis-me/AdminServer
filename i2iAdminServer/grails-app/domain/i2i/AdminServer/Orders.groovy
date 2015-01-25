package i2i.AdminServer

class Orders {

	String personId
	String brandId
	String storeId
	byte orderStatus
	
    static constraints = {
		personId nullable:false, blank:false,size:1..100
		brandId nullable:false, blank:false,size:1..100
		storeId nullable:false, blank:false,size:1..100
    }
}
