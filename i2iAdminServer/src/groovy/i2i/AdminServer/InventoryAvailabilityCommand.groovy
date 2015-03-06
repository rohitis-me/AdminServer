package i2i.AdminServer

import grails.validation.Validateable;

@Validateable
class InventoryAvailabilityCommand {
	String storeId
	String brandId
	Byte availabilityIndex
	String brandName
	String strength
	String form
	Long availabilityId
}
