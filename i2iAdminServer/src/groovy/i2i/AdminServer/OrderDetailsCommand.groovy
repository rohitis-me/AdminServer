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
class OrderDetailsCommand {
	String brandName
	String brandId
	String inventoryId
	String storeId
//	String name
//	String phoneNumber
//	String emailID
//	int age
//	String addressLine1
//	String addressLine2
//	String circle
//	String city
//	String state
//	String country
	String trackingId
	byte orderStatus
	Date estimatedDeliveryTime
	long orderId
	int quantity
	boolean isEmergencyDeliveryNeeded
	byte deliveryHours
//	String offerCode
	Long orderCollectionId
	
	static constraints = {
		name nullable:false, blank:false,size:1..100
//		phoneNumber nullable:false, blank:false,size:3..100
//		emailID nullable:true, blank:true,size:3..100
//		addressLine1 nullable:false, blank:false,size:1..100
//		addressLine2 nullable:true, blank:true,size:3..100
//		city nullable:false, blank:false,size:3..100
//		circle nullable:false, blank:false,size:3..100
//		state nullable:false, blank:false,size:3..100
//		storeId nullable:true, blank:true,size:1..100
//		trackingId nullable:true, blank:true,size:1..100
//		offerCode nullable:true, blank:true,size:1..100
//		attachmentId nullable:true, blank:true,size:1..100
		orderCollectionId nullable:true, blank:true,size:1..100
	}
}
