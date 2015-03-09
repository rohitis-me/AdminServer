package i2i.AdminServer

class Availability {
	String storeId
	String brandId
	String inventoryId
	Byte availabilityIndex
	Long availabilityId

    static constraints = {
		storeId nullable:false, blank:false,size:3..100
		brandId nullable:true, blank:true,size:1..100
		inventoryId nullable:true, blank:true,size:1..100
    }
	
	static mapping = {
		table 'availability_tbl'
		id name: 'availabilityId', column: 'availability_id'
	}
}
