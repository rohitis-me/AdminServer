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
	String storeId
	String storeName
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
}
