package i2i.AdminServer

class Availability {
	String storeId
	String brandId
	byte availabilityIndex
	

    static constraints = {
		storeId nullable:false, blank:false,size:3..100
		brandId nullable:false, blank:false,size:1..100
    }
}
