package i2i.AdminServer

class BrandOrdered extends com.metasieve.shoppingcart.Shoppable {

	String brandName
	String inventoryId
	String brandId
	String storeId
	
    static constraints = {
		inventoryId nullable: true; blank:true
		brandId nullable: true, blank:true
    }
	
	@Override
	String toString() {
	  return brandName
	}
}
