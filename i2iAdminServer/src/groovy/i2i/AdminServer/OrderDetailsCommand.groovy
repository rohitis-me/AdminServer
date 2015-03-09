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
	byte orderStatus
	Date estimatedDeliveryTime
	long orderId
	int quantity
	boolean isEmergencyDeliveryNeeded
	
	static constraints = {
		name nullable:false, blank:false,size:1..100
		phoneNumber nullable:false, blank:false,size:3..100
		emailID nullable:true, blank:true,size:3..100
		addressLine1 nullable:false, blank:false,size:1..100
		addressLine2 nullable:false, blank:false,size:3..100
		city nullable:false, blank:false,size:3..100
		circle nullable:false, blank:false,size:3..100
		state nullable:false, blank:false,size:3..100
		storeId nullable:false, blank:false,size:1..100
	}
}
