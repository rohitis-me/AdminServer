/**
 * 
 */
package i2i.AdminServer

import grails.validation.Validateable


/**
 * @author Chandu
 *
 */

@Validateable
class CartItemCommand {
	String brandName
	String inventoryId
	String brandId
	String storeId
	int quantity

	static constraints = {
		inventoryId nullable: true; blank:true
		brandId nullable: true, blank:true
	}

	public CartItemCommand(String brandName, String inventoryId,
		String brandId, String storeId, int quantity) {
		super();
		this.brandName = brandName;
		this.inventoryId = inventoryId;
		this.storeId = storeId;
		this.brandId = brandId;
		this.quantity = quantity;
	}
}
