/**
 * 
 */
package i2i.AdminServer.webservice

/**
 * @author Rohit2
 *
 */
class OrderDetail {

	List orderItemInfo = new ArrayList<OrderItemInfo>()
	byte orderStatus
	long orderCollectionId
	long collectionId = 0
	byte availabilityIndex
//	String storeId
}
