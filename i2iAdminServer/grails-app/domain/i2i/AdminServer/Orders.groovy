package i2i.AdminServer

class Orders {

//	String personId//TODO: remove
	String brandId
	String inventoryId
	String storeId
	Byte orderStatus
	Date estimatedDeliveryTime
	Long orderId
	String uId
	int quantity
	boolean isEmergencyDeliveryNeeded
//	String offerCode//TODO: remove
//	Long attachmentId//TODO: remove
	Long orderCollectionId
	
    static constraints = {
//		personId nullable:true, blank:true,size:1..100
		brandId nullable:true, blank:true,size:1..100
		inventoryId nullable:true, blank:true,size:1..100
		storeId nullable:false, blank:false,size:1..100
		estimatedDeliveryTime nullable:true, blank:true
		uId nullable:false, blank:false,size:1..100
//		offerCode nullable:true, blank:true,size:1..100
//		attachmentId nullable:true, blank:true,size:1..100
		orderCollectionId nullable:false, blank:false,size:1..100
	}
	
	static mapping = {
		table 'orders_tbl'
		id name: 'orderId', column: 'order_id'
	}
}
