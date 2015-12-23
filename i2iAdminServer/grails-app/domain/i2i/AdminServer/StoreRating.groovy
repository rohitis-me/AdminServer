package i2i.AdminServer

class StoreRating {

	String storeId
	Integer rating
	
    static constraints = {
		storeId blank:false, nullable:false
		rating blank:false, nullable:false
    }
}
