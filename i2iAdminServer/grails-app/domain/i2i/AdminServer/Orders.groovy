package i2i.AdminServer

class Orders {

	String personId
	String brandId
	String inventoryId
	String storeId
	Byte orderStatus
	Date estimatedDeliveryTime
	Long orderId
	String uId
	int quantity
	
    static constraints = {
		personId nullable:false, blank:false,size:1..100
		brandId nullable:true, blank:true,size:1..100
		inventoryId nullable:true, blank:true,size:1..100
		storeId nullable:false, blank:false,size:1..100
		estimatedDeliveryTime nullable:true, blank:true
		uId nullable:false, blank:false,size:1..100
	}
	
	static mapping = {
		table 'orders_tbl'
		id name: 'orderId', column: 'order_id'
	}
}
