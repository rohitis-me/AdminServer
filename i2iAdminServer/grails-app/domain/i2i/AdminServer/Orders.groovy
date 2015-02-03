package i2i.AdminServer

class Orders {

	String personId
	String brandId
	String storeId
	byte orderStatus
	Date estimatedDeliveryTime
	Long orderId
	
    static constraints = {
		personId nullable:false, blank:false,size:1..100
		brandId nullable:false, blank:false,size:1..100
		storeId nullable:false, blank:false,size:1..100
		estimatedDeliveryTime nullable:true, blank:true
    }
	
	static mapping = {
		table 'orders_tbl'
		id name: 'orderId', column: 'order_id'
	}
}
