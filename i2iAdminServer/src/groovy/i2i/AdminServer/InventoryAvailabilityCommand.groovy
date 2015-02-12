package i2i.AdminServer

import grails.validation.Validateable;

@Validateable
class InventoryAvailabilityCommand {
	String storeId
	String brandId
	byte availabilityIndex
	String brandName
	String strength
	String form
}
