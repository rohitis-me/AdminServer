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
	String name
	String phoneNumber
	String emailID
	int age
	String addressLine1
	String addressLine2
	String circle
	String city
	String state
	String country
	String trackingId
	byte orderStatus
	Date estimatedDeliveryTime
	long orderId
	int quantity
	boolean isEmergencyDeliveryNeeded
	byte deliveryHours
	String offerCode
	
	static constraints = {
		name nullable:false, blank:false,size:1..100
		phoneNumber nullable:false, blank:false,size:3..100
		emailID nullable:true, blank:true,size:3..100
		addressLine1 nullable:false, blank:false,size:1..100
		addressLine2 nullable:true, blank:true,size:3..100
		city nullable:false, blank:false,size:3..100
		circle nullable:false, blank:false,size:3..100
		state nullable:false, blank:false,size:3..100
		storeId nullable:false, blank:false,size:1..100
		trackingId nullable:true, blank:true,size:1..100
		offerCode nullable:true, blank:true,size:1..100/*, validator: { value, command ->
			if (value) {
				if (!value.equals('PH137') || !value.equals('AP137') || !value.equals('SM137') || !value.equals('CS137') || !value.equals('HS137')) {
					return false//'Coupon code entered is invalid. Click "Continue" to confirm order anyway. Click "Retry" to enter coupon code again'
				}
			}
		}*/
	}
}
