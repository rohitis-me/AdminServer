/**
 * 
 */
package i2i.AdminServer

import grails.validation.Validateable


/**
 * @author Rohit
 *
 */

@Validateable
class OrderStatusCommand {
	String brandName
	String brandId
	String inventoryId
	String storeId
	String storeName
	String storePhoneNumber
	String storeAddressLine1
	String storeAddressLine2
	String storeCircle
	String storeCity
	String storeState
	String name
	byte orderStatus
	Date estimatedDeliveryTime
	long orderId
	int quantity
	String trackingId
	String offerCode
	
	static constraints = {
		name nullable:false, blank:false,size:1..100
		brandName nullable:false, blank:false,size:3..100
		brandId nullable:true, blank:true,size:3..100
		inventoryId nullable:true, blank:true,size:1..100
		storeId nullable:false, blank:false,size:3..100
		storeName nullable:false, blank:false,size:1..100
		storeEmailID nullable:true, blank:true,size:3..100
		storeAddressLine1 nullable:false, blank:false,size:1..100
		storeAddressLine2 nullable:false, blank:false,size:3..100
		storeCity nullable:false, blank:false,size:3..100
		storeCircle nullable:false, blank:false,size:3..100
		storeState nullable:false, blank:false,size:3..100
		trackingId nullable:true, blank:true,size:1..100
		offerCode nullable:true, blank:true,size:1..100
	}
}
