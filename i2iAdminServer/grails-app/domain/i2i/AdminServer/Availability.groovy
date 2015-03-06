package i2i.AdminServer

class Availability {
	String storeId
	String brandId
	Byte availabilityIndex
	Long availabilityId

    static constraints = {
		storeId nullable:false, blank:false,size:3..100
		brandId nullable:false, blank:false,size:1..100
    }
	
	static mapping = {
		table 'availability_tbl'
		id name: 'availabilityId', column: 'availability_id'
	}
}
