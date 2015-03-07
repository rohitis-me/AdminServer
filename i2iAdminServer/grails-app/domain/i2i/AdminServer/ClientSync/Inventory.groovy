package i2i.AdminServer.ClientSync

class Inventory {

	String inventoryId
	String brandId
	String storeId
	double mrp
	int quantity
	int itemsPerUnit
	int itemsRemaining
	boolean isDeleted
	long lastUpdatedTimeStamp
	String brandName
	
	static constraints = {
		brandId nullable:true, blank:true
		storeId nullable:true, blank:true
		brandName nullable:true, blank:true
	}
	
	static mapping = {
		table 'inventory'
		id name: 'inventoryId', generator:'assigned'
	}
	
}
